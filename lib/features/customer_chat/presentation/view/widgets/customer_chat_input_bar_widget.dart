import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_attachment_item.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view/widgets/customer_chat_attachment_card_widget.dart';

/// Bottom bar for composing messages and attaching files in chat.
class CustomerChatInputBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final bool isSending;
  final List<TicketAttachmentItem> attachments;
  final String Function(int count) attachmentCountLabel;
  final VoidCallback onAttachTap;
  final VoidCallback onClearAttachments;
  final VoidCallback onSendTap;

  const CustomerChatInputBarWidget({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.isSending,
    required this.attachments,
    required this.attachmentCountLabel,
    required this.onAttachTap,
    required this.onClearAttachments,
    required this.onSendTap,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Attach button icon
    final attachButton = IconButton(
      icon: Icon(
        Icons.attach_file_rounded,
        color: widgetColors.onSurfaceVariant,
        size: 22.0,
      ),
      onPressed: isSending ? null : onAttachTap,
      tooltip: 'Attach files',
    );

    // Text field input
    final textInput = TextField(
      controller: controller,
      enabled: !isSending,
      maxLines: 4,
      minLines: 1,
      textInputAction: TextInputAction.send,
      onSubmitted: (_) => onSendTap(),
      style: AppFonts().mobileCustomerChatInputPlaceholderInter14Regular(
        context,
        color: widgetColors.onSurface,
      ),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle:
            AppFonts().mobileCustomerChatInputPlaceholderInter14Regular(
          context,
          color: widgetColors.onSurfaceVariant,
        ),
        border: InputBorder.none,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 10.0,
        ),
      ),
    );

    // Send action button
    final sendButton = Container(
      margin: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: Material(
        color: widgetColors.primary,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: isSending ? null : onSendTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: isSending
                ? SizedBox(
                    width: 18.0,
                    height: 18.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widgetColors.onPrimary,
                      ),
                    ),
                  )
                : Icon(
                    Icons.send_rounded,
                    size: 18.0,
                    color: widgetColors.onPrimary,
                  ),
          ),
        ),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: widgetColors.surface,
        border: Border(
          top: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.5),
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pending attachments preview card
            if (attachments.isNotEmpty)
              CustomerChatAttachmentCardWidget(
                attachments: attachments,
                attachmentCountLabel: attachmentCountLabel,
                onClear: onClearAttachments,
              ),
            // Message input row
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  attachButton,
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: widgetColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: widgetColors.outlineVariant
                              .withValues(alpha: 0.5),
                          width: 1.0,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: textInput,
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  sendButton,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
