import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Individual rounded filter chip pill for filtering tickets by status or date.
class MyTicketsFilterChipItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;
  final bool isDesktop;

  const MyTicketsFilterChipItem({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    final textStyle = isDesktop
        ? (isSelected
            ? AppFonts().desktopMyTicketsFilterActiveInter12Medium(
                context,
                color: widgetColors.onPrimary,
              )
            : AppFonts().desktopMyTicketsFilterInactiveInter12Medium(
                context,
                color: widgetColors.onSurfaceVariant,
              ))
        : (isSelected
            ? AppFonts().mobileMyTicketsFilterActiveInter12Medium(
                context,
                color: widgetColors.onPrimary,
              )
            : AppFonts().mobileMyTicketsFilterInactiveInter12Medium(
                context,
                color: widgetColors.onSurface,
              ));

    // Interactive pill container
    return InkWell(
      onTap: () {
        //! <Where filter selection state should be handled>
        onTap();
      },
      borderRadius: BorderRadius.circular(9999.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? widgetColors.primary
              : (isDesktop
                  ? widgetColors.surface
                  : widgetColors.surfaceContainer),
          borderRadius: BorderRadius.circular(9999.0),
          border: Border.all(
            color: isSelected
                ? widgetColors.primary
                : (isDesktop
                    ? widgetColors.outlineVariant
                    : Colors.transparent),
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16.0,
                color: isSelected
                    ? widgetColors.onPrimary
                    : widgetColors.onSurfaceVariant,
              ),
              const SizedBox(width: 4.0),
            ],
            Text(
              label,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
