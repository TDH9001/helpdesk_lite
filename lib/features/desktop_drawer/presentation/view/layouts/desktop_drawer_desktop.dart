import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/desktop_drawer/data/model/desktop_drawer_static_model.dart';
import 'package:helpdesk_lite/features/desktop_drawer/presentation/view/widgets/desktop_drawer_sidebar_widget.dart';

/// Desktop layout scaffold integrating the desktop drawer sidebar
/// and an empty body area ready for custom content resolution.
class DesktopDrawerDesktop extends StatefulWidget {
  final DesktopDrawerStaticModel staticData;
  final Widget? body;

  const DesktopDrawerDesktop({super.key, required this.staticData, this.body});

  @override
  State<DesktopDrawerDesktop> createState() => _DesktopDrawerDesktopState();
}

class _DesktopDrawerDesktopState extends State<DesktopDrawerDesktop> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    return Scaffold(
      drawer: DesktopDrawerSidebarWidget(
        appName: widget.staticData.appName,
        internalOpsLabel: widget.staticData.internalOps,
        myTicketsLabel: widget.staticData.navMyTickets,
        newTicketLabel: widget.staticData.navNewTicket,
        queueLabel: widget.staticData.navQueue,
        overviewLabel: widget.staticData.navOverview,
        supportLabel: widget.staticData.navSupport,
        archiveLabel: widget.staticData.navArchive,
        selectedIndex: _selectedIndex,
        onTabSelected: (index) => setState(() => _selectedIndex = index),
      ),
      backgroundColor: widgetColors.background,
      body: Container(),
    );
  }
}
