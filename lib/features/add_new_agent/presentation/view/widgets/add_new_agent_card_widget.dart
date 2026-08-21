import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/add_new_agent/data/model/add_new_agent_static_model.dart';
import 'package:helpdesk_lite/features/add_new_agent/presentation/view_model/add_new_agent_cubit.dart';
import 'package:helpdesk_lite/features/add_new_agent/presentation/view/widgets/add_new_agent_actions_widget.dart';
import 'package:helpdesk_lite/features/add_new_agent/presentation/view/widgets/add_new_agent_header_widget.dart';
import 'package:helpdesk_lite/features/add_new_agent/presentation/view/widgets/add_new_agent_role_selector_widget.dart';
import 'package:helpdesk_lite/features/add_new_agent/presentation/view/widgets/add_new_agent_text_field_widget.dart';

/// Main form card widget orchestrating agent account provisioning inputs.
class AddNewAgentCardWidget extends StatelessWidget {
  final AddNewAgentStaticModel staticData;
  final VoidCallback? onCancel;
  final VoidCallback? onSuccess;
  final bool isDesktop;

  const AddNewAgentCardWidget({
    super.key,
    required this.staticData,
    this.onCancel,
    this.onSuccess,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;
    final cubit = context.watch<AddNewAgentCubit>();

    return Container(
      padding: EdgeInsets.all(isDesktop ? 28.0 : 20.0),
      decoration: BoxDecoration(
        color: widgetColors.surface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: widgetColors.outlineVariant.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header banner
            AddNewAgentHeaderWidget(
              title: staticData.title,
              subtitle: staticData.subtitle,
              isDesktop: isDesktop,
            ),
            const SizedBox(height: 20.0),

            // Optional full name field
            AddNewAgentTextFieldWidget(
              label: staticData.nameLabel,
              hint: staticData.nameHint,
              prefixIcon: Icons.badge_outlined,
              controller: cubit.nameController,
              isDesktop: isDesktop,
            ),
            const SizedBox(height: 16.0),

            // Email address field
            AddNewAgentTextFieldWidget(
              label: staticData.emailLabel,
              hint: staticData.emailHint,
              prefixIcon: Icons.mail_outline_rounded,
              controller: cubit.emailController,
              isDesktop: isDesktop,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please enter a valid email';
                }
                if (!val.contains('@')) {
                  return 'Invalid email format';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),

            // Password field
            AddNewAgentTextFieldWidget(
              label: staticData.passwordLabel,
              hint: staticData.passwordHint,
              prefixIcon: Icons.lock_outline_rounded,
              controller: cubit.passwordController,
              isPassword: true,
              isDesktop: isDesktop,
              validator: (val) {
                if (val == null || val.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),

            // Role selection
            AddNewAgentRoleSelectorWidget(
              label: staticData.roleLabel,
              workerLabel: staticData.roleWorker,
              managerLabel: staticData.roleManager,
              selectedRole: cubit.selectedRole,
              onRoleChanged: cubit.selectRole,
              isDesktop: isDesktop,
            ),
            const SizedBox(height: 24.0),

            // Actions row
            AddNewAgentActionsWidget(
              cancelLabel: staticData.cancelButton,
              createLabel: staticData.createAgentButton,
              onCancel: onCancel,
              onSuccess: onSuccess,
              isDesktop: isDesktop,
            ),
          ],
        ),
      ),
    );
  }
}
