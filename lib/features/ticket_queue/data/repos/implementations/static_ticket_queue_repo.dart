import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/core/utils/localization_service/app_localizations.dart';
import 'package:helpdesk_lite/features/ticket_queue/data/model/ticket_queue_static_model.dart';
import 'package:helpdesk_lite/features/ticket_queue/data/repos/ticket_queue_repo.dart';

/// Concrete repository implementation for Ticket Queue resolving static text
/// via AppLocalizations per MVVM static data pattern.
class StaticTicketQueueRepository implements TicketQueueRepo {
  const StaticTicketQueueRepository();

  /// Resolves all static UI strings from the single [l10n] lookup.
  static TicketQueueStaticModel getStaticData(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return TicketQueueStaticModel(
      appName: l10n.appName,
      title: l10n.ticketQueueTitle,
      subtitle: l10n.ticketQueueSubtitle,
      searchPlaceholder: l10n.searchQueuePlaceholder,
      searchDesktopPlaceholder: l10n.searchTicketsDesktopPlaceholder,
      filterAllActive: l10n.filterAllActive,
      filterUnassigned: l10n.filterUnassigned,
      filterHighPriority: l10n.filterHighPriority,
      assignToMe: l10n.assignToMe,
      assignedToYouSuccess: l10n.assignedToYouSuccess,
      noQueueTicketsFound: l10n.noQueueTicketsFound,
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
      tableHeaderId: l10n.tableHeaderId,
      tableHeaderCustomer: l10n.tableHeaderCustomer,
      tableHeaderSubject: l10n.tableHeaderSubject,
      tableHeaderStatus: l10n.tableHeaderStatus,
      tableHeaderPriority: l10n.tableHeaderPriority,
      tableHeaderAssignee: l10n.tableHeaderAssignee,
      tableHeaderUpdated: l10n.tableHeaderUpdated,
    );
  }

  @override
  Future<TicketQueueStaticModel> getTicketQueueStaticData(
    BuildContext context,
  ) async {
    return getStaticData(context);
  }
}
