import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Multiline text area form field for detailing the support ticket issue.
class CreateTicketDescriptionFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final String requiredErrorText;
  final String tooShortErrorText;

  const CreateTicketDescriptionFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.placeholder,
    required this.requiredErrorText,
    required this.tooShortErrorText,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Label heading
    final labelWidget = Text(
      label,
      style: AppFonts().mobileCreateTicketFormLabelInter12Medium(
        context,
        color: widgetColors.onSurface,
      ),
    );

    // Multiline description input field
    final inputWidget = TextFormField(
      controller: controller,
      maxLines: 4,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.newline,
      style: AppFonts().mobileCreateTicketInputInter14Regular(
        context,
        color: widgetColors.onSurface,
      ),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: AppFonts().mobileCreateTicketInputInter14Regular(
          context,
          color: widgetColors.onSurfaceVariant,
        ),
        filled: true,
        fillColor: widgetColors.surfaceContainerLowest,
        contentPadding: const EdgeInsets.all(12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: widgetColors.outlineVariant,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: widgetColors.outlineVariant,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: widgetColors.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: widgetColors.error,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: widgetColors.error,
            width: 1.5,
          ),
        ),
        errorStyle: AppFonts().mobileCreateTicketErrorInter11Regular(
          context,
          color: widgetColors.error,
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return requiredErrorText;
        }
        if (value.trim().length < 10) {
          return tooShortErrorText;
        }
        return null;
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelWidget,
        const SizedBox(height: 6.0),
        inputWidget,
      ],
    );
  }
}
