import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/add_new_agent/data/model/add_new_agent_static_model.dart';
import 'package:helpdesk_lite/features/add_new_agent/presentation/view/widgets/add_new_agent_card_widget.dart';

/// Desktop layout scaffold for provisioning a new agent account.
class AddNewAgentDesktop extends StatelessWidget {
  final AddNewAgentStaticModel staticData;
  final VoidCallback? onCancel;
  final VoidCallback? onSuccess;

  const AddNewAgentDesktop({
    super.key,
    required this.staticData,
    this.onCancel,
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580.0),
            child: AddNewAgentCardWidget(
              staticData: staticData,
              onCancel: onCancel,
              onSuccess: onSuccess,
              isDesktop: true,
            ),
          ),
        ),
      ),
    );
  }
}
