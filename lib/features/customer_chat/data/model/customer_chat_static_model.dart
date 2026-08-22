/// Static UI text model for Customer Chat feature.
class CustomerChatStaticModel {
  final String chatTitle;
  final String typeMessagePlaceholder;
  final String sendButtonLabel;
  final String viewAttachmentsLabel;
  final String noAttachmentsLabel;
  final String attachmentsDialogTitle;
  final String Function(int count) attachmentCountLabel;
  final String emptyNoMessages;
  final String sendingMessage;
  final String workerTag;
  final String youTag;
  final String ticketInfoTitle;
  final String ticketDetailsTitle;
  final String uploadAttachmentsLabel;

  const CustomerChatStaticModel({
    required this.chatTitle,
    required this.typeMessagePlaceholder,
    required this.sendButtonLabel,
    required this.viewAttachmentsLabel,
    required this.noAttachmentsLabel,
    required this.attachmentsDialogTitle,
    required this.attachmentCountLabel,
    required this.emptyNoMessages,
    required this.sendingMessage,
    required this.workerTag,
    required this.youTag,
    required this.ticketInfoTitle,
    required this.ticketDetailsTitle,
    required this.uploadAttachmentsLabel,
  });
}
