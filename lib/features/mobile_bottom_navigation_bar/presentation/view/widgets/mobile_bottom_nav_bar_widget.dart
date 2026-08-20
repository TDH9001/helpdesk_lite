import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// 4-tab bottom navigation bar widget for mobile layouts.
class MobileBottomNavBarWidget extends StatelessWidget {
  final String myTicketsLabel;
  final String newTicketLabel;
  final String queueLabel;
  final String overviewLabel;
  final int selectedIndex;
  final ValueChanged<int>? onTabSelected;

  const MobileBottomNavBarWidget({
    super.key,
    required this.myTicketsLabel,
    required this.newTicketLabel,
    required this.queueLabel,
    required this.overviewLabel,
    this.selectedIndex = 0,
    this.onTabSelected,
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
      final color =
          isSelected ? widgetColors.primary : widgetColors.onSurfaceVariant;

      return InkWell(
        onTap: () {
          //! <Where mobile bottom navigation state should be handled>
          onTabSelected?.call(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22.0,
              color: color,
            ),
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
      height: 64.0,
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
            buildNavItem(
              icon: Icons.alt_route_rounded,
              label: queueLabel,
              index: 2,
            ),
            buildNavItem(
              icon: Icons.dashboard_outlined,
              label: overviewLabel,
              index: 3,
            ),
          ],
        ),
      ),
    );
  }
}
