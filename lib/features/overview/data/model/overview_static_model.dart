import 'package:helpdesk_lite/features/overview/data/model/overview_agent_item_model.dart';

/// Static UI text and initial metrics model for the Overview screen.
class OverviewStaticModel {
  final String title;
  final String subtitle;
  final String addNewAgent;
  final String totalOpenTickets;
  final String totalOpenTicketsCount;
  final String totalOpenTicketsBadge;
  final String createdThisWeek;
  final String createdThisWeekCount;
  final String vsLastWeek;
  final String ticketsPerAgent;
  final String noAgentsFound;
  final List<OverviewAgentItemModel> initialAgents;

  const OverviewStaticModel({
    required this.title,
    required this.subtitle,
    required this.addNewAgent,
    required this.totalOpenTickets,
    required this.totalOpenTicketsCount,
    required this.totalOpenTicketsBadge,
    required this.createdThisWeek,
    required this.createdThisWeekCount,
    required this.vsLastWeek,
    required this.ticketsPerAgent,
    required this.noAgentsFound,
    required this.initialAgents,
  });
}
