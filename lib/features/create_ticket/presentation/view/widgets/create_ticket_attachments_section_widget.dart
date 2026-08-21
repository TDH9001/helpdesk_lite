import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/ticket_attachment_item.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_attachment_item_widget.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_attachment_zone_widget.dart';

/// Section widget containing the attachment dropzone and selected file list.
class CreateTicketAttachmentsSectionWidget extends StatelessWidget {
  final String label;
  final String uploadHint;
  final List<TicketAttachmentItem> attachments;
  final VoidCallback onPickFiles;
  final ValueChanged<int> onRemoveAttachment;

  const CreateTicketAttachmentsSectionWidget({
    super.key,
    required this.label,
    required this.uploadHint,
    required this.attachments,
    required this.onPickFiles,
    required this.onRemoveAttachment,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Attachments label heading
    final labelWidget = Text(
      label,
      style: AppFonts().mobileCreateTicketFormLabelInter12Medium(
        context,
        color: widgetColors.onSurface,
      ),
    );

    // Upload tap zone
    final uploadZone = CreateTicketAttachmentZoneWidget(
      hintText: uploadHint,
      onTap: onPickFiles,
    );

    // Selected attachments list
    final attachmentsList = ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: attachments.length,
      itemBuilder: (context, index) {
        return CreateTicketAttachmentItemWidget(
          attachment: attachments[index],
          onRemove: () => onRemoveAttachment(index),
        );
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelWidget,
        const SizedBox(height: 6.0),
        uploadZone,
        if (attachments.isNotEmpty) attachmentsList,
      ],
    );
  }
}
