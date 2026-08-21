import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/add_new_agent/presentation/view_model/add_new_agent_cubit.dart';
import 'package:helpdesk_lite/features/add_new_agent/presentation/view_model/add_new_agent_states.dart';

/// Actions row widget with Cancel and Create Agent submission buttons.
class AddNewAgentActionsWidget extends StatelessWidget {
  final String cancelLabel;
  final String createLabel;
  final VoidCallback? onCancel;
  final VoidCallback? onSuccess;
  final bool isDesktop;

  const AddNewAgentActionsWidget({
    super.key,
    required this.cancelLabel,
    required this.createLabel,
    this.onCancel,
    this.onSuccess,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;
    final cubit = context.read<AddNewAgentCubit>();

    return BlocBuilder<AddNewAgentCubit, AddNewAgentStates>(
      builder: (context, state) {
        final isLoading = state is AddNewAgentLoading;

        // Outlined Cancel button
        final cancelButton = Expanded(
          child: OutlinedButton(
            onPressed: isLoading ? null : onCancel,
            style: OutlinedButton.styleFrom(
              foregroundColor: widgetColors.onSurfaceVariant,
              side: BorderSide(color: widgetColors.outlineVariant),
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              cancelLabel,
              style: isDesktop
                  ? AppFonts().desktopAddNewAgentButtonInter15SemiBold(
                      context,
                      color: widgetColors.onSurfaceVariant,
                    )
                  : AppFonts().mobileAddNewAgentButtonInter14SemiBold(
                      context,
                      color: widgetColors.onSurfaceVariant,
                    ),
            ),
          ),
        );

        // Primary Submit Create Agent button
        final submitButton = Expanded(
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () => cubit.handleSubmit(
                      context: context,
                      onSuccess: onSuccess,
                    ),
            style: ElevatedButton.styleFrom(
              backgroundColor: widgetColors.primary,
              foregroundColor: widgetColors.onPrimary,
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    createLabel,
                    style: isDesktop
                        ? AppFonts().desktopAddNewAgentButtonInter15SemiBold(
                            context,
                            color: widgetColors.onPrimary,
                          )
                        : AppFonts().mobileAddNewAgentButtonInter14SemiBold(
                            context,
                            color: widgetColors.onPrimary,
                          ),
                  ),
          ),
        );

        return Row(
          children: [
            cancelButton,
            const SizedBox(width: 12.0),
            submitButton,
          ],
        );
      },
    );
  }
}
