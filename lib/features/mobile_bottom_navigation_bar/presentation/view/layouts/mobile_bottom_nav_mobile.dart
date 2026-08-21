import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/mobile_bottom_navigation_bar/data/model/mobile_bottom_nav_static_model.dart';
import 'package:helpdesk_lite/features/mobile_bottom_navigation_bar/presentation/view/widgets/mobile_bottom_nav_bar_widget.dart';
import 'package:helpdesk_lite/features/mobile_bottom_navigation_bar/presentation/view/widgets/mobile_primary_appbar.dart';
import 'package:helpdesk_lite/features/my_tickets/presentation/view/my_tickets_screen.dart';

/// Mobile layout scaffold with top app bar, bottom navigation bar, and tab screens.
class MobileBottomNavMobile extends StatefulWidget {
  final MobileBottomNavStaticModel staticData;

  const MobileBottomNavMobile({super.key, required this.staticData});

  @override
  State<MobileBottomNavMobile> createState() => _MobileBottomNavMobileState();
}

class _MobileBottomNavMobileState extends State<MobileBottomNavMobile> {
  int _selectedIndex = 0;

  final List<WidgetBuilder> _screens = [
    (context) => const MyTicketsScreen(),
    (context) => const SizedBox.shrink(),
    (context) => const SizedBox.shrink(),
    (context) => const SizedBox.shrink(),
  ];

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    return Scaffold(
      backgroundColor: widgetColors.background,
      appBar: MobilePrimaryAppBar(title: widget.staticData.title),
      body: _screens[_selectedIndex](context),
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
