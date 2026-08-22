import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/core/utils/file_picker_service/file_picker_service.dart';
import 'package:helpdesk_lite/core/utils/localization_service/app_localizations.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_attachment_item.dart';
import 'package:helpdesk_lite/features/worker_chat/data/model/worker_chat_static_model.dart';
import 'package:helpdesk_lite/features/worker_chat/data/repos/worker_chat_repo.dart';

/// Concrete static repository resolving localized strings for Worker Chat.
class StaticWorkerChatRepository implements WorkerChatRepo {
  const StaticWorkerChatRepository();

  /// Resolves localized static data once and returns a populated model.
  static WorkerChatStaticModel getStaticData(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WorkerChatStaticModel(
      chatTitle: l10n.workerChatTitle,
      publicReplyTab: l10n.publicReplyTab,
      internalNoteTab: l10n.internalNoteTab,
      internalNoteBadge: l10n.internalNoteBadge,
      publicReplyPlaceholder: l10n.publicReplyPlaceholder,
      internalNotePlaceholder: l10n.internalNotePlaceholder,
      sendButtonLabel: l10n.chatSend,
      addNoteButtonLabel: l10n.addNoteButton,
      viewAttachmentsLabel: l10n.chatViewAttachments,
      noAttachmentsLabel: l10n.chatNoAttachments,
      attachmentsDialogTitle: l10n.chatAttachmentsDialogTitle,
      attachmentCountLabel: (count) => l10n.chatAttachmentCount(count),
      emptyNoMessages: l10n.chatEmptyNoMessages,
      sendingMessage: l10n.chatSendingMessage,
      workerTag: l10n.chatWorkerTag,
      customerTag: l10n.customerTag,
      youTag: l10n.chatYouTag,
      ticketInfoTitle: l10n.chatTicketInfo,
      ticketDetailsTitle: l10n.chatTicketDetails,
      changeStatusTitle: l10n.changeStatusTitle,
      changePriorityTitle: l10n.changePriorityTitle,
      changeCategoryTitle: l10n.changeCategoryTitle,
      assigneeLabel: l10n.assigneeLabel,
      reassignLabel: l10n.reassignLabel,
      customerInfoTitle: l10n.customerInfoTitle,
      attachImageTooltip: l10n.attachImageTooltip,
      attachFileTooltip: l10n.attachFileTooltip,
      statusUpdatedSuccess: l10n.statusUpdatedSuccess,
      priorityUpdatedSuccess: l10n.priorityUpdatedSuccess,
      categoryUpdatedSuccess: l10n.categoryUpdatedSuccess,
      internalNoteHelperText: l10n.internalNoteHelperText,
      statusOpen: l10n.statusOpen,
      statusPending: l10n.statusPending,
      statusDelayed: l10n.statusDelayed,
      statusWaiting: l10n.statusWaiting,
      statusResolved: l10n.statusResolved,
      statusClosed: l10n.statusClosed,
      priorityUrgent: l10n.priorityUrgent,
      priorityHigh: l10n.priorityHigh,
      priorityMedium: l10n.priorityMedium,
      priorityLow: l10n.priorityLow,
    );
  }

  @override
  Future<WorkerChatStaticModel> getWorkerChatData(BuildContext context) async {
    return getStaticData(context);
  }

  @override
  Future<List<TicketAttachmentItem>> pickAttachments() async {
    final files = await FilePickerService.pickMultipleFiles();
    if (files.isEmpty) return const [];

    final List<TicketAttachmentItem> items = [];
    for (final file in files) {
      final size = await file.length();
      items.add(TicketAttachmentItem(file: file, name: file.name, size: size));
    }
    return items;
  }

  @override
  Future<List<TicketAttachmentItem>> pickImages() async {
    final files = await FilePickerService.pickMultipleFiles(
      type: FileType.image,
    );
    if (files.isEmpty) return const [];

    final List<TicketAttachmentItem> items = [];
    for (final file in files) {
      final size = await file.length();
      items.add(TicketAttachmentItem(file: file, name: file.name, size: size));
    }
    return items;
  }
}
