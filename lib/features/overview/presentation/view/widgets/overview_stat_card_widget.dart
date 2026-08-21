import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Single metric highlight card widget for Overview dashboard metrics.
class OverviewStatCardWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String badgeText;
  final bool isDesktop;

  const OverviewStatCardWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.badgeText,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Top icon and badge pill row
    final topRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: isDesktop ? 28.0 : 24.0,
          color: widgetColors.primary,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: widgetColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            badgeText,
            style: isDesktop
                ? AppFonts().desktopOverviewStatCardBadgeInter12SemiBold(
                    context,
                    color: widgetColors.primary,
                  )
                : AppFonts().mobileOverviewStatCardBadgeInter11SemiBold(
                    context,
                    color: widgetColors.primary,
                  ),
          ),
        ),
      ],
    );

    // Bottom label and numeric metric value
    final valueSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: isDesktop
              ? AppFonts().desktopOverviewStatCardLabelInter13Medium(
                  context,
                  color: widgetColors.onSurfaceVariant,
                )
              : AppFonts().mobileOverviewStatCardLabelInter12Medium(
                  context,
                  color: widgetColors.onSurfaceVariant,
                ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: isDesktop
              ? AppFonts().desktopOverviewStatCardValueInter32Bold(
                  context,
                  color: widgetColors.onSurface,
                )
              : AppFonts().mobileOverviewStatCardValueInter28SemiBold(
                  context,
                  color: widgetColors.onSurface,
                ),
        ),
      ],
    );

    return Container(
      padding: EdgeInsets.all(isDesktop ? 20.0 : 16.0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topRow,
          const SizedBox(height: 16.0),
          valueSection,
        ],
      ),
    );
  }
}
