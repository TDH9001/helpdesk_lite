enum TicketStatus {
  open,
  pending,
  delayed,
  waiting,
  resolved,
  closed,
}

enum TicketPriority {
  urgent,
  high,
  medium,
  low,
}

/// Model representing a single support ticket item.
class TicketModel {
  final String id;
  final String code;
  final String title;
  final TicketStatus status;
  final TicketPriority priority;
  final String updatedTimeAgo;

  const TicketModel({
    required this.id,
    required this.code,
    required this.title,
    required this.status,
    required this.priority,
    required this.updatedTimeAgo,
  });
}
