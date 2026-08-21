import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Top header banner widget for Add New Agent screen with icon, title, and description.
class AddNewAgentHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isDesktop;

  const AddNewAgentHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Left circular person add icon badge
    final iconBadge = Container(
      width: isDesktop ? 48.0 : 42.0,
      height: isDesktop ? 48.0 : 42.0,
      decoration: BoxDecoration(
        color: widgetColors.primary.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person_add_alt_1_rounded,
        size: isDesktop ? 26.0 : 22.0,
        color: widgetColors.primary,
      ),
    );

    // Title and description textual column
    final titleSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: isDesktop
              ? AppFonts().desktopAddNewAgentHeaderTitleInter24Bold(
                  context,
                  color: widgetColors.onSurface,
                )
              : AppFonts().mobileAddNewAgentHeaderTitleInter20SemiBold(
                  context,
                  color: widgetColors.onSurface,
                ),
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          style: isDesktop
              ? AppFonts().desktopAddNewAgentHeaderSubtitleInter14Regular(
                  context,
                  color: widgetColors.onSurfaceVariant,
                )
              : AppFonts().mobileAddNewAgentHeaderSubtitleInter13Regular(
                  context,
                  color: widgetColors.onSurfaceVariant,
                ),
        ),
      ],
    );

    return Row(
      children: [
        iconBadge,
        const SizedBox(width: 14.0),
        Expanded(child: titleSection),
      ],
    );
  }
}
