import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view/widgets/ticket_queue_filter_chips_widget.dart';

/// Single selectable pill filter chip item for the Ticket Queue view.
class TicketQueueFilterChipItemWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final QueueFilterType filterType;
  final bool isSelected;
  final ValueChanged<QueueFilterType>? onSelected;
  final Color? customIconColor;

  const TicketQueueFilterChipItemWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.filterType,
    required this.isSelected,
    this.onSelected,
    this.customIconColor,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    final bgColor =
        isSelected ? widgetColors.primary : widgetColors.surfaceContainer;
    final textColor =
        isSelected ? widgetColors.onPrimary : widgetColors.onSurfaceVariant;
    final iconColor = isSelected
        ? widgetColors.onPrimary
        : (customIconColor ?? widgetColors.onSurfaceVariant);

    return InkWell(
      onTap: () => onSelected?.call(filterType),
      borderRadius: BorderRadius.circular(9999.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 7.0,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(9999.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16.0,
              color: iconColor,
            ),
            const SizedBox(width: 6.0),
            Text(
              label,
              style: isSelected
                  ? AppFonts().mobileTicketQueueFilterActiveInter12Medium(
                      context,
                      color: textColor,
                    )
                  : AppFonts().mobileTicketQueueFilterInactiveInter12Medium(
                      context,
                      color: textColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
