import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_attachment_item.dart';
import 'package:helpdesk_lite/features/customer_chat/data/model/customer_chat_static_model.dart';

/// Abstract contract for Customer Chat repository.
abstract class CustomerChatRepo {
  /// Resolves localized static UI strings.
  Future<CustomerChatStaticModel> getCustomerChatData(BuildContext context);

  /// Picks attachments to send in chat or add to ticket.
  Future<List<TicketAttachmentItem>> pickAttachments();
}
