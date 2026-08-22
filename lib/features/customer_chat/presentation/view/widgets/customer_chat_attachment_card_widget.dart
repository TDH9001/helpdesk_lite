import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_attachment_item.dart';

/// Single summary attachment card displaying selected pending files count and names.
class CustomerChatAttachmentCardWidget extends StatelessWidget {
  final List<TicketAttachmentItem> attachments;
  final String Function(int count) attachmentCountLabel;
  final VoidCallback onClear;
  final ValueChanged<int>? onRemoveItem;

  const CustomerChatAttachmentCardWidget({
    super.key,
    required this.attachments,
    required this.attachmentCountLabel,
    required this.onClear,
    this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) return const SizedBox.shrink();

    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Total attachments size formatted
    final totalBytes = attachments.fold<int>(0, (sum, item) => sum + item.size);
    String sizeFormatted;
    if (totalBytes < 1024) {
      sizeFormatted = '$totalBytes B';
    } else if (totalBytes < 1024 * 1024) {
      sizeFormatted = '${(totalBytes / 1024).toStringAsFixed(1)} KB';
    } else {
      sizeFormatted = '${(totalBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: widgetColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: widgetColors.outlineVariant.withValues(alpha: 0.7),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: widgetColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              Icons.attach_file_rounded,
              size: 18.0,
              color: widgetColors.primary,
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  attachmentCountLabel(attachments.length),
                  style: AppFonts()
                      .mobileCustomerChatAttachmentBadgeInter11Bold(
                    context,
                    color: widgetColors.onSurface,
                  ),
                ),
                Text(
                  '${attachments.map((e) => e.name).join(', ')} • $sizeFormatted',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts()
                      .mobileCustomerChatBubbleTimeInter10Regular(
                    context,
                    color: widgetColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close_rounded,
              size: 18.0,
              color: widgetColors.onSurfaceVariant,
            ),
            onPressed: onClear,
            tooltip: 'Remove attachments',
          ),
        ],
      ),
    );
  }
}
