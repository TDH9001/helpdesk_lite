import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/overview/data/model/overview_agent_item_model.dart';
import 'package:helpdesk_lite/features/overview/data/model/overview_metrics_model.dart';
import 'package:helpdesk_lite/features/overview/data/model/overview_static_model.dart';
import 'package:helpdesk_lite/features/overview/data/repos/implementations/static_overview_repo.dart';
import 'package:helpdesk_lite/features/overview/presentation/view/widgets/overview_agents_card_widget.dart';
import 'package:helpdesk_lite/features/overview/presentation/view/widgets/overview_header_widget.dart';
import 'package:helpdesk_lite/features/overview/presentation/view/widgets/overview_stat_card_widget.dart';
import 'package:helpdesk_lite/features/overview/presentation/view/widgets/overview_weekly_card_widget.dart';

/// Mobile layout scaffold for the Overview management dashboard.
class OverviewMobile extends StatefulWidget {
  final OverviewStaticModel staticData;
  final VoidCallback? onAddAgent;

  const OverviewMobile({
    super.key,
    required this.staticData,
    this.onAddAgent,
  });

  @override
  State<OverviewMobile> createState() => _OverviewMobileState();
}

class _OverviewMobileState extends State<OverviewMobile> {
  List<OverviewAgentItemModel>? _agents;
  OverviewMetricsModel? _metrics;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  //! <Where state management/cubit should handle fetching overview dashboard data>
  Future<void> _fetchDashboardData() async {
    const repo = StaticOverviewRepository();
    final results = await Future.wait([
      repo.getAgentsOverview(),
      repo.getOverviewMetrics(),
    ]);

    if (mounted) {
      setState(() {
        _agents = results[0] as List<OverviewAgentItemModel>;
        _metrics = results[1] as OverviewMetricsModel;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    final openTicketsValue = _metrics != null
        ? '${_metrics!.totalOpen}'
        : widget.staticData.totalOpenTicketsCount;

    final createdThisWeekValue = _metrics != null
        ? '${_metrics!.createdThisWeek}'
        : widget.staticData.createdThisWeekCount;

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with Title and Add New Agent CTA button
              OverviewHeaderWidget(
                title: widget.staticData.title,
                addAgentLabel: widget.staticData.addNewAgent,
                isDesktop: false,
                onAddAgent: widget.onAddAgent,
              ),
              const SizedBox(height: 16.0),

              // Total Open Tickets stat card
              OverviewStatCardWidget(
                icon: Icons.confirmation_number_outlined,
                label: widget.staticData.totalOpenTickets,
                value: openTicketsValue,
                badgeText: widget.staticData.totalOpenTicketsBadge,
                isDesktop: false,
              ),
              const SizedBox(height: 12.0),

              // Created This Week overview summary card
              OverviewWeeklyCardWidget(
                title: widget.staticData.createdThisWeek,
                count: createdThisWeekValue,
                vsSubtitle: widget.staticData.vsLastWeek,
                isDesktop: false,
              ),
              const SizedBox(height: 16.0),

              // Tickets per Agent card list
              OverviewAgentsCardWidget(
                title: widget.staticData.ticketsPerAgent,
                noAgentsLabel: widget.staticData.noAgentsFound,
                agents: _agents ?? const [],
                isLoading: _isLoading,
                isDesktop: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
