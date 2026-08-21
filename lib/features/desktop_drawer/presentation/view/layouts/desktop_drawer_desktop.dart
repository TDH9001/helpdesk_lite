import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/authentication_service/authentication_service.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/create_ticket_screen.dart';
import 'package:helpdesk_lite/features/desktop_drawer/data/model/desktop_drawer_static_model.dart';
import 'package:helpdesk_lite/features/desktop_drawer/presentation/view/widgets/desktop_drawer_sidebar_widget.dart';
import 'package:helpdesk_lite/features/my_tickets/presentation/view/my_tickets_screen.dart';

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

  final List<WidgetBuilder> _screens = [
    (context) => const MyTicketsScreen(),
    (context) => const CreateTicketScreen(),
    (context) => const SizedBox.shrink(),
    (context) => const SizedBox.shrink(),
  ];

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: Row(
        children: [
          DesktopDrawerSidebarWidget(
            appName: widget.staticData.appName,
            internalOpsLabel: widget.staticData.internalOps,
            myTicketsLabel: widget.staticData.navMyTickets,
            newTicketLabel: widget.staticData.navNewTicket,
            queueLabel: widget.staticData.navQueue,
            overviewLabel: widget.staticData.navOverview,
            supportLabel: widget.staticData.navSupport,
            archiveLabel: widget.staticData.navArchive,
            signOutLabel: widget.staticData.signOut,
            selectedIndex: _selectedIndex,
            onTabSelected: (index) => setState(() => _selectedIndex = index),
            onSignOut: () async {
              await AuthenticationService().logout();
              if (context.mounted) {
                context.pushReplacement('/customer-auth');
              }
            },
          ),
          Expanded(child: _screens[_selectedIndex](context)),
        ],
      ),
    );
  }
}
