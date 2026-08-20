import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Top navigation and branding bar for authentication screens displaying the
/// application logo (full logo with text on desktop, icon only on mobile)
/// and user profile action.
class AuthAppBarWidget extends StatelessWidget {
  final String? title;
  final bool isDesktop;

  const AuthAppBarWidget({
    super.key,
    this.title,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors =
        Theme.of(context).extension<AppThemeColors>()!.colors;

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
          // Left branding: logo with text on desktop, logo only on mobile
          isDesktop
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/Images/helpdesk_lite_icon_only.png',
                      height: 36,
                      width: 36,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 12),
                    if (title != null && title!.isNotEmpty)
                      Text(
                        title!,
                        style: AppFonts()
                            .desktopCustomerAuthenticationAppBarTitleInter20Bold(
                          context,
                          color: widgetColors.onSurface,
                        ),
                      ),
                  ],
                )
              : Image.asset(
                  'assets/Images/helpdesk_lite_icon_only.png',
                  height: 36,
                  width: 36,
                  fit: BoxFit.contain,
                ),

          // Right user profile action button
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
