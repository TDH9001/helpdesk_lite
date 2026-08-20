import 'package:go_router/go_router.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/customer_authentication_screen.dart';

class RoutingService {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const CustomerAuthenticationScreen(),
      ),
      GoRoute(
        path: '/customer-auth',
        builder: (context, state) => const CustomerAuthenticationScreen(),
      ),
    ],
  );
}

/*
routes: [
//! all the required amterials for the routing to use in the future
      GoRoute(path: '/', builder: (context, state) => const LandingPage()),
      GoRoute(
        path: '/contact-us',
        builder: (context, state) => const ContactUsPage(),
      ),
      GoRoute(
        path: '/car-selection',
        builder: (context, state) => const CarSelectionPage(),
      ),
      GoRoute(
        path: '/car-details',
        builder: (context, state) {
          //TODO: Follow the claude advice and make it
          // entirely reliant on fetching from backend and not
          // passing extra object.
          Car? car;
          if (state.extra is Car) {
            car = state.extra as Car;
          } else if (state.extra is Map) {
            car = Car.fromJson(Map<String, dynamic>.from(state.extra as Map));
          }
          return CarDetailsPage(car: car);
        },
      ),
    ]
*/