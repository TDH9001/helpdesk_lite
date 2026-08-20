import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// App Bar for the mobile My Tickets view showing the brand logo and title.
/// Note: User avatar icon is omitted per design specification.
class MyTicketsAppBarMobile extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const MyTicketsAppBarMobile({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Header content with brand icon and screen title
    return Container(
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: widgetColors.surface.withValues(alpha: 0.85),
        border: Border(
          bottom: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.5),
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Image.asset(
              'assets/Images/helpdesk_lite_icon_only.png',
              width: 32.0,
              height: 32.0,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: AppFonts().mobileMyTicketsAppBarTitleInter18SemiBold(
                context,
                color: widgetColors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
