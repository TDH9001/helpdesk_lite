import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/add_new_agent/data/model/add_new_agent_static_model.dart';
import 'package:helpdesk_lite/features/add_new_agent/presentation/view/widgets/add_new_agent_card_widget.dart';

/// Mobile layout scaffold for provisioning a new agent account.
class AddNewAgentMobile extends StatelessWidget {
  final AddNewAgentStaticModel staticData;
  final VoidCallback? onCancel;
  final VoidCallback? onSuccess;

  const AddNewAgentMobile({
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          physics: const BouncingScrollPhysics(),
          child: AddNewAgentCardWidget(
            staticData: staticData,
            onCancel: onCancel,
            onSuccess: onSuccess,
            isDesktop: false,
          ),
        ),
      ),
    );
  }
}
