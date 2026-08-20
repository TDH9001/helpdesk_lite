import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/features/desktop_drawer/data/model/desktop_drawer_static_model.dart';

/// Abstract contract repository for the desktop drawer feature.
abstract class DesktopDrawerRepo {
  Future<DesktopDrawerStaticModel> getDesktopDrawerData(BuildContext context);
}
