import 'dart:developer' as dev;
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
import 'package:helpdesk_lite/features/customer_chat/presentation/view_model/customer_chat_states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Cubit managing state, input controllers, attachments, and messages for Customer Chat.
class CustomerChatCubit extends Cubit<CustomerChatStates> {
  final DatabaseService _databaseService;
  final CloudStorageService _storageService;

  TicketModel ticket;
  List<ChatMessageModel> messages = [];
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<TicketAttachmentItem> pendingAttachments = [];

  bool isLoading = true;
  bool isSending = false;
  String? errorMessage;
  RealtimeChannel? _realtimeChannel;

  CustomerChatCubit({
    required this.ticket,
    DatabaseService? databaseService,
    CloudStorageService? storageService,
  })  : _databaseService = databaseService ?? DatabaseService(),
        _storageService = storageService ?? CloudStorageService(),
        super(const CustomerChatInitial());

  /// Initializes messages and realtime listeners.
  void init() {
    fetchMessages();
    _subscribeToMessages();
  }

  /// Subscribes to real-time incoming messages for this specific ticket.
  void _subscribeToMessages() {
    try {
      final channelName = 'ticket_messages_${ticket.id}';
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
          if (newRecord.isNotEmpty && newRecord['is_internal'] != true) {
            final newMsg = ChatMessageModel.fromJson(newRecord);
            // Avoid duplicates
            if (!messages.any((m) => m.id == newMsg.id)) {
              messages.add(newMsg);
              emit(const CustomerChatLoaded());
              _scrollToBottom();
            }
          }
        },
      ).subscribe();
    } catch (e) {
      dev.log('Realtime subscription error in CustomerChatCubit: $e');
    }
  }

  /// Fetches all active non-internal messages for the ticket.
  Future<void> fetchMessages() async {
    isLoading = true;
    errorMessage = null;
    emit(const CustomerChatLoading());

    try {
      // Reload ticket data to have latest attachments list
      final refreshedTicket = await _databaseService.getTicketById(ticket.id);
      if (refreshedTicket != null) {
        ticket = refreshedTicket;
      }

      final fetched = await _databaseService.getTicketMessages(
        ticketId: ticket.id,
        includeInternal: false,
      );

      messages = fetched;
      isLoading = false;
      emit(const CustomerChatLoaded());
      _scrollToBottom();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      emit(const CustomerChatFailure());
    }
  }

  static const int maxSingleFileSize = 5 * 1024 * 1024; // 5 MB

  /// Picks attachments from user storage and validates size.
  Future<bool> pickAttachments() async {
    try {
      final files = await FilePickerService.pickMultipleFiles();
      if (files.isEmpty) return true;

      for (final file in files) {
        final size = await file.length();
        if (size > maxSingleFileSize) {
          errorMessage = 'A selected file exceeds the 5MB limit.';
          emit(const CustomerChatFailure());
          return false;
        }
        pendingAttachments.add(
          TicketAttachmentItem(file: file, name: file.name, size: size),
        );
      }
      emit(const CustomerChatLoaded());
      return true;
    } catch (e) {
      dev.log('Error picking attachments in CustomerChatCubit: $e');
      errorMessage = e.toString();
      emit(const CustomerChatFailure());
      return false;
    }
  }

  /// Removes a pending attachment before sending.
  void removePendingAttachment(int index) {
    if (index >= 0 && index < pendingAttachments.length) {
      pendingAttachments.removeAt(index);
      emit(const CustomerChatLoaded());
    }
  }

  /// Clears all pending attachments.
  void clearPendingAttachments() {
    pendingAttachments.clear();
    emit(const CustomerChatLoaded());
  }

  /// Sends a customer message and uploads any pending attachments.
  Future<void> sendMessage() async {
    final text = textController.text.trim();
    if (text.isEmpty && pendingAttachments.isEmpty) return;
    if (isSending) return;

    isSending = true;
    errorMessage = null;
    emit(const CustomerChatSending());

    try {
      final currentUser = await UserHiveBox.getUserData();
      final List<String> uploadedUrls = [];

      // Upload pending attachments to Supabase Storage
      if (pendingAttachments.isNotEmpty) {
        for (final item in pendingAttachments) {
          final url = await _storageService.uploadPlatformFile(
            platformFile: item.file,
          );
          uploadedUrls.add(url);
        }

        // Append new attachment URLs directly to the ticket record
        await _databaseService.appendTicketAttachments(
          ticketId: ticket.id,
          newAttachmentUrls: uploadedUrls,
        );

        // Update local ticket model attachments list
        ticket = ticket.copyWith(
          attachments: [
            ...ticket.attachments,
            ...uploadedUrls,
          ],
        );

        pendingAttachments.clear();
      }

      // If user typed text OR attached files, post message to chat
      if (text.isNotEmpty || uploadedUrls.isNotEmpty) {
        final newMsg = ChatMessageModel(
          id: '',
          ticketId: ticket.id,
          senderId: currentUser?.id,
          senderName: currentUser?.fullName ??
              currentUser?.email.split('@').first ??
              'Customer',
          senderRole: 'customer',
          content: text,
          isInternal: false,
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
      emit(const CustomerChatLoaded());
      _scrollToBottom();
    } catch (e) {
      isSending = false;
      errorMessage = e.toString();
      emit(const CustomerChatFailure());
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
