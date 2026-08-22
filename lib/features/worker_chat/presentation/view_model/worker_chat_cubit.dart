import 'dart:developer' as dev;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/cloud_storage_service/cloud_storage_service.dart';
import 'package:helpdesk_lite/core/utils/database_service/database_endpoints.dart';
import 'package:helpdesk_lite/core/utils/database_service/database_service.dart';
import 'package:helpdesk_lite/core/utils/file_picker_service/file_picker_service.dart';
import 'package:helpdesk_lite/core/utils/local_storage_service/user_hive_box.dart';
import 'package:helpdesk_lite/core/utils/shared_models/chat_message_model.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_attachment_item.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';
import 'package:helpdesk_lite/core/utils/supabase_service/Supabase_servic.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view_model/worker_chat_states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Cubit managing state, controls, interactive ticket metadata, and messages for Worker Chat.
class WorkerChatCubit extends Cubit<WorkerChatStates> {
  final DatabaseService _databaseService;
  final CloudStorageService _storageService;

  TicketModel ticket;
  List<ChatMessageModel> messages = [];
  bool isInternalNote = false;
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<TicketAttachmentItem> pendingAttachments = [];

  bool isLoading = true;
  bool isSending = false;
  String? errorMessage;
  RealtimeChannel? _realtimeChannel;

  WorkerChatCubit({
    required this.ticket,
    DatabaseService? databaseService,
    CloudStorageService? storageService,
  })  : _databaseService = databaseService ?? DatabaseService(),
        _storageService = storageService ?? CloudStorageService(),
        super(WorkerChatInitial());

  /// Initializes messages and real-time subscription for worker chat.
  void init() {
    fetchMessages();
    _subscribeToMessages();
  }

