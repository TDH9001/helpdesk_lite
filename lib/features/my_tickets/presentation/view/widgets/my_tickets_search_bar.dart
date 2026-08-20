import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Clean rounded search input field for filtering tickets.
class MyTicketsSearchBar extends StatelessWidget {
  final String placeholder;
  final ValueChanged<String>? onChanged;
  final bool isDesktop;

  const MyTicketsSearchBar({
    super.key,
    required this.placeholder,
    this.onChanged,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    final searchTextStyle = isDesktop
        ? AppFonts().desktopMyTicketsSearchInter13Regular(
            context,
            color: widgetColors.onSurface,
          )
        : AppFonts().mobileMyTicketsSearchInter14Regular(
            context,
            color: widgetColors.onSurface,
          );

    final hintTextStyle = isDesktop
        ? AppFonts().desktopMyTicketsSearchInter13Regular(
            context,
            color: widgetColors.onSurfaceVariant,
          )
        : AppFonts().mobileMyTicketsSearchInter14Regular(
            context,
            color: widgetColors.onSurfaceVariant,
          );

    // Search bar container with icon and text field
    return Container(
      decoration: BoxDecoration(
        color: isDesktop
            ? widgetColors.surfaceContainerLow
            : widgetColors.surfaceContainer,
        borderRadius: BorderRadius.circular(9999.0),
        border: Border.all(
          color: isDesktop
              ? widgetColors.outlineVariant.withValues(alpha: 0.6)
              : Colors.transparent,
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: isDesktop ? 4.0 : 8.0,
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: isDesktop ? 18.0 : 20.0,
            color: widgetColors.onSurfaceVariant,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              style: searchTextStyle,
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: hintTextStyle,
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 6.0),
              ),
              onChanged: (value) {
                //! <Where search query filter should be handled>
                onChanged?.call(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
