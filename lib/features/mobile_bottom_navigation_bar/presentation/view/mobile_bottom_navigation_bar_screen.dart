import 'package:flutter/material.dart';
import 'package:helpdesk_lite/features/mobile_bottom_navigation_bar/data/repos/implementations/static_mobile_bottom_nav_repo.dart';
import 'package:helpdesk_lite/features/mobile_bottom_navigation_bar/presentation/view/layouts/mobile_bottom_nav_mobile.dart';

/// Screen entry point for Mobile Bottom Navigation Bar feature.
class MobileBottomNavigationBarScreen extends StatelessWidget {
  const MobileBottomNavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final staticData = StaticMobileBottomNavRepository.getStaticData(context);

    return MobileBottomNavMobile(staticData: staticData);
  }
}
