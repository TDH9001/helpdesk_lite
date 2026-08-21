import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Dashed dropzone / tap-to-upload container for file attachments.
class CreateTicketAttachmentZoneWidget extends StatelessWidget {
  final String hintText;
  final VoidCallback onTap;

  const CreateTicketAttachmentZoneWidget({
    super.key,
    required this.hintText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Upload zone content
    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.cloud_upload_outlined,
          size: 36.0,
          color: widgetColors.onSurfaceVariant,
        ),
        const SizedBox(height: 8.0),
        Text(
          hintText,
          textAlign: TextAlign.center,
          style: AppFonts().mobileCreateTicketAttachmentHintInter13Regular(
            context,
            color: widgetColors.onSurfaceVariant,
          ),
        ),
      ],
    );

    return Material(
      color: widgetColors.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 20.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: widgetColors.outlineVariant,
              width: 1.5,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
          ),
          child: content,
        ),
      ),
    );
  }
}
