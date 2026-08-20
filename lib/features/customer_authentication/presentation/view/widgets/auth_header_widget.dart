import 'package:flutter/material.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app%20fonts/app_fonts.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app_theme/app_theme_colors.dart';

class AuthHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isDesktop;

  const AuthHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors =
        Theme.of(context).extension<AppThemeColors>()!.colors;

    final titleStyle = isDesktop
        ? AppFonts().desktopCustomerAuthenticationTitleInter24SemiBold(
            context,
            color: widgetColors.onSurface,
          )
        : AppFonts().mobileCustomerAuthenticationTitleInter20SemiBold(
            context,
            color: widgetColors.onSurface,
          );

    final subtitleStyle = isDesktop
        ? AppFonts().desktopCustomerAuthenticationSubtitleInter14Regular(
            context,
            color: widgetColors.onSurfaceVariant,
          )
        : AppFonts().mobileCustomerAuthenticationSubtitleInter13Regular(
            context,
            color: widgetColors.onSurfaceVariant,
          );

    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: widgetColors.primaryContainer,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widgetColors.primaryContainer.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            Icons.support_agent_rounded,
            size: 28,
            color: widgetColors.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: titleStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: subtitleStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
