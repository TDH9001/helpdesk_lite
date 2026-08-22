import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_attachment_item.dart';

/// Preview card displaying pending attachments in Worker Chat composer.
class WorkerChatAttachmentCardWidget extends StatelessWidget {
  final List<TicketAttachmentItem> attachments;
  final String Function(int count) attachmentCountLabel;
  final VoidCallback onClear;
  final void Function(int index)? onRemoveItem;

  const WorkerChatAttachmentCardWidget({
    super.key,
    required this.attachments,
    required this.attachmentCountLabel,
    required this.onClear,
    this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: widgetColors.surfaceContainerHigh,
        border: Border(
          top: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.4),
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                attachmentCountLabel(attachments.length),
                style: AppFonts().mobileCustomerChatAttachmentBadgeInter11Bold(
                  context,
                  color: widgetColors.primary,
                ),
              ),
              InkWell(
                onTap: onClear,
                child: Text(
                  'Clear all',
                  style: AppFonts().mobileCustomerChatBubbleTimeInter10Regular(
                    context,
                    color: widgetColors.error,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          SizedBox(
            height: 44.0,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: attachments.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8.0),
              itemBuilder: (context, index) {
                final item = attachments[index];
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: widgetColors.surface,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: widgetColors.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.attach_file_rounded,
                        size: 16.0,
                        color: widgetColors.primary,
                      ),
                      const SizedBox(width: 4.0),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 120.0),
                        child: Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppFonts()
                              .mobileCustomerChatBubbleTimeInter10Regular(
                            context,
                            color: widgetColors.onSurface,
                          ),
                        ),
                      ),
                      if (onRemoveItem != null) ...[
                        const SizedBox(width: 4.0),
                        InkWell(
                          onTap: () => onRemoveItem!(index),
                          child: Icon(
                            Icons.close_rounded,
                            size: 14.0,
                            color: widgetColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
