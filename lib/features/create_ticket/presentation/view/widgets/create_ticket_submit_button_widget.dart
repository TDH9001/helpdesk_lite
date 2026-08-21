import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Primary action button for submitting the support ticket form.
class CreateTicketSubmitButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onSubmit;

  const CreateTicketSubmitButtonWidget({
    super.key,
    required this.label,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Button icon
    final buttonIcon = Icon(
      Icons.send_rounded,
      size: 18.0,
      color: widgetColors.onPrimary,
    );

    // Button label text
    final buttonText = Text(
      label,
      style: AppFonts().mobileCreateTicketButtonInter14Medium(
        context,
        color: widgetColors.onPrimary,
      ),
    );

    return Material(
      color: widgetColors.primary,
      borderRadius: BorderRadius.circular(9999.0),
      elevation: 2.0,
      shadowColor: widgetColors.primary.withValues(alpha: 0.3),
      child: InkWell(
        onTap: onSubmit,
        borderRadius: BorderRadius.circular(9999.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonIcon,
              const SizedBox(width: 8.0),
              buttonText,
            ],
          ),
        ),
      ),
    );
  }
}
