import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Header title and subtitle banner for Create Ticket screen.
class CreateTicketHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isDesktop;

  const CreateTicketHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Header title style based on layout
    final titleStyle = isDesktop
        ? AppFonts().desktopCreateTicketHeaderTitleInter30SemiBold(
            context,
            color: widgetColors.onSurface,
          )
        : AppFonts().mobileCreateTicketHeaderTitleInter24SemiBold(
            context,
            color: widgetColors.onSurface,
          );

    // Header subtitle style based on layout
    final subtitleStyle = isDesktop
        ? AppFonts().desktopCreateTicketHeaderSubtitleInter14Regular(
            context,
            color: widgetColors.onSurfaceVariant,
          )
        : AppFonts().mobileCreateTicketHeaderSubtitleInter13Regular(
            context,
            color: widgetColors.onSurfaceVariant,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: titleStyle),
        const SizedBox(height: 4.0),
        Text(subtitle, style: subtitleStyle),
      ],
    );
  }
}
