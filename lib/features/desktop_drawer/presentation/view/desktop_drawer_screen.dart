import 'package:flutter/material.dart';
import 'package:helpdesk_lite/features/desktop_drawer/data/repos/implementations/static_desktop_drawer_repo.dart';
import 'package:helpdesk_lite/features/desktop_drawer/presentation/view/layouts/desktop_drawer_desktop.dart';

/// Screen entry point for Desktop Drawer feature with static repository binding.
class DesktopDrawerScreen extends StatelessWidget {
  final Widget? body;

  const DesktopDrawerScreen({
    super.key,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    final staticData = StaticDesktopDrawerRepository.getStaticData(context);

    return DesktopDrawerDesktop(
      staticData: staticData,
      body: body,
    );
  }
}
