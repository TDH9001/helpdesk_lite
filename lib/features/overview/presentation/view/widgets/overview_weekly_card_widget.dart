import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Weekly creation ticket metric banner card for Overview dashboard.
class OverviewWeeklyCardWidget extends StatelessWidget {
  final String title;
  final String count;
  final String vsSubtitle;
  final bool isDesktop;

  const OverviewWeeklyCardWidget({
    super.key,
    required this.title,
    required this.count,
    required this.vsSubtitle,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Left textual metric description
    final textContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: isDesktop
              ? AppFonts().desktopOverviewWeeklyCardTitleInter13Medium(
                  context,
                  color: widgetColors.onSurfaceVariant,
                )
              : AppFonts().mobileOverviewWeeklyCardTitleInter12Medium(
                  context,
                  color: widgetColors.onSurfaceVariant,
                ),
        ),
        const SizedBox(height: 4.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              count,
              style: isDesktop
                  ? AppFonts().desktopOverviewWeeklyCardValueInter26Bold(
                      context,
                      color: widgetColors.onSurface,
                    )
                  : AppFonts().mobileOverviewWeeklyCardValueInter22SemiBold(
                      context,
                      color: widgetColors.onSurface,
                    ),
            ),
            const SizedBox(width: 8.0),
            Text(
              vsSubtitle,
              style: isDesktop
                  ? AppFonts().desktopOverviewWeeklyCardSubtitleInter13Regular(
                      context,
                      color: widgetColors.onSurfaceVariant,
                    )
                  : AppFonts().mobileOverviewWeeklyCardSubtitleInter12Regular(
                      context,
                      color: widgetColors.onSurfaceVariant,
                    ),
            ),
          ],
        ),
      ],
    );

    // Right circular monitoring icon badge
    final iconBadge = Container(
      width: isDesktop ? 52.0 : 44.0,
      height: isDesktop ? 52.0 : 44.0,
      decoration: BoxDecoration(
        color: widgetColors.surfaceContainerHigh,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.insights,
        size: isDesktop ? 26.0 : 22.0,
        color: widgetColors.primary,
      ),
    );

    return Container(
      padding: EdgeInsets.all(isDesktop ? 20.0 : 16.0),
      decoration: BoxDecoration(
        color: widgetColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: widgetColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: textContent),
          const SizedBox(width: 12.0),
          iconBadge,
        ],
      ),
    );
  }
}
