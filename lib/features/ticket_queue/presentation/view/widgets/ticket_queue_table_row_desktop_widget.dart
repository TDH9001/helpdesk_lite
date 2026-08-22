import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';

/// Table row component representing a single ticket item on desktop views.
class TicketQueueTableRowDesktopWidget extends StatelessWidget {
  final TicketModel ticket;
  final String statusLabel;
  final String priorityLabel;
  final String assignToMeLabel;
  final VoidCallback? onTap;
  final VoidCallback? onAssignTap;

  const TicketQueueTableRowDesktopWidget({
    super.key,
    required this.ticket,
    required this.statusLabel,
    required this.priorityLabel,
    required this.assignToMeLabel,
    this.onTap,
    this.onAssignTap,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Determine status badge color
    Color statusBgColor;
    Color statusTextColor;
    switch (ticket.status) {
      case TicketStatus.open:
        statusBgColor = widgetColors.errorContainer;
        statusTextColor = widgetColors.onErrorContainer;
        break;
      case TicketStatus.pending:
        statusBgColor = widgetColors.tertiaryContainer.withValues(alpha: 0.25);
        statusTextColor = widgetColors.tertiary;
        break;
      case TicketStatus.delayed:
        statusBgColor = widgetColors.errorContainer;
        statusTextColor = widgetColors.onErrorContainer;
        break;
      case TicketStatus.waiting:
        statusBgColor = widgetColors.secondaryContainer;
        statusTextColor = widgetColors.onSecondaryContainer;
        break;
      case TicketStatus.resolved:
        statusBgColor = widgetColors.primaryContainer.withValues(alpha: 0.2);
        statusTextColor = widgetColors.primary;
        break;
      case TicketStatus.closed:
        statusBgColor = widgetColors.surfaceVariant;
        statusTextColor = widgetColors.onSurfaceVariant;
        break;
    }

    // Row content
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: widgetColors.outlineVariant.withValues(alpha: 0.25),
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            // Code ID column
            SizedBox(
              width: 100.0,
              child: Text(
                ticket.code,
                style: AppFonts().desktopTicketQueueTableRowIdInter13Regular(
                  context,
                  color: widgetColors.onSurfaceVariant,
                ),
              ),
            ),
            // Customer column
            SizedBox(
              width: 150.0,
              child: Text(
                ticket.creatorName ?? '-',
                style:
                    AppFonts().desktopTicketQueueTableRowCustomerInter14Medium(
                  context,
                  color: widgetColors.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Subject column
            Expanded(
              flex: 3,
              child: Text(
                ticket.title,
                style:
                    AppFonts().desktopTicketQueueTableRowSubjectInter13Regular(
                  context,
                  color: widgetColors.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12.0),
            // Status column
            SizedBox(
              width: 110.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  statusLabel,
                  textAlign: TextAlign.center,
                  style: AppFonts().mobileTicketQueueBadgeInter11SemiBold(
                    context,
                    color: statusTextColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            // Priority column
            SizedBox(
              width: 90.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: widgetColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  priorityLabel,
                  textAlign: TextAlign.center,
                  style: AppFonts().mobileTicketQueueBadgeInter11SemiBold(
                    context,
                    color: widgetColors.onSurface,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            // Assignee / Action column
            SizedBox(
              width: 140.0,
              child: ticket.isUnassigned
                  ? InkWell(
                      onTap: onAssignTap,
                      borderRadius: BorderRadius.circular(9999.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: widgetColors.inverseSurface,
                          borderRadius: BorderRadius.circular(9999.0),
                        ),
                        child: Text(
                          assignToMeLabel,
                          textAlign: TextAlign.center,
                          style: AppFonts()
                              .desktopTicketQueueAssignButtonInter12SemiBold(
                            context,
                            color: widgetColors.inverseOnSurface,
                          ),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 18.0,
                          color: widgetColors.primary,
                        ),
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: Text(
                            ticket.assigneeName ?? '',
                            style: AppFonts()
                                .mobileTicketQueueAgentNameInter11Medium(
                              context,
                              color: widgetColors.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(width: 12.0),
            // Updated time column
            SizedBox(
              width: 90.0,
              child: Text(
                ticket.updatedTimeAgo,
                textAlign: TextAlign.end,
                style: AppFonts().desktopTicketQueueTableRowTimeInter13Regular(
                  context,
                  color: widgetColors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
