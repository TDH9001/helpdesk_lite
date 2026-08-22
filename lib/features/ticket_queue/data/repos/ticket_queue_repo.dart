import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/features/ticket_queue/data/model/ticket_queue_static_model.dart';

/// Abstract contract for the Ticket Queue static repository.
abstract class TicketQueueRepo {
  /// Resolves static localized UI strings.
  Future<TicketQueueStaticModel> getTicketQueueStaticData(
    BuildContext context,
  );
}
