import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/core/utils/database_service/database_service.dart';
import 'package:helpdesk_lite/core/utils/localization_service/app_localizations.dart';
import 'package:helpdesk_lite/features/overview/data/model/overview_agent_item_model.dart';
import 'package:helpdesk_lite/features/overview/data/model/overview_static_model.dart';
import 'package:helpdesk_lite/features/overview/data/repos/overview_repo.dart';

/// Concrete repository implementation fetching live agent data and metrics.
class StaticOverviewRepository implements OverviewRepo {
  const StaticOverviewRepository();

  static OverviewStaticModel getStaticData(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return OverviewStaticModel(
      title: l10n.overviewTitle,
      subtitle: l10n.overviewSubtitle,
      addNewAgent: l10n.addNewAgent,
      totalOpenTickets: l10n.totalOpenTickets,
      totalOpenTicketsCount: '142',
      totalOpenTicketsBadge: l10n.totalOpenTicketsBadge,
      createdThisWeek: l10n.createdThisWeek,
      createdThisWeekCount: l10n.createdThisWeekCount,
      vsLastWeek: l10n.vsLastWeek,
      ticketsPerAgent: l10n.ticketsPerAgent,
      noAgentsFound: l10n.noAgentsFound,
      initialAgents: const [],
    );
  }

  @override
  Future<OverviewStaticModel> getOverviewData(BuildContext context) async {
    return getStaticData(context);
  }

  @override
  Future<List<OverviewAgentItemModel>> getAgentsOverview() async {
    try {
      final userModels = await DatabaseService().getAgents();
      final now = DateTime.now();

      return userModels.map((user) {
        final lifetimeTickets = user.handledTickets ?? 0;
        final createdAt = user.createdAt ?? now;
        final diffDays = now.difference(createdAt).inDays;

        // Minimum 1.0 week to calculate weekly rate
        final weeks = diffDays <= 7 ? 1.0 : (diffDays / 7.0);
        final ticketsPerWeek = lifetimeTickets / weeks;

        // Progress bar fullness scaled to a max of 10 tickets/week
        final progress = (ticketsPerWeek / 10.0).clamp(0.0, 1.0);

        final name =
            (user.fullName != null && user.fullName!.trim().isNotEmpty)
                ? user.fullName!
                : (user.email.isNotEmpty
                    ? user.email.split('@').first
                    : 'Agent');

        return OverviewAgentItemModel(
          id: user.id,
          name: name,
          handledTickets: lifetimeTickets,
          progress: progress,
        );
      }).toList();
    } catch (_) {
      return const [];
    }
  }
}
