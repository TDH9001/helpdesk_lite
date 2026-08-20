import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/mobile_bottom_navigation_bar/data/model/mobile_bottom_nav_static_model.dart';
import 'package:helpdesk_lite/features/mobile_bottom_navigation_bar/presentation/view/widgets/mobile_bottom_nav_bar_widget.dart';

/// Mobile layout scaffold with bottom navigation bar and empty body placeholder.
class MobileBottomNavMobile extends StatefulWidget {
  final MobileBottomNavStaticModel staticData;
  final Widget? body;

  const MobileBottomNavMobile({
    super.key,
    required this.staticData,
    this.body,
  });

  @override
  State<MobileBottomNavMobile> createState() => _MobileBottomNavMobileState();
}

class _MobileBottomNavMobileState extends State<MobileBottomNavMobile> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: widget.body ?? const SizedBox.shrink(),
      bottomNavigationBar: MobileBottomNavBarWidget(
        myTicketsLabel: widget.staticData.navMyTickets,
        newTicketLabel: widget.staticData.navNewTicket,
        queueLabel: widget.staticData.navQueue,
        overviewLabel: widget.staticData.navOverview,
        selectedIndex: _selectedIndex,
        onTabSelected: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
