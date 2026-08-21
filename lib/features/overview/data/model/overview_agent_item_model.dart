/// Model representing an agent in the Overview screen.
class OverviewAgentItemModel {
  final String id;
  final String name;
  final int handledTickets;
  final double progress;

  const OverviewAgentItemModel({
    required this.id,
    required this.name,
    required this.handledTickets,
    required this.progress,
  });
}
