import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/features/my_tickets/data/model/my_tickets_static_model.dart';
import 'package:helpdesk_lite/features/my_tickets/data/model/ticket_model.dart';

abstract class MyTicketsRepo {
  Future<MyTicketsStaticModel> getMyTicketsStaticData(
    BuildContext context,
  );

  Future<List<TicketModel>> getTickets();

  Future<List<TicketModel>> searchTickets(String query);

  Future<List<TicketModel>> filterTickets(TicketStatus? status);
}
