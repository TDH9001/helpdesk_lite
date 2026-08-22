/// Static UI text model for Worker Chat (Agent View) feature.
class WorkerChatStaticModel {
  final String chatTitle;
  final String publicReplyTab;
  final String internalNoteTab;
  final String internalNoteBadge;
  final String publicReplyPlaceholder;
  final String internalNotePlaceholder;
  final String sendButtonLabel;
  final String addNoteButtonLabel;
  final String viewAttachmentsLabel;
  final String noAttachmentsLabel;
  final String attachmentsDialogTitle;
  final String Function(int count) attachmentCountLabel;
  final String emptyNoMessages;
  final String sendingMessage;
  final String workerTag;
  final String customerTag;
  final String youTag;
  final String ticketInfoTitle;
  final String ticketDetailsTitle;
  final String changeStatusTitle;
  final String changePriorityTitle;
  final String changeCategoryTitle;
  final String assigneeLabel;
  final String reassignLabel;
  final String customerInfoTitle;
  final String attachImageTooltip;
  final String attachFileTooltip;
  final String statusUpdatedSuccess;
  final String priorityUpdatedSuccess;
  final String categoryUpdatedSuccess;
  final String internalNoteHelperText;
  final String statusOpen;
  final String statusPending;
  final String statusDelayed;
  final String statusWaiting;
  final String statusResolved;
  final String statusClosed;
  final String priorityUrgent;
  final String priorityHigh;
  final String priorityMedium;
  final String priorityLow;

  const WorkerChatStaticModel({
    required this.chatTitle,
    required this.publicReplyTab,
    required this.internalNoteTab,
    required this.internalNoteBadge,
    required this.publicReplyPlaceholder,
    required this.internalNotePlaceholder,
    required this.sendButtonLabel,
    required this.addNoteButtonLabel,
    required this.viewAttachmentsLabel,
    required this.noAttachmentsLabel,
    required this.attachmentsDialogTitle,
    required this.attachmentCountLabel,
    required this.emptyNoMessages,
    required this.sendingMessage,
    required this.workerTag,
    required this.customerTag,
    required this.youTag,
    required this.ticketInfoTitle,
    required this.ticketDetailsTitle,
    required this.changeStatusTitle,
    required this.changePriorityTitle,
    required this.changeCategoryTitle,
    required this.assigneeLabel,
    required this.reassignLabel,
    required this.customerInfoTitle,
    required this.attachImageTooltip,
    required this.attachFileTooltip,
    required this.statusUpdatedSuccess,
    required this.priorityUpdatedSuccess,
    required this.categoryUpdatedSuccess,
    required this.internalNoteHelperText,
    required this.statusOpen,
    required this.statusPending,
    required this.statusDelayed,
    required this.statusWaiting,
    required this.statusResolved,
    required this.statusClosed,
    required this.priorityUrgent,
    required this.priorityHigh,
    required this.priorityMedium,
    required this.priorityLow,
  });
}
