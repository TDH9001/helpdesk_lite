import 'package:helpdesk_lite/features/my_tickets/data/model/ticket_model.dart';

/// Static localized UI strings and initial dataset for the My Tickets feature.
class MyTicketsStaticModel {
  final String appName;
  final String myTicketsTitle;
  final String yourTicketsTitle;
  final String yourTicketsSubtitle;
  final String manageAssignedIssues;
  final String searchPlaceholder;
  final String searchDesktopPlaceholder;
  final String filterAllActive;
  final String filterOpen;
  final String filterPending;
  final String filterWaiting;
  final String filterDelayed;
  final String filterDate;
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
  final String endOfActiveTickets;
  final String navMyTickets;
  final String navNewTicket;
  final String navQueue;
  final String navOverview;
  final String navSupport;
  final String navArchive;
  final String tableHeaderId;
  final String tableHeaderSubject;
  final String tableHeaderStatus;
  final String tableHeaderPriority;
  final String tableHeaderUpdated;
  final String internalOps;
  final List<TicketModel> tickets;

  const MyTicketsStaticModel({
    required this.appName,
    required this.myTicketsTitle,
    required this.yourTicketsTitle,
    required this.yourTicketsSubtitle,
    required this.manageAssignedIssues,
    required this.searchPlaceholder,
    required this.searchDesktopPlaceholder,
    required this.filterAllActive,
    required this.filterOpen,
    required this.filterPending,
    required this.filterWaiting,
    required this.filterDelayed,
    required this.filterDate,
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
    required this.endOfActiveTickets,
    required this.navMyTickets,
    required this.navNewTicket,
    required this.navQueue,
    required this.navOverview,
    required this.navSupport,
    required this.navArchive,
    required this.tableHeaderId,
    required this.tableHeaderSubject,
    required this.tableHeaderStatus,
    required this.tableHeaderPriority,
    required this.tableHeaderUpdated,
    required this.internalOps,
    required this.tickets,
  });
}
