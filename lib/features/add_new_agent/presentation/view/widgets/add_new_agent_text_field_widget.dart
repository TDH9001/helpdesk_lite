import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Form text field widget with custom prefix icon, optional password toggle, and validation.
class AddNewAgentTextFieldWidget extends StatefulWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool isDesktop;

  const AddNewAgentTextFieldWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    this.validator,
    this.isPassword = false,
    this.isDesktop = false,
  });

  @override
  State<AddNewAgentTextFieldWidget> createState() =>
      _AddNewAgentTextFieldWidgetState();
}

class _AddNewAgentTextFieldWidgetState
    extends State<AddNewAgentTextFieldWidget> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Field title label
    final labelWidget = Text(
      widget.label,
      style: widget.isDesktop
          ? AppFonts().desktopAddNewAgentFieldLabelInter13Medium(
              context,
              color: widgetColors.onSurfaceVariant,
            )
          : AppFonts().mobileAddNewAgentFieldLabelInter12Medium(
              context,
              color: widgetColors.onSurfaceVariant,
            ),
    );

    // Text form field input container
    final formField = TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword && _obscurePassword,
      validator: widget.validator,
      style: widget.isDesktop
          ? AppFonts().desktopAddNewAgentFieldInputInter15Regular(
              context,
              color: widgetColors.onSurface,
            )
          : AppFonts().mobileAddNewAgentFieldInputInter14Regular(
              context,
              color: widgetColors.onSurface,
            ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: widget.isDesktop
            ? AppFonts().desktopAddNewAgentFieldHintInter15Regular(
                context,
                color: widgetColors.outlineVariant,
              )
            : AppFonts().mobileAddNewAgentFieldHintInter14Regular(
                context,
                color: widgetColors.outlineVariant,
              ),
        prefixIcon: Icon(
          widget.prefixIcon,
          size: 20.0,
          color: widgetColors.outlineVariant,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20.0,
                  color: widgetColors.outlineVariant,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              )
            : null,
        filled: true,
        fillColor: widgetColors.surfaceContainerLow,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 14.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: widgetColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelWidget,
        const SizedBox(height: 6.0),
        formField,
      ],
    );
  }
}
