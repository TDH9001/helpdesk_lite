import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// 5-tab bottom navigation bar widget for mobile layouts.
class MobileBottomNavBarWidget extends StatelessWidget {
  final String myTicketsLabel;
  final String newTicketLabel;
  final String queueLabel;
  final String overviewLabel;
  final String settingsLabel;
  final int selectedIndex;
  final ValueChanged<int>? onTabSelected;
  final bool showQueue;
  final bool showOverview;

  const MobileBottomNavBarWidget({
    super.key,
    required this.myTicketsLabel,
    required this.newTicketLabel,
    required this.queueLabel,
    required this.overviewLabel,
    required this.settingsLabel,
    this.selectedIndex = 0,
    this.onTabSelected,
    this.showQueue = false,
    this.showOverview = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Navigation item builder
    Widget buildNavItem({
      required IconData icon,
      required String label,
      required int index,
    }) {
      final isSelected = selectedIndex == index;
      final color = isSelected
          ? widgetColors.primary
          : widgetColors.onSurfaceVariant;

      return InkWell(
        onTap: () {
          //! <Where mobile bottom nav tab change should be handled>
          onTabSelected?.call(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22.0, color: color),
            const SizedBox(height: 4.0),
            Text(
              label,
              style: AppFonts()
                  .mobileMobileBottomNavigationBarNavLabelInter12Medium(
                    context,
                    color: color,
                  ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: widgetColors.surface,
        border: Border(
          top: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.5),
            width: 1.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.0,
            offset: const Offset(0.0, -2.0),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(
                icon: Icons.confirmation_number_outlined,
                label: myTicketsLabel,
                index: 0,
              ),
              buildNavItem(
                icon: Icons.add_circle_outline_rounded,
                label: newTicketLabel,
                index: 1,
              ),
              if (showQueue)
                buildNavItem(
                  icon: Icons.alt_route_rounded,
                  label: queueLabel,
                  index: 2,
                ),
              if (showOverview)
                buildNavItem(
                  icon: Icons.dashboard_outlined,
                  label: overviewLabel,
                  index: 3,
                ),
              buildNavItem(
                icon: Icons.settings_outlined,
                label: settingsLabel,
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
