import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/user_model.dart';

/// Role selector widget allowing switching between Worker and Manager roles.
class AddNewAgentRoleSelectorWidget extends StatelessWidget {
  final String label;
  final String workerLabel;
  final String managerLabel;
  final UserType selectedRole;
  final ValueChanged<UserType> onRoleChanged;
  final bool isDesktop;

  const AddNewAgentRoleSelectorWidget({
    super.key,
    required this.label,
    required this.workerLabel,
    required this.managerLabel,
    required this.selectedRole,
    required this.onRoleChanged,
    this.isDesktop = false,
  });

  Widget _buildOption({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            vertical: isDesktop ? 12.0 : 10.0,
            horizontal: 12.0,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? widgetColors.primary.withValues(alpha: 0.1)
                : widgetColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: isSelected
                  ? widgetColors.primary
                  : widgetColors.outlineVariant.withValues(alpha: 0.4),
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18.0,
                color: isSelected
                    ? widgetColors.primary
                    : widgetColors.onSurfaceVariant,
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: isDesktop
                      ? AppFonts().desktopAddNewAgentFieldLabelInter13Medium(
                          context,
                          color: isSelected
                              ? widgetColors.primary
                              : widgetColors.onSurface,
                        )
                      : AppFonts().mobileAddNewAgentFieldLabelInter12Medium(
                          context,
                          color: isSelected
                              ? widgetColors.primary
                              : widgetColors.onSurface,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: isDesktop
              ? AppFonts().desktopAddNewAgentFieldLabelInter13Medium(
                  context,
                  color: widgetColors.onSurfaceVariant,
                )
              : AppFonts().mobileAddNewAgentFieldLabelInter12Medium(
                  context,
                  color: widgetColors.onSurfaceVariant,
                ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            _buildOption(
              context: context,
              title: workerLabel,
              icon: Icons.support_agent_rounded,
              isSelected: selectedRole == UserType.worker,
              onTap: () => onRoleChanged(UserType.worker),
            ),
            const SizedBox(width: 12.0),
            _buildOption(
              context: context,
              title: managerLabel,
              icon: Icons.admin_panel_settings_rounded,
              isSelected: selectedRole == UserType.manager,
              onTap: () => onRoleChanged(UserType.manager),
            ),
          ],
        ),
      ],
    );
  }
}
