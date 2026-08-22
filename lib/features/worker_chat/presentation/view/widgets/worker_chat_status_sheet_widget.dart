import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';
import 'package:helpdesk_lite/features/worker_chat/data/model/worker_chat_static_model.dart';

/// Modal bottom sheet allowing workers to update the status of a ticket.
class WorkerChatStatusSheetWidget extends StatelessWidget {
  final TicketStatus currentStatus;
  final WorkerChatStaticModel staticData;
  final ValueChanged<TicketStatus> onStatusSelected;

  const WorkerChatStatusSheetWidget({
    super.key,
    required this.currentStatus,
    required this.staticData,
    required this.onStatusSelected,
  });

  /// Displays this sheet modally at the bottom of the screen.
  static Future<void> show(
    BuildContext context, {
    required TicketStatus currentStatus,
    required WorkerChatStaticModel staticData,
    required ValueChanged<TicketStatus> onStatusSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => WorkerChatStatusSheetWidget(
        currentStatus: currentStatus,
        staticData: staticData,
        onStatusSelected: onStatusSelected,
      ),
    );
  }

  Color _getStatusColor(TicketStatus status, dynamic widgetColors) {
    switch (status) {
      case TicketStatus.open:
        return widgetColors.error;
      case TicketStatus.pending:
        return widgetColors.primary;
      case TicketStatus.delayed:
        return widgetColors.error;
      case TicketStatus.waiting:
        return widgetColors.secondary;
      case TicketStatus.resolved:
        return widgetColors.surfaceTint;
      case TicketStatus.closed:
        return widgetColors.onSurfaceVariant;
    }
  }

  String _getStatusLabel(TicketStatus status) {
    switch (status) {
      case TicketStatus.open:
        return staticData.statusOpen;
      case TicketStatus.pending:
        return staticData.statusPending;
      case TicketStatus.delayed:
        return staticData.statusDelayed;
      case TicketStatus.waiting:
        return staticData.statusWaiting;
      case TicketStatus.resolved:
        return staticData.statusResolved;
      case TicketStatus.closed:
        return staticData.statusClosed;
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
            staticData.changeStatusTitle,
            style: AppFonts().mobileWorkerChatSheetTitleInter16SemiBold(
              context,
              color: widgetColors.onSurface,
            ),
          ),
          const SizedBox(height: 12.0),
          ...TicketStatus.values.map((status) {
            final isSelected = status == currentStatus;
            final dotColor = _getStatusColor(status, widgetColors);
            final label = _getStatusLabel(status);

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              leading: Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
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
                onStatusSelected(status);
              },
            );
          }),
        ],
      ),
    );
  }
}