  /// Subscribes to real-time incoming messages including internal notes.
  void _subscribeToMessages() {
    try {
      final channelName = 'ticket_messages_worker_${ticket.id}';
      _realtimeChannel = SupabaseDeclaration.instance.channel(channelName);
      _realtimeChannel!.onPostgresChanges(
        event: PostgresChangeEvent.insert,
        schema: 'public',
        table: DatabaseEndpoints.messageTable,
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: 'ticket_id',
          value: ticket.id,
        ),
        callback: (payload) {
          final newRecord = payload.newRecord;
          if (newRecord.isNotEmpty) {
            final newMsg = ChatMessageModel.fromJson(newRecord);
            if (!messages.any((m) => m.id == newMsg.id)) {
              messages.add(newMsg);
              if (newMsg.isCustomer) {
                ticket = ticket.copyWith(status: TicketStatus.pending);
              }
              emit(WorkerChatLoaded());
              _scrollToBottom();
            }
          }
        },
      ).subscribe();
    } catch (e) {
      dev.log('Realtime subscription error in WorkerChatCubit: $e');
    }
  }

  /// Fetches all active messages for the ticket including internal notes.
  Future<void> fetchMessages() async {
    isLoading = true;
    errorMessage = null;
    emit(WorkerChatLoading());

    try {
      final refreshedTicket = await _databaseService.getTicketById(ticket.id);
      if (refreshedTicket != null) {
        ticket = refreshedTicket;
      }

      final fetched = await _databaseService.getTicketMessages(
        ticketId: ticket.id,
        includeInternal: true,
      );

      messages = fetched;
      isLoading = false;
      emit(WorkerChatLoaded());
      _scrollToBottom();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      emit(WorkerChatFailure());
    }
  }

  /// Toggles between Public Reply and Internal Note composer mode.
  void setReplyType(bool isInternal) {
    if (isInternalNote == isInternal) return;
    isInternalNote = isInternal;
    emit(WorkerChatModeChanged());
  }

  /// Updates ticket status on backend and locally.
  Future<void> updateStatus(TicketStatus newStatus) async {
    if (ticket.status == newStatus) return;
    try {
      await _databaseService.updateTicketStatus(
        ticketId: ticket.id,
        status: newStatus,
      );
      ticket = ticket.copyWith(status: newStatus);
      emit(WorkerChatLoaded());
    } catch (e) {
      errorMessage = e.toString();
      emit(WorkerChatFailure());
    }
  }

  /// Updates ticket priority on backend and locally.
  Future<void> updatePriority(TicketPriority newPriority) async {
    if (ticket.priority == newPriority) return;
    try {
      await _databaseService.updateTicketPriority(
        ticketId: ticket.id,
        priority: newPriority,
      );
      ticket = ticket.copyWith(priority: newPriority);
      emit(WorkerChatLoaded());
    } catch (e) {
      errorMessage = e.toString();
      emit(WorkerChatFailure());
    }
  }

  /// Updates ticket category on backend and locally.
  Future<void> updateCategory(String newCategory) async {
    if (ticket.category == newCategory) return;
    try {
      await _databaseService.updateTicketCategory(
        ticketId: ticket.id,
        category: newCategory,
      );
      ticket = ticket.copyWith(category: newCategory);
      emit(WorkerChatLoaded());
    } catch (e) {
      errorMessage = e.toString();
      emit(WorkerChatFailure());
    }
  }

  static const int maxSingleFileSize = 5 * 1024 * 1024; // 5 MB

  /// Picks generic file attachments from user storage and validates size limit.
  Future<bool> pickAttachments() async {
    try {
      final files = await FilePickerService.pickMultipleFiles();
      if (files.isEmpty) return true;

      for (final file in files) {
        final size = await file.length();
        if (size > maxSingleFileSize) {
          errorMessage = 'A selected file exceeds the 5MB limit.';
          emit(WorkerChatFailure());
          return false;
        }
        pendingAttachments.add(
          TicketAttachmentItem(file: file, name: file.name, size: size),
        );
      }
      emit(WorkerChatLoaded());
      return true;
    } catch (e) {
      dev.log('Error picking attachments in WorkerChatCubit: $e');
      errorMessage = e.toString();
      emit(WorkerChatFailure());
      return false;
    }
  }

  /// Picks image files specifically to attach to the response.
  Future<bool> pickImages() async {
    try {
      final files = await FilePickerService.pickMultipleFiles(
        type: FileType.image,
      );
      if (files.isEmpty) return true;

      for (final file in files) {
        final size = await file.length();
        if (size > maxSingleFileSize) {
          errorMessage = 'A selected image exceeds the 5MB limit.';
          emit(WorkerChatFailure());
          return false;
        }
        pendingAttachments.add(
          TicketAttachmentItem(file: file, name: file.name, size: size),
        );
      }
      emit(WorkerChatLoaded());
      return true;
    } catch (e) {
      dev.log('Error picking images in WorkerChatCubit: $e');
      errorMessage = e.toString();
      emit(WorkerChatFailure());
      return false;
    }
  }

  /// Removes a pending attachment before sending.
  void removePendingAttachment(int index) {
    if (index >= 0 && index < pendingAttachments.length) {
      pendingAttachments.removeAt(index);
      emit(WorkerChatLoaded());
    }
  }

  /// Clears all pending attachments.
  void clearPendingAttachments() {
    pendingAttachments.clear();
    emit(WorkerChatLoaded());
  }

  /// Sends a public reply or internal note with optional attachments.
  Future<void> sendMessage() async {
    final text = textController.text.trim();
    if (text.isEmpty && pendingAttachments.isEmpty) return;
    if (isSending) return;

    isSending = true;
    errorMessage = null;
    emit(WorkerChatSending());

    try {
      final currentUser = await UserHiveBox.getUserData();
      final List<String> uploadedUrls = [];

      if (pendingAttachments.isNotEmpty) {
        for (final item in pendingAttachments) {
          final url = await _storageService.uploadPlatformFile(
            platformFile: item.file,
          );
          uploadedUrls.add(url);
        }

        // If public reply, append to ticket attachments array
        if (!isInternalNote) {
          await _databaseService.appendTicketAttachments(
            ticketId: ticket.id,
            newAttachmentUrls: uploadedUrls,
          );

          ticket = ticket.copyWith(
            attachments: [
              ...ticket.attachments,
              ...uploadedUrls,
            ],
          );
        }

        pendingAttachments.clear();
      }

      if (text.isNotEmpty || uploadedUrls.isNotEmpty) {
        final newMsg = ChatMessageModel(
          id: '',
          ticketId: ticket.id,
          senderId: currentUser?.id,
          senderName: currentUser?.fullName ??
              currentUser?.email.split('@').first ??
              'Agent',
          senderRole: 'agent',
          content: text,
          isInternal: isInternalNote,
          attachments: uploadedUrls,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final inserted = await _databaseService.sendMessage(message: newMsg);
        if (!messages.any((m) => m.id == inserted.id)) {
          messages.add(inserted);
        }

        textController.clear();
      }

      isSending = false;
      emit(WorkerChatLoaded());
      _scrollToBottom();
    } catch (e) {
      isSending = false;
      errorMessage = e.toString();
      emit(WorkerChatFailure());
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Future<void> close() {
    if (_realtimeChannel != null) {
      SupabaseDeclaration.instance.removeChannel(_realtimeChannel!);
    }
    textController.dispose();
    scrollController.dispose();
    return super.close();
  }
}
