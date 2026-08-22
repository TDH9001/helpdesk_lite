import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';

/// Card widget representing a ticket item within the Ticket Queue list.
class TicketQueueCardWidget extends StatelessWidget {
  final TicketModel ticket;
  final String statusLabel;
  final String priorityLabel;
  final String assignToMeLabel;
  final VoidCallback? onTap;
  final VoidCallback? onAssignTap;

  const TicketQueueCardWidget({
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

    // Determine status styling
    Color statusBgColor;
    Color statusTextColor;
    IconData statusIcon;

    switch (ticket.status) {
      case TicketStatus.open:
        statusBgColor = widgetColors.errorContainer;
        statusTextColor = widgetColors.onErrorContainer;
        statusIcon = Icons.circle;
        break;
      case TicketStatus.pending:
        statusBgColor = widgetColors.tertiaryContainer.withValues(alpha: 0.25);
        statusTextColor = widgetColors.tertiary;
        statusIcon = Icons.autorenew_rounded;
        break;
      case TicketStatus.delayed:
        statusBgColor = widgetColors.errorContainer;
        statusTextColor = widgetColors.onErrorContainer;
        statusIcon = Icons.schedule_rounded;
        break;
      case TicketStatus.waiting:
        statusBgColor = widgetColors.secondaryContainer;
        statusTextColor = widgetColors.onSecondaryContainer;
        statusIcon = Icons.hourglass_empty_rounded;
        break;
      case TicketStatus.resolved:
        statusBgColor = widgetColors.primaryContainer.withValues(alpha: 0.2);
        statusTextColor = widgetColors.primary;
        statusIcon = Icons.check_circle_outline_rounded;
        break;
      case TicketStatus.closed:
        statusBgColor = widgetColors.surfaceVariant;
        statusTextColor = widgetColors.onSurfaceVariant;
        statusIcon = Icons.cancel_outlined;
        break;
    }

    // Determine priority styling
    Color priorityIconColor;
    IconData priorityIcon;

    switch (ticket.priority) {
      case TicketPriority.urgent:
      case TicketPriority.high:
        priorityIconColor = widgetColors.error;
        priorityIcon = Icons.keyboard_double_arrow_up_rounded;
        break;
      case TicketPriority.medium:
        priorityIconColor = widgetColors.tertiary;
        priorityIcon = Icons.drag_handle_rounded;
        break;
      case TicketPriority.low:
        priorityIconColor = widgetColors.secondary;
        priorityIcon = Icons.keyboard_arrow_down_rounded;
        break;
    }

    // Top metadata row with ticket ID and updated time
    final topRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          ticket.code,
          style: AppFonts().mobileTicketQueueCardCodeInter12Medium(
            context,
            color: widgetColors.onSurfaceVariant,
          ),
        ),
        Text(
          ticket.updatedTimeAgo,
          style: AppFonts().mobileTicketQueueCardTimerInter11SemiBold(
            context,
            color: widgetColors.onSurfaceVariant,
          ),
        ),
      ],
    );

    // Customer name and subject text section
    final middleSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (ticket.creatorName != null && ticket.creatorName!.isNotEmpty) ...[
          Text(
            ticket.creatorName!,
            style: AppFonts().mobileTicketQueueCardCustomerInter16SemiBold(
              context,
              color: widgetColors.onSurface,
            ),
          ),
          const SizedBox(height: 2.0),
        ],
        Text(
          ticket.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppFonts().mobileTicketQueueCardSubjectInter13Regular(
            context,
            color: widgetColors.onSurfaceVariant,
          ),
        ),
      ],
    );

    // Badges and Assignee / Assign CTA row
    final bottomRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Status and Priority badges
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: statusBgColor,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(statusIcon, size: 10.0, color: statusTextColor),
                  const SizedBox(width: 4.0),
                  Text(
                    statusLabel,
                    style: AppFonts().mobileTicketQueueBadgeInter11SemiBold(
                      context,
                      color: statusTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: widgetColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(priorityIcon, size: 13.0, color: priorityIconColor),
                  const SizedBox(width: 3.0),
                  Text(
                    priorityLabel,
                    style: AppFonts().mobileTicketQueueBadgeInter11SemiBold(
                      context,
                      color: widgetColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Assignee Pill or "Assign to me" button
        if (ticket.isUnassigned)
          InkWell(
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4.0,
                    offset: const Offset(0.0, 1.0),
                  ),
                ],
              ),
              child: Text(
                assignToMeLabel,
                style: AppFonts()
                    .mobileTicketQueueAssignButtonInter11SemiBold(
                      context,
                      color: widgetColors.inverseOnSurface,
                    ),
              ),
            ),
          )
        else
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 3.0,
            ),
            decoration: BoxDecoration(
              color: widgetColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(9999.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person_outline_rounded,
                  size: 14.0,
                  color: widgetColors.primary,
                ),
                const SizedBox(width: 4.0),
                Text(
                  ticket.assigneeName ?? '',
                  style: AppFonts().mobileTicketQueueAgentNameInter11Medium(
                    context,
                    color: widgetColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
      ],
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: widgetColors.surface,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: widgetColors.outlineVariant.withValues(alpha: 0.35),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6.0,
              offset: const Offset(0.0, 2.0),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            if (ticket.isUnassigned)
              Positioned(
                left: 0.0,
                top: 0.0,
                bottom: 0.0,
                width: 3.5,
                child: Container(
                  decoration: BoxDecoration(
                    color: widgetColors.primary,
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(4.0),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                ticket.isUnassigned ? 18.0 : 14.0,
                12.0,
                14.0,
                12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topRow,
                  const SizedBox(height: 8.0),
                  middleSection,
                  const SizedBox(height: 10.0),
                  bottomRow,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
