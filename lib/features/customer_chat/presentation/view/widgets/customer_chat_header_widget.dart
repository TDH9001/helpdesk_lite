import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view/widgets/customer_chat_attachments_dialog_widget.dart';

/// Control header bar at the top of the chat view displaying ticket info and attachment viewer action.
class CustomerChatHeaderWidget extends StatelessWidget {
  final TicketModel ticket;
  final String viewAttachmentsLabel;
  final String noAttachmentsLabel;
  final String attachmentsDialogTitle;
  final VoidCallback? onBack;

  const CustomerChatHeaderWidget({
    super.key,
    required this.ticket,
    required this.viewAttachmentsLabel,
    required this.noAttachmentsLabel,
    required this.attachmentsDialogTitle,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Status styling
    Color statusBgColor;
    Color statusTextColor;
    switch (ticket.status) {
      case TicketStatus.open:
        statusBgColor = widgetColors.primary.withValues(alpha: 0.12);
        statusTextColor = widgetColors.primary;
        break;
      case TicketStatus.pending:
        statusBgColor = widgetColors.tertiary.withValues(alpha: 0.12);
        statusTextColor = widgetColors.tertiary;
        break;
      case TicketStatus.delayed:
        statusBgColor = widgetColors.error.withValues(alpha: 0.12);
        statusTextColor = widgetColors.error;
        break;
      case TicketStatus.waiting:
        statusBgColor = widgetColors.secondary.withValues(alpha: 0.12);
        statusTextColor = widgetColors.secondary;
        break;
      case TicketStatus.resolved:
        statusBgColor = widgetColors.primaryContainer.withValues(alpha: 0.2);
        statusTextColor = widgetColors.primary;
        break;
      case TicketStatus.closed:
        statusBgColor = widgetColors.surfaceContainerHighest;
        statusTextColor = widgetColors.onSurfaceVariant;
        break;
    }

    // Attachments button with count badge
    final attachmentsButton = InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        CustomerChatAttachmentsDialogWidget.show(
          context,
          attachments: ticket.attachments,
          title: attachmentsDialogTitle,
          noAttachmentsText: noAttachmentsLabel,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: widgetColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: widgetColors.outlineVariant.withValues(alpha: 0.6),
            width: 1.0,
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
            const SizedBox(width: 6.0),
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: widgetColors.surface,
        border: Border(
          bottom: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.5),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      ticket.code,
                      style: AppFonts()
                          .mobileCustomerChatHeaderCodeInter13Bold(
                        context,
                        color: widgetColors.primary,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        ticket.status.name.toUpperCase(),
                        style: AppFonts()
                            .mobileCustomerChatBubbleTimeInter10Regular(
                          context,
                          color: statusTextColor,
                        ),
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
                      .mobileCustomerChatHeaderTitleInter15SemiBold(
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
    );
  }
}
