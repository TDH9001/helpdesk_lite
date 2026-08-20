import 'package:flutter/material.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app%20fonts/app_fonts.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app_theme/app_theme_colors.dart';

class AuthFooterWidget extends StatelessWidget {
  final String havingTroubleText;
  final String contactSupportText;
  final bool isDesktop;

  const AuthFooterWidget({
    super.key,
    required this.havingTroubleText,
    required this.contactSupportText,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors =
        Theme.of(context).extension<AppThemeColors>()!.colors;

    final footerStyle = isDesktop
        ? AppFonts().desktopCustomerAuthenticationFooterInter14Regular(
            context,
            color: widgetColors.onSurfaceVariant,
          )
        : AppFonts().mobileCustomerAuthenticationFooterInter13Regular(
            context,
            color: widgetColors.onSurfaceVariant,
          );

    final linkStyle = isDesktop
        ? AppFonts().desktopCustomerAuthenticationFooterInter14Regular(
            context,
            color: widgetColors.primary,
          )
        : AppFonts().mobileCustomerAuthenticationFooterInter13Regular(
            context,
            color: widgetColors.primary,
          );

    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              '$havingTroubleText ',
              style: footerStyle,
            ),
            InkWell(
              onTap: () {
                //! <Where contact support navigation should be handled>
              },
              child: Text(
                contactSupportText,
                style: linkStyle.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
