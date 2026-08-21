import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/overview/data/model/overview_agent_item_model.dart';
import 'package:helpdesk_lite/features/overview/data/model/overview_static_model.dart';
import 'package:helpdesk_lite/features/overview/data/repos/implementations/static_overview_repo.dart';
import 'package:helpdesk_lite/features/overview/presentation/view/widgets/overview_agents_card_widget.dart';
import 'package:helpdesk_lite/features/overview/presentation/view/widgets/overview_header_widget.dart';
import 'package:helpdesk_lite/features/overview/presentation/view/widgets/overview_stat_card_widget.dart';
import 'package:helpdesk_lite/features/overview/presentation/view/widgets/overview_weekly_card_widget.dart';

/// Desktop layout scaffold for the Overview management dashboard.
class OverviewDesktop extends StatefulWidget {
  final OverviewStaticModel staticData;
  final VoidCallback? onAddAgent;

  const OverviewDesktop({
    super.key,
    required this.staticData,
    this.onAddAgent,
  });

  @override
  State<OverviewDesktop> createState() => _OverviewDesktopState();
}

class _OverviewDesktopState extends State<OverviewDesktop> {
  List<OverviewAgentItemModel>? _agents;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAgents();
  }

  Future<void> _fetchAgents() async {
    final liveAgents =
        await const StaticOverviewRepository().getAgentsOverview();
    if (mounted) {
      setState(() {
        _agents = liveAgents;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 28.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with Title, Subtitle, and Add New Agent CTA button
            OverviewHeaderWidget(
              title: widget.staticData.title,
              subtitle: widget.staticData.subtitle,
              addAgentLabel: widget.staticData.addNewAgent,
              isDesktop: true,
              onAddAgent: widget.onAddAgent,
            ),
            const SizedBox(height: 24.0),

            // Top metric highlight cards row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: OverviewStatCardWidget(
                    icon: Icons.confirmation_number_outlined,
                    label: widget.staticData.totalOpenTickets,
                    value: widget.staticData.totalOpenTicketsCount,
                    badgeText: widget.staticData.totalOpenTicketsBadge,
                    isDesktop: true,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: OverviewWeeklyCardWidget(
                    title: widget.staticData.createdThisWeek,
                    count: widget.staticData.createdThisWeekCount,
                    vsSubtitle: widget.staticData.vsLastWeek,
                    isDesktop: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),

            // Tickets per Agent comprehensive card
            OverviewAgentsCardWidget(
              title: widget.staticData.ticketsPerAgent,
              noAgentsLabel: widget.staticData.noAgentsFound,
              agents: _agents ?? const [],
              isLoading: _isLoading,
              isDesktop: true,
            ),
          ],
        ),
      ),
    );
  }
}
