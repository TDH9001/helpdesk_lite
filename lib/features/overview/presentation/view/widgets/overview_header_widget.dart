import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Top header widget with screen title and 'Add New Agent' action button.
class OverviewHeaderWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String addAgentLabel;
  final bool isDesktop;
  final VoidCallback? onAddAgent;

  const OverviewHeaderWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.addAgentLabel,
    this.isDesktop = false,
    this.onAddAgent,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Title and optional subtitle column
    final titleSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: isDesktop
              ? AppFonts().desktopOverviewHeaderTitleInter24Bold(
                  context,
                  color: widgetColors.onSurface,
                )
              : AppFonts().mobileOverviewHeaderTitleInter20SemiBold(
                  context,
                  color: widgetColors.onSurface,
                ),
        ),
        if (subtitle != null && isDesktop) ...[
          const SizedBox(height: 4.0),
          Text(
            subtitle!,
            style: AppFonts().desktopOverviewHeaderSubtitleInter13Regular(
              context,
              color: widgetColors.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );

    // Add New Agent action button
    final addAgentButton = ElevatedButton.icon(
      onPressed: () {
        //! <Where adding a new agent should be handled>
        onAddAgent?.call();
      },
      icon: const Icon(Icons.person_add_outlined, size: 18.0),
      label: Text(
        addAgentLabel,
        style: isDesktop
            ? AppFonts().desktopOverviewAddAgentButtonInter13SemiBold(context)
            : AppFonts().mobileOverviewAddAgentButtonInter12SemiBold(context),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: widgetColors.primary,
        foregroundColor: widgetColors.onPrimary,
        elevation: 0.0,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 16.0 : 12.0,
          vertical: isDesktop ? 12.0 : 10.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: titleSection),
        addAgentButton,
      ],
    );
  }
}
