import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/core/utils/localization_service/app_localizations.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';
import 'package:helpdesk_lite/features/my_tickets/data/model/my_tickets_static_model.dart';
import 'package:helpdesk_lite/features/my_tickets/data/repos/my_tickets_repo.dart';

class StaticMyTicketsRepository implements MyTicketsRepo {
  const StaticMyTicketsRepository();

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
    return const [];
  }

  @override
  Future<List<TicketModel>> searchTickets(String query) async {
    return const [];
  }

  @override
  Future<List<TicketModel>> filterTickets(TicketStatus? status) async {
    return const [];
  }
}
