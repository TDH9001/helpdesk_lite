import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Single agent progress row item displaying agent name, ticket load, and progress bar.
class OverviewAgentItemWidget extends StatelessWidget {
  final String name;
  final int handledTickets;
  final double progress;
  final bool isDesktop;

  const OverviewAgentItemWidget({
    super.key,
    required this.name,
    required this.handledTickets,
    required this.progress,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Agent name and ticket count labels
    final nameAndCountRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: isDesktop
                ? AppFonts().desktopOverviewAgentItemNameInter15Medium(
                    context,
                    color: widgetColors.onSurface,
                  )
                : AppFonts().mobileOverviewAgentItemNameInter14Medium(
                    context,
                    color: widgetColors.onSurface,
                  ),
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          '$handledTickets tickets',
          style: isDesktop
              ? AppFonts().desktopOverviewAgentItemCountInter12SemiBold(
                  context,
                  color: widgetColors.onSurfaceVariant,
                )
              : AppFonts().mobileOverviewAgentItemCountInter11SemiBold(
                  context,
                  color: widgetColors.onSurfaceVariant,
                ),
        ),
      ],
    );

    // Activity progress indicator bar
    final progressBar = ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: LinearProgressIndicator(
        value: progress.clamp(0.0, 1.0),
        minHeight: 8.0,
        backgroundColor: widgetColors.surfaceContainerHigh,
        valueColor: AlwaysStoppedAnimation<Color>(widgetColors.primary),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        nameAndCountRow,
        const SizedBox(height: 6.0),
        progressBar,
      ],
    );
  }
}
