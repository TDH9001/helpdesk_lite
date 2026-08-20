import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/my_tickets/data/model/ticket_model.dart';

/// High-density data table row for a single ticket in the desktop view.
class TicketTableRowDesktop extends StatefulWidget {
  final TicketModel ticket;
  final String statusLabel;
  final String priorityLabel;
  final VoidCallback? onTap;

  const TicketTableRowDesktop({
    super.key,
    required this.ticket,
    required this.statusLabel,
    required this.priorityLabel,
    this.onTap,
  });

  @override
  State<TicketTableRowDesktop> createState() => _TicketTableRowDesktopState();
}

class _TicketTableRowDesktopState extends State<TicketTableRowDesktop> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Status visual mapping
    Color statusBgColor;
    Color statusTextColor;
    switch (widget.ticket.status) {
      case TicketStatus.open:
        statusBgColor = widgetColors.primary.withValues(alpha: 0.12);
        statusTextColor = widgetColors.primary;
        break;
      case TicketStatus.pending:
        statusBgColor =
            widgetColors.tertiaryContainer.withValues(alpha: 0.2);
        statusTextColor = widgetColors.tertiary;
        break;
      case TicketStatus.delayed:
        statusBgColor =
            widgetColors.errorContainer.withValues(alpha: 0.25);
        statusTextColor = widgetColors.error;
        break;
      case TicketStatus.waiting:
        statusBgColor =
            widgetColors.secondaryContainer.withValues(alpha: 0.35);
        statusTextColor = widgetColors.onSecondaryContainer;
        break;
      case TicketStatus.resolved:
        statusBgColor =
            widgetColors.primaryContainer.withValues(alpha: 0.15);
        statusTextColor = widgetColors.primary;
        break;
      case TicketStatus.closed:
        statusBgColor = widgetColors.surfaceVariant;
        statusTextColor = widgetColors.onSurfaceVariant;
        break;
    }

    // Priority visual mapping
    IconData priorityIcon;
    Color priorityIconColor;
    switch (widget.ticket.priority) {
      case TicketPriority.urgent:
        priorityIcon = Icons.keyboard_double_arrow_up_rounded;
        priorityIconColor = widgetColors.error;
        break;
      case TicketPriority.high:
        priorityIcon = Icons.keyboard_arrow_up_rounded;
        priorityIconColor = widgetColors.error;
        break;
      case TicketPriority.medium:
        priorityIcon = Icons.horizontal_rule_rounded;
        priorityIconColor = widgetColors.outline;
        break;
      case TicketPriority.low:
        priorityIcon = Icons.keyboard_arrow_down_rounded;
        priorityIconColor = widgetColors.outline;
        break;
    }

    // Row cells: ID, Subject, Status, Priority, Updated
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          //! <Where ticket click navigation should be handled>
          widget.onTap?.call();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: _isHovered
                ? widgetColors.surfaceContainerLowest
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: widgetColors.outlineVariant.withValues(alpha: 0.4),
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            children: [
              // Column 1: Ticket Code (Flex 2)
              Expanded(
                flex: 2,
                child: Text(
                  widget.ticket.code,
                  style: AppFonts().desktopMyTicketsTableRowIdInter13Regular(
                    context,
                    color: _isHovered
                        ? widgetColors.primary
                        : widgetColors.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              // Column 2: Subject Title (Flex 5)
              Expanded(
                flex: 5,
                child: Text(
                  widget.ticket.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts()
                      .desktopMyTicketsTableRowSubjectInter14Medium(
                    context,
                    color: widgetColors.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              // Column 3: Status Badge (Flex 2)
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 3.0,
                    ),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      widget.statusLabel,
                      style: AppFonts().desktopMyTicketsBadgeInter11SemiBold(
                        context,
                        color: statusTextColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              // Column 4: Priority Icon (Flex 1)
              Expanded(
                flex: 1,
                child: Center(
                  child: Tooltip(
                    message: widget.priorityLabel,
                    child: Icon(
                      priorityIcon,
                      size: 20.0,
                      color: priorityIconColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              // Column 5: Last Updated (Flex 2)
              Expanded(
                //! <make the last update time a method of actual waited time>
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.ticket.updatedTimeAgo,
                    style: AppFonts()
                        .desktopMyTicketsTableRowTimeInter13Regular(
                      context,
                      color: widgetColors.onSurfaceVariant,
                    ),
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
