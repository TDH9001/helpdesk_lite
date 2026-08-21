import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/responsive_service/respnsive_service.dart';
import 'package:helpdesk_lite/features/add_new_agent/presentation/view/add_new_agent_screen.dart';
import 'package:helpdesk_lite/features/overview/data/repos/implementations/static_overview_repo.dart';
import 'package:helpdesk_lite/features/overview/presentation/view/layouts/overview_desktop.dart';
import 'package:helpdesk_lite/features/overview/presentation/view/layouts/overview_mobile.dart';

/// Screen entry point for Overview feature, managing dashboard and agent creation subview.
class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  bool _showAddAgent = false;

  void _openAddAgent() => setState(() => _showAddAgent = true);
  void _closeAddAgent() => setState(() => _showAddAgent = false);

  @override
  Widget build(BuildContext context) {
    if (_showAddAgent) {
      return AddNewAgentScreen(
        onCancel: _closeAddAgent,
        onSuccess: _closeAddAgent,
      );
    }

    final staticData = StaticOverviewRepository.getStaticData(context);

    return ResponsiveService(
      mobile: (context) => OverviewMobile(
        staticData: staticData,
        onAddAgent: _openAddAgent,
      ),
      desktop: (context) => OverviewDesktop(
        staticData: staticData,
        onAddAgent: _openAddAgent,
      ),
    );
  }
}
