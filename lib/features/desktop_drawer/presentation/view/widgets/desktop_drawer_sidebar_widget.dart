import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Side rail drawer navigation widget for desktop layouts.
class DesktopDrawerSidebarWidget extends StatelessWidget {
  final String appName;
  final String internalOpsLabel;
  final String myTicketsLabel;
  final String newTicketLabel;
  final String queueLabel;
  final String overviewLabel;
  final String supportLabel;
  final String archiveLabel;
  final int selectedIndex;
  final ValueChanged<int>? onTabSelected;

  const DesktopDrawerSidebarWidget({
    super.key,
    required this.appName,
    required this.internalOpsLabel,
    required this.myTicketsLabel,
    required this.newTicketLabel,
    required this.queueLabel,
    required this.overviewLabel,
    required this.supportLabel,
    required this.archiveLabel,
    this.selectedIndex = 0,
    this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Header section with brand logo and subtitle
    final headerSection = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Row(
        children: [
          Image.asset(
            'assets/Images/helpdesk_lite_icon_only.png',
            width: 36.0,
            height: 36.0,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const SizedBox.shrink(),
          ),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appName,
                style: AppFonts().desktopDesktopDrawerBrandTitleInter20Bold(
                  context,
                  color: widgetColors.onSurface,
                ),
              ),
              Text(
                internalOpsLabel,
                style: AppFonts()
                    .desktopDesktopDrawerBrandSubtitleInter11SemiBold(
                      context,
                      color: widgetColors.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ],
      ),
    );

    // Primary navigation links
    final mainNavSection = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            _DesktopDrawerNavItem(
              icon: Icons.confirmation_number_outlined,
              label: myTicketsLabel,
              isSelected: selectedIndex == 0,
              onTap: () => onTabSelected?.call(0),
            ),
            const SizedBox(height: 4.0),
            _DesktopDrawerNavItem(
              icon: Icons.add_circle_outline_rounded,
              label: newTicketLabel,
              isSelected: selectedIndex == 1,
              onTap: () => onTabSelected?.call(1),
            ),
            const SizedBox(height: 4.0),
            _DesktopDrawerNavItem(
              icon: Icons.alt_route_rounded,
              label: queueLabel,
              isSelected: selectedIndex == 2,
              onTap: () => onTabSelected?.call(2),
            ),
            const SizedBox(height: 4.0),
            _DesktopDrawerNavItem(
              icon: Icons.dashboard_outlined,
              label: overviewLabel,
              isSelected: selectedIndex == 3,
              onTap: () => onTabSelected?.call(3),
            ),
          ],
        ),
      ),
    );

    // // Footer utilities section
    // final footerSection = Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
    //   child: Column(
    //     children: [
    //       _DesktopDrawerNavItem(
    //         icon: Icons.help_outline_rounded,
    //         label: supportLabel,
    //         isSelected: selectedIndex == 4,
    //         onTap: () => onTabSelected?.call(4),
    //       ),
    //       const SizedBox(height: 4.0),
    //       _DesktopDrawerNavItem(
    //         icon: Icons.inventory_2_outlined,
    //         label: archiveLabel,
    //         isSelected: selectedIndex == 5,
    //         onTap: () => onTabSelected?.call(5),
    //       ),
    //     ],
    //   ),
    // );

    return Container(
      width: 240.0,
      decoration: BoxDecoration(
        color: widgetColors.surface,
        border: Border(
          right: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.5),
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          headerSection,
          const Divider(height: 1.0, thickness: 1.0),
          const SizedBox(height: 12.0),
          mainNavSection,
        ],
      ),
    );
  }
}

/// Private clickable navigation item widget for desktop drawer sidebar.
class _DesktopDrawerNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DesktopDrawerNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    final textStyle = isSelected
        ? AppFonts().desktopDesktopDrawerSidebarItemActiveInter12SemiBold(
            context,
            color: widgetColors.primary,
          )
        : AppFonts().desktopDesktopDrawerSidebarItemInter12Medium(
            context,
            color: widgetColors.onSurfaceVariant,
          );

    return InkWell(
      onTap: () {
        //! <Where desktop drawer navigation state should be handled>
        onTap();
      },
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isSelected
              ? widgetColors.primary.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.0,
              color: isSelected
                  ? widgetColors.primary
                  : widgetColors.onSurfaceVariant,
            ),
            const SizedBox(width: 12.0),
            Text(label, style: textStyle),
          ],
        ),
      ),
    );
  }
}
