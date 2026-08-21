import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Primary app bar for mobile layouts showing brand logo and title.
class MobilePrimaryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const MobilePrimaryAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Header app bar with brand icon, title, and bottom border
    return AppBar(
      backgroundColor: widgetColors.surface.withValues(alpha: 0.85),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 16.0,
      shape: Border(
        bottom: BorderSide(
          color: widgetColors.outlineVariant.withValues(alpha: 0.5),
          width: 1.0,
        ),
      ),
      title: Row(
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
            style: AppFonts()
                .mobileMobileBottomNavigationBarAppBarTitleInter18SemiBold(
                  context,
                  color: widgetColors.onSurface,
                ),
          ),
        ],
      ),
    );
  }
}
