import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/create_ticket_static_model.dart';

/// Abstract contract for Create Ticket repository.
abstract class CreateTicketRepo {
  Future<CreateTicketStaticModel> getCreateTicketData(BuildContext context);
}
