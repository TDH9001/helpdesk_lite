import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Indicator widget displayed at the end of the ticket list.
class MyTicketsEndIndicator extends StatelessWidget {
  final String label;
  final bool isDesktop;

  const MyTicketsEndIndicator({
    super.key,
    required this.label,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    final textStyle = isDesktop
        ? AppFonts().desktopMyTicketsTableRowTimeInter13Regular(
            context,
            color: widgetColors.onSurfaceVariant.withValues(alpha: 0.7),
          )
        : AppFonts().mobileMyTicketsEndLabelInter13Regular(
            context,
            color: widgetColors.onSurfaceVariant.withValues(alpha: 0.7),
          );

    // Centered inventory icon and message
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Center(
        child: Opacity(
          opacity: 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: isDesktop ? 28.0 : 32.0,
                color: widgetColors.onSurfaceVariant,
              ),
              const SizedBox(height: 6.0),
              Text(
                label,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
