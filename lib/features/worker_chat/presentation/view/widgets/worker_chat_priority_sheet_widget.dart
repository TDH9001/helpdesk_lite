import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';
import 'package:helpdesk_lite/features/worker_chat/data/model/worker_chat_static_model.dart';

/// Modal bottom sheet allowing workers to update the priority of a ticket.
class WorkerChatPrioritySheetWidget extends StatelessWidget {
  final TicketPriority currentPriority;
  final WorkerChatStaticModel staticData;
  final ValueChanged<TicketPriority> onPrioritySelected;

  const WorkerChatPrioritySheetWidget({
    super.key,
    required this.currentPriority,
    required this.staticData,
    required this.onPrioritySelected,
  });

  /// Displays this sheet modally at the bottom of the screen.
  static Future<void> show(
    BuildContext context, {
    required TicketPriority currentPriority,
    required WorkerChatStaticModel staticData,
    required ValueChanged<TicketPriority> onPrioritySelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => WorkerChatPrioritySheetWidget(
        currentPriority: currentPriority,
        staticData: staticData,
        onPrioritySelected: onPrioritySelected,
      ),
    );
  }

  IconData _getPriorityIcon(TicketPriority priority) {
    switch (priority) {
      case TicketPriority.urgent:
        return Icons.crisis_alert_rounded;
      case TicketPriority.high:
        return Icons.keyboard_double_arrow_up_rounded;
      case TicketPriority.medium:
        return Icons.drag_handle_rounded;
      case TicketPriority.low:
        return Icons.keyboard_arrow_down_rounded;
    }
  }

  Color _getPriorityColor(TicketPriority priority, dynamic widgetColors) {
    switch (priority) {
      case TicketPriority.urgent:
      case TicketPriority.high:
        return widgetColors.error;
      case TicketPriority.medium:
        return widgetColors.tertiary;
      case TicketPriority.low:
        return widgetColors.secondary;
    }
  }

  String _getPriorityLabel(TicketPriority priority) {
    switch (priority) {
      case TicketPriority.urgent:
        return staticData.priorityUrgent;
      case TicketPriority.high:
        return staticData.priorityHigh;
      case TicketPriority.medium:
        return staticData.priorityMedium;
      case TicketPriority.low:
        return staticData.priorityLow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    return Container(
      decoration: BoxDecoration(
        color: widgetColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.0,
              height: 4.0,
              decoration: BoxDecoration(
                color: widgetColors.outlineVariant.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          Text(
            staticData.changePriorityTitle,
            style: AppFonts().mobileWorkerChatSheetTitleInter16SemiBold(
              context,
              color: widgetColors.onSurface,
            ),
          ),
          const SizedBox(height: 12.0),
          ...TicketPriority.values.map((priority) {
            final isSelected = priority == currentPriority;
            final icon = _getPriorityIcon(priority);
            final iconColor = _getPriorityColor(priority, widgetColors);
            final label = _getPriorityLabel(priority);

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              leading: Icon(icon, color: iconColor, size: 20.0),
              title: Text(
                label,
                style: AppFonts().mobileWorkerChatSheetItemInter14Medium(
                  context,
                  color: isSelected
                      ? widgetColors.primary
                      : widgetColors.onSurface,
                ),
              ),
              trailing: isSelected
                  ? Icon(
                      Icons.check_rounded,
                      color: widgetColors.primary,
                      size: 20.0,
                    )
                  : null,
              onTap: () {
                context.pop();
                onPrioritySelected(priority);
              },
            );
          }),
        ],
      ),
    );
  }
}
