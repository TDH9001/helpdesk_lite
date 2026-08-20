import 'package:flutter/material.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app%20fonts/app_fonts.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app_theme/app_theme_colors.dart';

class AuthTabsWidget extends StatelessWidget {
  final bool isLogin;
  final String loginText;
  final String signupText;
  final bool isDesktop;
  final ValueChanged<bool> onTabChanged;

  const AuthTabsWidget({
    super.key,
    required this.isLogin,
    required this.loginText,
    required this.signupText,
    required this.onTabChanged,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors =
        Theme.of(context).extension<AppThemeColors>()!.colors;

    final activeTabStyle = isDesktop
        ? AppFonts().desktopCustomerAuthenticationTabInter14Medium(
            context,
            color: widgetColors.primary,
          )
        : AppFonts().mobileCustomerAuthenticationTabInter12Medium(
            context,
            color: widgetColors.primary,
          );

    final inactiveTabStyle = isDesktop
        ? AppFonts().desktopCustomerAuthenticationTabInter14Medium(
            context,
            color: widgetColors.onSurfaceVariant,
          )
        : AppFonts().mobileCustomerAuthenticationTabInter12Medium(
            context,
            color: widgetColors.onSurfaceVariant,
          );

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => onTabChanged(true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isLogin
                      ? widgetColors.surfaceContainerLowest
                      : Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: isLogin
                          ? widgetColors.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    loginText,
                    style: isLogin ? activeTabStyle : inactiveTabStyle,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onTabChanged(false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: !isLogin
                      ? widgetColors.surfaceContainerLowest
                      : Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: !isLogin
                          ? widgetColors.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    signupText,
                    style: !isLogin ? activeTabStyle : inactiveTabStyle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
