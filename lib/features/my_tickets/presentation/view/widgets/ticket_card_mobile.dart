import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/my_tickets/data/model/ticket_model.dart';

/// Card widget for a ticket in the mobile list view.
class TicketCardMobile extends StatelessWidget {
  final TicketModel ticket;
  final String statusLabel;
  final String priorityLabel;
  final VoidCallback? onTap;

  const TicketCardMobile({
    super.key,
    required this.ticket,
    required this.statusLabel,
    required this.priorityLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Determine status styling
    Color stripeColor;
    Color statusBgColor;
    Color statusTextColor;
    IconData statusIcon;

    switch (ticket.status) {
      case TicketStatus.open:
        stripeColor = widgetColors.primary;
        statusBgColor = widgetColors.primary.withValues(alpha: 0.12);
        statusTextColor = widgetColors.primary;
        statusIcon = Icons.adjust_rounded;
        break;
      case TicketStatus.pending:
        stripeColor = widgetColors.tertiary;
        statusBgColor = widgetColors.tertiary.withValues(alpha: 0.12);
        statusTextColor = widgetColors.tertiary;
        statusIcon = Icons.pending_outlined;
        break;
      case TicketStatus.delayed:
        stripeColor = widgetColors.error;
        statusBgColor = widgetColors.error.withValues(alpha: 0.12);
        statusTextColor = widgetColors.error;
        statusIcon = Icons.schedule_rounded;
        break;
      case TicketStatus.waiting:
        stripeColor = widgetColors.secondary;
        statusBgColor = widgetColors.secondary.withValues(alpha: 0.12);
        statusTextColor = widgetColors.secondary;
        statusIcon = Icons.hourglass_empty_rounded;
        break;
      case TicketStatus.resolved:
        stripeColor = widgetColors.primaryContainer;
        statusBgColor = widgetColors.primaryContainer.withValues(alpha: 0.15);
        statusTextColor = widgetColors.primary;
        statusIcon = Icons.check_circle_outline_rounded;
        break;
      case TicketStatus.closed:
        stripeColor = widgetColors.outlineVariant;
        statusBgColor = widgetColors.surfaceVariant;
        statusTextColor = widgetColors.onSurfaceVariant;
        statusIcon = Icons.cancel_outlined;
        break;
    }

    // Determine priority styling
    Color priorityBgColor;
    Color priorityTextColor;
    IconData priorityIcon;

    switch (ticket.priority) {
      case TicketPriority.urgent:
        priorityBgColor = widgetColors.error.withValues(alpha: 0.12);
        priorityTextColor = widgetColors.error;
        priorityIcon = Icons.priority_high_rounded;
        break;
      case TicketPriority.high:
        priorityBgColor =
            widgetColors.tertiaryContainer.withValues(alpha: 0.2);
        priorityTextColor = widgetColors.tertiary;
        priorityIcon = Icons.arrow_upward_rounded;
        break;
      case TicketPriority.medium:
        priorityBgColor = widgetColors.surfaceVariant;
        priorityTextColor = widgetColors.onSurfaceVariant;
        priorityIcon = Icons.remove_rounded;
        break;
      case TicketPriority.low:
        priorityBgColor = widgetColors.surfaceVariant;
        priorityTextColor = widgetColors.onSurfaceVariant;
        priorityIcon = Icons.arrow_downward_rounded;
        break;
    }

    // Ticket ID and updated timestamp row
    final ticketId = Row(
      children: [
        Text(
          ticket.code,
          style: AppFonts().mobileMyTicketsCardIdInter12Medium(
            context,
            color: widgetColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 8.0),
        Container(
          width: 4.0,
          height: 4.0,
          decoration: BoxDecoration(
            color: widgetColors.outlineVariant,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          ticket.updatedTimeAgo,
          style: AppFonts().mobileMyTicketsCardTimeInter13Regular(
            context,
            color: widgetColors.onSurfaceVariant,
          ),
        ),
      ],
    );

    // Ticket subject title
    final ticketSubject = Text(
      ticket.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppFonts().mobileMyTicketsCardTitleInter16Medium(
        context,
        color: widgetColors.onSurface,
      ),
    );

    // Status and priority badges footer
    final ticketBadgesFooter = Row(
      children: [
        // Status badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          decoration: BoxDecoration(
            color: statusBgColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                statusIcon,
                size: 14.0,
                color: statusTextColor,
              ),
              const SizedBox(width: 4.0),
              Text(
                statusLabel,
                style: AppFonts().mobileMyTicketsBadgeInter11SemiBold(
                  context,
                  color: statusTextColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8.0),
        // Priority badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          decoration: BoxDecoration(
            color: priorityBgColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                priorityIcon,
                size: 14.0,
                color: priorityTextColor,
              ),
              const SizedBox(width: 4.0),
              Text(
                priorityLabel,
                style: AppFonts().mobileMyTicketsBadgeInter11SemiBold(
                  context,
                  color: priorityTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return InkWell(
      onTap: () {
        //! <Where ticket click navigation should be handled>
        onTap?.call();
      },
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: widgetColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: widgetColors.outlineVariant.withValues(alpha: 0.35),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6.0,
              offset: const Offset(0.0, 2.0),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left status stripe indicator
              Container(
                width: 4.0,
                color: stripeColor,
              ),
              // Main card body
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ticketId,
                      const SizedBox(height: 8.0),
                      ticketSubject,
                      const SizedBox(height: 12.0),
                      ticketBadgesFooter,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
