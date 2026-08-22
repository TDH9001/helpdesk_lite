import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/core/utils/file_picker_service/file_picker_service.dart';
import 'package:helpdesk_lite/core/utils/localization_service/app_localizations.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_attachment_item.dart';
import 'package:helpdesk_lite/features/customer_chat/data/model/customer_chat_static_model.dart';
import 'package:helpdesk_lite/features/customer_chat/data/repos/customer_chat_repo.dart';

/// Concrete static repository resolving localized strings for Customer Chat.
class StaticCustomerChatRepository implements CustomerChatRepo {
  const StaticCustomerChatRepository();

  /// Resolves localized static data once and returns a populated model.
  static CustomerChatStaticModel getStaticData(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CustomerChatStaticModel(
      chatTitle: l10n.chatTitle,
      typeMessagePlaceholder: l10n.chatTypeMessagePlaceholder,
      sendButtonLabel: l10n.chatSend,
      viewAttachmentsLabel: l10n.chatViewAttachments,
      noAttachmentsLabel: l10n.chatNoAttachments,
      attachmentsDialogTitle: l10n.chatAttachmentsDialogTitle,
      attachmentCountLabel: (count) => l10n.chatAttachmentCount(count),
      emptyNoMessages: l10n.chatEmptyNoMessages,
      sendingMessage: l10n.chatSendingMessage,
      workerTag: l10n.chatWorkerTag,
      youTag: l10n.chatYouTag,
      ticketInfoTitle: l10n.chatTicketInfo,
      ticketDetailsTitle: l10n.chatTicketDetails,
      uploadAttachmentsLabel: l10n.chatUploadAttachments,
    );
  }

  @override
  Future<CustomerChatStaticModel> getCustomerChatData(
    BuildContext context,
  ) async {
    return getStaticData(context);
  }

  @override
  Future<List<TicketAttachmentItem>> pickAttachments() async {
    final files = await FilePickerService.pickMultipleFiles();
    if (files.isEmpty) {
      return const [];
    }

    final List<TicketAttachmentItem> items = [];
    for (final file in files) {
      final size = await file.length();
      items.add(TicketAttachmentItem(file: file, name: file.name, size: size));
    }
    return items;
  }
}
