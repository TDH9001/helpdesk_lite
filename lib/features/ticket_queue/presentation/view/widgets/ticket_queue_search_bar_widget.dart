import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Pill-shaped search bar widget with search and voice input icons.
class TicketQueueSearchBarWidget extends StatelessWidget {
  final String placeholder;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const TicketQueueSearchBarWidget({
    super.key,
    required this.placeholder,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Search bar container with icon and textfield
    return Container(
      height: 44.0,
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      decoration: BoxDecoration(
        color: widgetColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(9999.0),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            size: 20.0,
            color: widgetColors.onSurfaceVariant,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppFonts().mobileTicketQueueSearchInter14Regular(
                context,
                color: widgetColors.onSurface,
              ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: AppFonts().mobileTicketQueueSearchInter14Regular(
                  context,
                  color: widgetColors.onSurfaceVariant.withValues(alpha: 0.6),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
