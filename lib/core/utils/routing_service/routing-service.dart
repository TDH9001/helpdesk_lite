import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/features/add_new_agent/presentation/view/add_new_agent_screen.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/create_ticket_screen.dart';
import 'package:helpdesk_lite/features/customer_authentication/presentation/view/customer_authentication_screen.dart';
import 'package:helpdesk_lite/features/desktop_drawer/presentation/view/desktop_drawer_screen.dart';
import 'package:helpdesk_lite/features/mobile_bottom_navigation_bar/presentation/view/mobile_bottom_navigation_bar_screen.dart';
import 'package:helpdesk_lite/features/my_tickets/presentation/view/my_tickets_screen.dart';
import 'package:helpdesk_lite/features/overview/presentation/view/overview_screen.dart';
import 'package:helpdesk_lite/features/splash/presentation/view/splash_screen.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view/ticket_queue_screen.dart';

class RoutingService {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/customer-auth',
        builder: (context, state) => const CustomerAuthenticationScreen(),
      ),
      GoRoute(
        path: '/my-tickets',
        builder: (context, state) => const MyTicketsScreen(),
      ),
      GoRoute(
        path: '/create-ticket',
        builder: (context, state) => const CreateTicketScreen(),
      ),
      GoRoute(
        path: '/ticket-queue',
        builder: (context, state) => const TicketQueueScreen(),
      ),
      GoRoute(
        path: '/bottom-nav',
        builder: (context, state) => const MobileBottomNavigationBarScreen(),
      ),
      GoRoute(
        path: '/desktop-drawer',
        builder: (context, state) => const DesktopDrawerScreen(),
      ),
      GoRoute(
        path: '/overview',
        builder: (context, state) => const OverviewScreen(),
      ),
      GoRoute(
        path: '/add-new-agent',
        builder: (context, state) => const AddNewAgentScreen(),
      ),
    ],
  );
}
