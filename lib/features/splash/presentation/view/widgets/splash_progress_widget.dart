import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Progress bar and status indicator for the Splash Screen.
class SplashProgressWidget extends StatelessWidget {
  final double progress;
  final String statusText;
  final bool isDesktop;

  const SplashProgressWidget({
    super.key,
    required this.progress,
    required this.statusText,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Progress bar track and fill
    final progressBar = Container(
      width: isDesktop ? 240.0 : 192.0,
      height: 4.0,
      decoration: BoxDecoration(
        color: widgetColors.surfaceVariant,
        borderRadius: BorderRadius.circular(9999.0),
      ),
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: widgetColors.primary,
            borderRadius: BorderRadius.circular(9999.0),
          ),
        ),
      ),
    );

    // Status label
    final statusLabel = Text(
      statusText.toUpperCase(),
      style: isDesktop
          ? AppFonts().desktopSplashStatusLabelInter12SemiBold(
              context,
              color: widgetColors.onSurfaceVariant,
            )
          : AppFonts().mobileSplashStatusLabelInter11SemiBold(
              context,
              color: widgetColors.onSurfaceVariant,
            ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        progressBar,
        const SizedBox(height: 12.0),
        statusLabel,
      ],
    );
  }
}
