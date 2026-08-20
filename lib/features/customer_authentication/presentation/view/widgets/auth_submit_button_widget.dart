import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

class AuthSubmitButtonWidget extends StatelessWidget {
  final String text;
  final bool isDesktop;
  final VoidCallback? onPressed;

  const AuthSubmitButtonWidget({
    super.key,
    required this.text,
    this.isDesktop = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors =
        Theme.of(context).extension<AppThemeColors>()!.colors;

    final buttonStyle = isDesktop
        ? AppFonts().desktopCustomerAuthenticationButtonInter14Medium(
            context,
            color: widgetColors.onPrimary,
          )
        : AppFonts().mobileCustomerAuthenticationButtonInter12Medium(
            context,
            color: widgetColors.onPrimary,
          );

    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widgetColors.primary,
          foregroundColor: widgetColors.onPrimary,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: () {
          //! <Where authentication submission should be handled>
          if (onPressed != null) {
            onPressed!();
          }
        },
        child: Text(
          text,
          style: buttonStyle,
        ),
      ),
    );
  }
}
