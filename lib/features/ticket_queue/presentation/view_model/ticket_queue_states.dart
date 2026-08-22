/// Base state for Ticket Queue.
abstract class TicketQueueStates {}

/// Initial state when TicketQueue is created.
class TicketQueueInitial extends TicketQueueStates {}

/// State emitted while loading tickets from database.
class TicketQueueLoading extends TicketQueueStates {}

/// State emitted when tickets are fetched or updated successfully.
class TicketQueueSuccess extends TicketQueueStates {}

/// State emitted when an error occurs during queue operations.
class TicketQueueFailure extends TicketQueueStates {}
