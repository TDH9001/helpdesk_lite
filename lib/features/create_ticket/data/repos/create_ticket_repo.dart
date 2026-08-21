import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/create_ticket_static_model.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/ticket_attachment_item.dart';

/// Abstract contract for Create Ticket repository.
abstract class CreateTicketRepo {
  /// Resolves static UI strings and configuration.
  Future<CreateTicketStaticModel> getCreateTicketData(BuildContext context);

  /// Picks and processes attachments from user device/browser storage.
  Future<List<TicketAttachmentItem>> pickAttachments();
}
