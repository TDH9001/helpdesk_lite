import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/features/mobile_bottom_navigation_bar/data/model/mobile_bottom_nav_static_model.dart';

/// Abstract contract repository for the mobile bottom navigation bar feature.
abstract class MobileBottomNavRepo {
  Future<MobileBottomNavStaticModel> getMobileBottomNavData(
    BuildContext context,
  );
}
