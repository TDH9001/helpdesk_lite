import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Widget displaying the application title ('HelpDesk Lite') and subtitle.
class SplashTitleWidget extends StatelessWidget {
  final String title;
  final String titleAccent;
  final String subtitle;
  final bool isDesktop;

  const SplashTitleWidget({
    super.key,
    required this.title,
    required this.titleAccent,
    required this.subtitle,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // App title and branding
    final titleSection = RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: isDesktop
            ? AppFonts().desktopSplashTitleInter36SemiBold(
                context,
                color: widgetColors.onSurface,
              )
            : AppFonts().mobileSplashTitleInter30SemiBold(
                context,
                color: widgetColors.onSurface,
              ),
        children: [
          TextSpan(text: '$title '),
          TextSpan(
            text: titleAccent,
            style: isDesktop
                ? AppFonts().desktopSplashTitleAccentInter36Bold(
                    context,
                    color: widgetColors.primary,
                  )
                : AppFonts().mobileSplashTitleAccentInter30Bold(
                    context,
                    color: widgetColors.primary,
                  ),
          ),
        ],
      ),
    );

    // Subtitle description
    final subtitleSection = Text(
      subtitle,
      textAlign: TextAlign.center,
      style: isDesktop
          ? AppFonts().desktopSplashSubtitleInter16Regular(
              context,
              color: widgetColors.onSurfaceVariant,
            )
          : AppFonts().mobileSplashSubtitleInter14Regular(
              context,
              color: widgetColors.onSurfaceVariant,
            ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        titleSection,
        const SizedBox(height: 6.0),
        subtitleSection,
      ],
    );
  }
}
