import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';
import 'package:helpdesk_lite/features/worker_chat/data/model/worker_chat_static_model.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_attachments_dialog_widget.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_category_sheet_widget.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_priority_sheet_widget.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_status_sheet_widget.dart';

/// Top interactive header for Worker Chat with status, priority, and category controls.
class WorkerChatHeaderWidget extends StatelessWidget {
  final TicketModel ticket;
  final WorkerChatStaticModel staticData;
  final ValueChanged<TicketStatus> onStatusChanged;
  final ValueChanged<TicketPriority> onPriorityChanged;
  final ValueChanged<String> onCategoryChanged;
  final VoidCallback? onBack;

  const WorkerChatHeaderWidget({
    super.key,
    required this.ticket,
    required this.staticData,
    required this.onStatusChanged,
    required this.onPriorityChanged,
    required this.onCategoryChanged,
    this.onBack,
  });

  Color _getStatusDotColor(TicketStatus status, dynamic widgetColors) {
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

    // Status action chip
    final statusChip = InkWell(
      onTap: () {
        WorkerChatStatusSheetWidget.show(
          context,
          currentStatus: ticket.status,
          staticData: staticData,
          onStatusSelected: onStatusChanged,
        );
      },
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: widgetColors.surface,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: widgetColors.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: _getStatusDotColor(ticket.status, widgetColors),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
            Text(
              _getStatusLabel(ticket.status),
              style: AppFonts().mobileWorkerChatControlValueInter12SemiBold(
                context,
                color: widgetColors.onSurface,
              ),
            ),
            const SizedBox(width: 2.0),
            Icon(
              Icons.arrow_drop_down_rounded,
              size: 18.0,
              color: widgetColors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );

    // Priority action chip
    final priorityChip = InkWell(
      onTap: () {
        WorkerChatPrioritySheetWidget.show(
          context,
          currentPriority: ticket.priority,
          staticData: staticData,
          onPrioritySelected: onPriorityChanged,
        );
      },
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: widgetColors.surface,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: widgetColors.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getPriorityIcon(ticket.priority),
              size: 15.0,
              color: _getPriorityColor(ticket.priority, widgetColors),
            ),
            const SizedBox(width: 4.0),
            Text(
              _getPriorityLabel(ticket.priority),
              style: AppFonts().mobileWorkerChatControlValueInter12SemiBold(
                context,
                color: widgetColors.onSurface,
              ),
            ),
            const SizedBox(width: 2.0),
            Icon(
              Icons.arrow_drop_down_rounded,
              size: 18.0,
              color: widgetColors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );

    // Category action chip
    final categoryChip = InkWell(
      onTap: () {
        WorkerChatCategorySheetWidget.show(
          context,
          currentCategory: ticket.category,
          staticData: staticData,
          onCategorySelected: onCategoryChanged,
        );
      },
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: widgetColors.surface,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: widgetColors.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder_outlined,
              size: 14.0,
              color: widgetColors.primary,
            ),
            const SizedBox(width: 4.0),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 100.0),
              child: Text(
                ticket.category ?? 'General',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppFonts().mobileWorkerChatControlValueInter12SemiBold(
                  context,
                  color: widgetColors.onSurface,
                ),
              ),
            ),
            const SizedBox(width: 2.0),
            Icon(
              Icons.arrow_drop_down_rounded,
              size: 18.0,
              color: widgetColors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );

    // Attachments action button
    final attachmentsButton = InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        WorkerChatAttachmentsDialogWidget.show(
          context,
          attachments: ticket.attachments,
          title: staticData.attachmentsDialogTitle,
          noAttachmentsText: staticData.noAttachmentsLabel,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: widgetColors.surface,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: widgetColors.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.image_outlined,
              size: 16.0,
              color: widgetColors.primary,
            ),
            const SizedBox(width: 4.0),
            Text(
              '${ticket.attachments.length}',
              style: AppFonts().mobileCustomerChatAttachmentBadgeInter11Bold(
                context,
                color: widgetColors.primary,
              ),
            ),
          ],
        ),
      ),
    );

    // Customer Info Sub-Card
    final customerCard = (ticket.creatorName != null &&
            ticket.creatorName!.isNotEmpty)
        ? Container(
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 6.0,
            ),
            decoration: BoxDecoration(
              color: widgetColors.secondaryContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12.0,
                  backgroundColor: widgetColors.primaryContainer,
                  child: Text(
                    ticket.creatorName!.isNotEmpty
                        ? ticket.creatorName![0].toUpperCase()
                        : 'C',
                    style: AppFonts().mobileWorkerChatInternalBadgeInter10Bold(
                      context,
                      color: widgetColors.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket.creatorName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts()
                            .mobileWorkerChatCustomerNameInter13SemiBold(
                          context,
                          color: widgetColors.onSecondaryContainer,
                        ),
                      ),
                      if (ticket.creatorEmail != null &&
                          ticket.creatorEmail!.isNotEmpty)
                        Text(
                          ticket.creatorEmail!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppFonts()
                              .mobileWorkerChatCustomerEmailInter11Regular(
                            context,
                            color: widgetColors.onSecondaryContainer
                                .withValues(alpha: 0.8),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: widgetColors.surface,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    staticData.customerTag,
                    style: AppFonts()
                        .mobileWorkerChatControlLabelInter11Medium(
                      context,
                      color: widgetColors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 10.0),
      decoration: BoxDecoration(
        color: widgetColors.surfaceContainerLow,
        border: Border(
          bottom: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.4),
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Title Row with Back Button and Code
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: widgetColors.onSurface,
                ),
                onPressed: onBack ?? () => context.pop(),
              ),
              const SizedBox(width: 4.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          ticket.code,
                          style: AppFonts()
                              .mobileWorkerChatHeaderCodeInter13Bold(
                            context,
                            color: widgetColors.primary,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          ticket.updatedTimeAgo,
                          style: AppFonts()
                              .mobileWorkerChatHeaderTimeInter11Regular(
                            context,
                            color: widgetColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      ticket.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts()
                          .mobileWorkerChatHeaderTitleInter15SemiBold(
                        context,
                        color: widgetColors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              attachmentsButton,
            ],
          ),
          const SizedBox(height: 8.0),
          // Interactive Action Chips Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                statusChip,
                const SizedBox(width: 8.0),
                priorityChip,
                const SizedBox(width: 8.0),
                categoryChip,
              ],
            ),
          ),
          customerCard,
        ],
      ),
    );
  }
}
