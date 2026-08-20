import 'package:flutter/material.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app%20fonts/app_fonts.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app_theme/app_theme_colors.dart';

class AuthTextFieldWidget extends StatelessWidget {
  final String label;
  final String placeholder;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final bool isPassword;
  final bool isObscured;
  final VoidCallback? onToggleObscured;
  final Widget? trailingAction;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool isDesktop;

  const AuthTextFieldWidget({
    super.key,
    required this.label,
    required this.placeholder,
    required this.prefixIcon,
    this.controller,
    this.isPassword = false,
    this.isObscured = false,
    this.onToggleObscured,
    this.trailingAction,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors =
        Theme.of(context).extension<AppThemeColors>()!.colors;

    final labelStyle = isDesktop
        ? AppFonts().desktopCustomerAuthenticationLabelInter12SemiBold(
            context,
            color: widgetColors.onSurface,
          )
        : AppFonts().mobileCustomerAuthenticationLabelInter11SemiBold(
            context,
            color: widgetColors.onSurface,
          );

    final inputStyle = isDesktop
        ? AppFonts().desktopCustomerAuthenticationInputInter16Regular(
            context,
            color: widgetColors.onSurface,
          )
        : AppFonts().mobileCustomerAuthenticationInputInter14Regular(
            context,
            color: widgetColors.onSurface,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: labelStyle,
            ),
            ?trailingAction,
          ],
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: widgetColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: widgetColors.outlineVariant,
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword && isObscured,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            style: inputStyle,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: inputStyle.copyWith(
                color: widgetColors.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              prefixIcon: Icon(
                prefixIcon,
                size: 20,
                color: widgetColors.onSurfaceVariant,
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        isObscured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: widgetColors.onSurfaceVariant,
                      ),
                      onPressed: onToggleObscured,
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
