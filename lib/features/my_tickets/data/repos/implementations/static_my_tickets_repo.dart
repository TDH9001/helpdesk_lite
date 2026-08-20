import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/core/utils/localization_service/app_localizations.dart';
import 'package:helpdesk_lite/features/my_tickets/data/model/my_tickets_static_model.dart';
import 'package:helpdesk_lite/features/my_tickets/data/model/ticket_model.dart';
import 'package:helpdesk_lite/features/my_tickets/data/repos/my_tickets_repo.dart';

class StaticMyTicketsRepository implements MyTicketsRepo {
  const StaticMyTicketsRepository();

  static List<TicketModel> getInitialTickets() {
    return const [
      TicketModel(
        id: '1',
        code: '#TKT-8924',
        title: 'System outage in eu-west-1 region affecting database clusters',
        status: TicketStatus.open,
        priority: TicketPriority.urgent,
        updatedTimeAgo: '10m ago',
      ),
      TicketModel(
        id: '2',
        code: '#TKT-8919',
        title: 'Cannot provision new user accounts via SAML integration',
        status: TicketStatus.pending,
        priority: TicketPriority.high,
        updatedTimeAgo: '2h ago',
      ),
      TicketModel(
        id: '3',
        code: '#TKT-8874',
        title:
            'Requesting hardware replacement for laptop with faulty keyboard',
        status: TicketStatus.delayed,
        priority: TicketPriority.medium,
        updatedTimeAgo: '1d ago',
      ),
      TicketModel(
        id: '4',
        code: '#TKT-8842',
        title: 'Update billing information on file for next renewal cycle',
        status: TicketStatus.waiting,
        priority: TicketPriority.low,
        updatedTimeAgo: '3d ago',
      ),
    ];
  }

  static MyTicketsStaticModel getStaticData(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return MyTicketsStaticModel(
      appName: l10n.appName,
      myTicketsTitle: l10n.myTickets,
      yourTicketsTitle: l10n.yourTickets,
      yourTicketsSubtitle: l10n.yourTicketsSubtitle,
      manageAssignedIssues: l10n.manageAssignedIssues,
      searchPlaceholder: l10n.searchTicketsPlaceholder,
      searchDesktopPlaceholder: l10n.searchTicketsDesktopPlaceholder,
      filterAllActive: l10n.filterAllActive,
      filterOpen: l10n.filterOpen,
      filterPending: l10n.filterPending,
      filterWaiting: l10n.filterWaiting,
      filterDelayed: l10n.filterDelayed,
      filterDate: l10n.filterDate,
      statusOpen: l10n.statusOpen,
      statusPending: l10n.statusPending,
      statusDelayed: l10n.statusDelayed,
      statusWaiting: l10n.statusWaiting,
      statusResolved: l10n.statusResolved,
      statusClosed: l10n.statusClosed,
      priorityUrgent: l10n.priorityUrgent,
      priorityHigh: l10n.priorityHigh,
      priorityMedium: l10n.priorityMedium,
      priorityLow: l10n.priorityLow,
      endOfActiveTickets: l10n.endOfActiveTickets,
      navMyTickets: l10n.navMyTickets,
      navNewTicket: l10n.navNewTicket,
      navQueue: l10n.navQueue,
      navOverview: l10n.navOverview,
      navSupport: l10n.navSupport,
      navArchive: l10n.navArchive,
      tableHeaderId: l10n.tableHeaderId,
      tableHeaderSubject: l10n.tableHeaderSubject,
      tableHeaderStatus: l10n.tableHeaderStatus,
      tableHeaderPriority: l10n.tableHeaderPriority,
      tableHeaderUpdated: l10n.tableHeaderUpdated,
      internalOps: l10n.internalOps,
      tickets: getInitialTickets(),
    );
  }

  @override
  Future<MyTicketsStaticModel> getMyTicketsStaticData(
    BuildContext context,
  ) async {
    return getStaticData(context);
  }

  @override
  Future<List<TicketModel>> getTickets() async {
    //! <Where ticket list API fetch should be handled>
    return getInitialTickets();
  }

  @override
  Future<List<TicketModel>> searchTickets(String query) async {
    //! <Where search query filter should be handled>
    final lower = query.toLowerCase();
    return getInitialTickets().where((t) {
      return t.code.toLowerCase().contains(lower) ||
          t.title.toLowerCase().contains(lower);
    }).toList();
  }

  @override
  Future<List<TicketModel>> filterTickets(TicketStatus? status) async {
    //! <Where filter selection state should be handled>
    if (status == null) return getInitialTickets();
    return getInitialTickets().where((t) => t.status == status).toList();
  }
}
