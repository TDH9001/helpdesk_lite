import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/responsive_service/respnsive_service.dart';
import 'package:helpdesk_lite/features/overview/data/repos/implementations/static_overview_repo.dart';
import 'package:helpdesk_lite/features/overview/presentation/view/layouts/overview_desktop.dart';
import 'package:helpdesk_lite/features/overview/presentation/view/layouts/overview_mobile.dart';

/// Screen entry point for Overview feature, resolving mobile and desktop layouts.
class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final staticData = StaticOverviewRepository.getStaticData(context);

    return ResponsiveService(
      mobile: (context) => OverviewMobile(staticData: staticData),
      desktop: (context) => OverviewDesktop(staticData: staticData),
    );
  }
}
