import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/ticket_attachment_item.dart';

/// Attachment chip/tile widget showing file info and remove button.
class CreateTicketAttachmentItemWidget extends StatelessWidget {
  final TicketAttachmentItem attachment;
  final VoidCallback onRemove;

  const CreateTicketAttachmentItemWidget({
    super.key,
    required this.attachment,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // File thumbnail/icon indicator
    final fileIcon = Container(
      width: 36.0,
      height: 36.0,
      decoration: BoxDecoration(
        color: widgetColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(6.0),
      ),
      alignment: Alignment.center,
      child: Icon(
        attachment.isImage
            ? Icons.image_outlined
            : Icons.insert_drive_file_outlined,
        color: widgetColors.primary,
        size: 20.0,
      ),
    );

    // File details text section
    final detailsSection = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            attachment.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFonts().mobileCreateTicketAttachmentFileNameInter12Medium(
              context,
              color: widgetColors.onSurface,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            attachment.formattedSize,
            style: AppFonts()
                .mobileCreateTicketAttachmentFileSizeInter11Regular(
                  context,
                  color: widgetColors.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );

    // Remove file action button
    final removeButton = IconButton(
      onPressed: onRemove,
      icon: const Icon(Icons.close_rounded, size: 18.0),
      color: widgetColors.onSurfaceVariant,
      tooltip: 'Remove file',
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 32.0, minHeight: 32.0),
    );

    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: widgetColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: widgetColors.outlineVariant, width: 1.0),
      ),
      child: Row(
        children: [
          fileIcon,
          const SizedBox(width: 10.0),
          detailsSection,
          removeButton,
        ],
      ),
    );
  }
}
