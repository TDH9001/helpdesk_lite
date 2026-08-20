import 'package:flutter/material.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app%20fonts/app_fonts.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app_theme/app_theme_colors.dart';

class AuthAppBarWidget extends StatelessWidget {
  final String title;
  final bool isDesktop;

  const AuthAppBarWidget({
    super.key,
    required this.title,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors =
        Theme.of(context).extension<AppThemeColors>()!.colors;

    final titleStyle = isDesktop
        ? AppFonts().desktopCustomerAuthenticationHeaderTitleInter20SemiBold(
            context,
            color: widgetColors.onSurface,
          )
        : AppFonts().mobileCustomerAuthenticationHeaderTitleInter18SemiBold(
            context,
            color: widgetColors.onSurface,
          );

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: widgetColors.surface.withValues(alpha: 0.85),
        border: Border(
          bottom: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: widgetColors.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.confirmation_number_outlined,
                  size: 20,
                  color: widgetColors.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: titleStyle,
              ),
            ],
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: widgetColors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              size: 20,
              color: widgetColors.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
