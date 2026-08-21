import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/overview/data/model/overview_agent_item_model.dart';
import 'package:helpdesk_lite/features/overview/presentation/view/widgets/overview_agent_item_widget.dart';

/// Card container widget presenting the list of agents and their ticket volumes.
class OverviewAgentsCardWidget extends StatelessWidget {
  final String title;
  final String noAgentsLabel;
  final List<OverviewAgentItemModel> agents;
  final bool isLoading;
  final bool isDesktop;

  const OverviewAgentsCardWidget({
    super.key,
    required this.title,
    required this.noAgentsLabel,
    required this.agents,
    this.isLoading = false,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Card header section without View All button
    final headerSection = Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 20.0 : 16.0,
        vertical: isDesktop ? 16.0 : 14.0,
      ),
      decoration: BoxDecoration(
        color: widgetColors.surfaceContainerLow,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      child: Text(
        title,
        style: isDesktop
            ? AppFonts().desktopOverviewAgentsCardHeaderInter20Bold(
                context,
                color: widgetColors.onSurface,
              )
            : AppFonts().mobileOverviewAgentsCardHeaderInter18SemiBold(
                context,
                color: widgetColors.onSurface,
              ),
      ),
    );

    // List of agents content section
    Widget listContent;
    if (isLoading) {
      listContent = Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Center(
          child: CircularProgressIndicator(
            color: widgetColors.primary,
            strokeWidth: 2.5,
          ),
        ),
      );
    } else if (agents.isEmpty) {
      listContent = Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Center(
          child: Text(
            noAgentsLabel,
            style: TextStyle(color: widgetColors.onSurfaceVariant),
          ),
        ),
      );
    } else {
      listContent = Padding(
        padding: EdgeInsets.all(isDesktop ? 20.0 : 16.0),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: agents.length,
          separatorBuilder: (context, index) =>
              SizedBox(height: isDesktop ? 18.0 : 14.0),
          itemBuilder: (context, index) {
            final agent = agents[index];
            return OverviewAgentItemWidget(
              name: agent.name,
              handledTickets: agent.handledTickets,
              progress: agent.progress,
              isDesktop: isDesktop,
            );
          },
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: widgetColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: widgetColors.outlineVariant.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          headerSection,
          listContent,
        ],
      ),
    );
  }
}
