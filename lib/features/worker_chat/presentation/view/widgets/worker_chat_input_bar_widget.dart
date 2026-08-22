import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_attachment_item.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_attachment_card_widget.dart';

/// Bottom composer input bar with mode toggle (Public Reply vs Internal Note) and rich action toolbar.
class WorkerChatInputBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isInternalNote;
  final String publicReplyTab;
  final String internalNoteTab;
  final String publicPlaceholder;
  final String internalPlaceholder;
  final String sendButtonLabel;
  final String addNoteButtonLabel;
  final String helperText;
  final String attachImageTooltip;
  final String attachFileTooltip;
  final bool isSending;
  final List<TicketAttachmentItem> attachments;
  final String Function(int count) attachmentCountLabel;
  final ValueChanged<bool> onModeChanged;
  final VoidCallback onAttachFile;
  final VoidCallback onAttachImage;
  final VoidCallback onClearAttachments;
  final void Function(int index) onRemoveAttachment;
  final VoidCallback onSendTap;

  const WorkerChatInputBarWidget({
    super.key,
    required this.controller,
    required this.isInternalNote,
    required this.publicReplyTab,
    required this.internalNoteTab,
    required this.publicPlaceholder,
    required this.internalPlaceholder,
    required this.sendButtonLabel,
    required this.addNoteButtonLabel,
    required this.helperText,
    required this.attachImageTooltip,
    required this.attachFileTooltip,
    required this.isSending,
    required this.attachments,
    required this.attachmentCountLabel,
    required this.onModeChanged,
    required this.onAttachFile,
    required this.onAttachImage,
    required this.onClearAttachments,
    required this.onRemoveAttachment,
    required this.onSendTap,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Mode segmented toggle
    final modeToggle = Container(
      decoration: BoxDecoration(
        color: widgetColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Public Reply Tab
          InkWell(
            onTap: isSending ? null : () => onModeChanged(false),
            borderRadius: BorderRadius.circular(6.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: !isInternalNote ? widgetColors.surface : Colors.transparent,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: !isInternalNote
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 3.0,
                          offset: const Offset(0.0, 1.0),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.public_rounded,
                    size: 14.0,
                    color: !isInternalNote
                        ? widgetColors.primary
                        : widgetColors.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    publicReplyTab,
                    style: AppFonts().mobileWorkerChatToggleTabInter12SemiBold(
                      context,
                      color: !isInternalNote
                          ? widgetColors.primary
                          : widgetColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 2.0),
          // Internal Note Tab
          InkWell(
            onTap: isSending ? null : () => onModeChanged(true),
            borderRadius: BorderRadius.circular(6.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: isInternalNote
                    ? widgetColors.tertiaryContainer.withValues(alpha: 0.5)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: isInternalNote
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 3.0,
                          offset: const Offset(0.0, 1.0),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 14.0,
                    color: isInternalNote
                        ? widgetColors.tertiary
                        : widgetColors.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    internalNoteTab,
                    style: AppFonts().mobileWorkerChatToggleTabInter12SemiBold(
                      context,
                      color: isInternalNote
                          ? widgetColors.tertiary
                          : widgetColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // Text field input
    final textInput = TextField(
      controller: controller,
      enabled: !isSending,
      maxLines: 4,
      minLines: 2,
      textInputAction: TextInputAction.newline,
      style: AppFonts().mobileWorkerChatInputPlaceholderInter14Regular(
        context,
        color: widgetColors.onSurface,
      ),
      decoration: InputDecoration(
        hintText: isInternalNote ? internalPlaceholder : publicPlaceholder,
        hintStyle: AppFonts().mobileWorkerChatInputPlaceholderInter14Regular(
          context,
          color: widgetColors.onSurfaceVariant.withValues(alpha: 0.7),
        ),
        border: InputBorder.none,
        isDense: true,
        contentPadding: const EdgeInsets.all(10.0),
      ),
    );

    // Send button styling based on mode
    final activeSendColor =
        isInternalNote ? widgetColors.tertiary : widgetColors.primary;
    final activeTextColor =
        isInternalNote ? widgetColors.onTertiary : widgetColors.onPrimary;
    final currentSendLabel =
        isInternalNote ? addNoteButtonLabel : sendButtonLabel;

    final sendButton = Material(
      color: activeSendColor,
      borderRadius: BorderRadius.circular(20.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: isSending ? null : onSendTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSending)
                SizedBox(
                  width: 14.0,
                  height: 14.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(activeTextColor),
                  ),
                )
              else ...[
                Text(
                  currentSendLabel,
                  style: AppFonts().mobileWorkerChatSendButtonInter12SemiBold(
                    context,
                    color: activeTextColor,
                  ),
                ),
                const SizedBox(width: 4.0),
                Icon(
                  Icons.send_rounded,
                  size: 14.0,
                  color: activeTextColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: widgetColors.surface,
        border: Border(
          top: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.4),
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Attachments Preview
            if (attachments.isNotEmpty)
              WorkerChatAttachmentCardWidget(
                attachments: attachments,
                attachmentCountLabel: attachmentCountLabel,
                onClear: onClearAttachments,
                onRemoveItem: onRemoveAttachment,
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mode Toggle on top of text field
                  modeToggle,
                  const SizedBox(height: 8.0),
                  // Input Box Container
                  Container(
                    decoration: BoxDecoration(
                      color: isInternalNote
                          ? widgetColors.tertiaryContainer.withValues(alpha: 0.15)
                          : widgetColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: isInternalNote
                            ? widgetColors.tertiary.withValues(alpha: 0.4)
                            : widgetColors.outlineVariant
                                .withValues(alpha: 0.5),
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        textInput,
                        // Toolbar Row
                        Padding(
                          padding: const EdgeInsets.fromLTRB(6.0, 0.0, 8.0, 6.0),
                          child: Row(
                            children: [
                              // File attachment button
                              IconButton(
                                icon: Icon(
                                  Icons.attach_file_rounded,
                                  size: 20.0,
                                  color: widgetColors.onSurfaceVariant,
                                ),
                                onPressed: isSending ? null : onAttachFile,
                                tooltip: attachFileTooltip,
                                visualDensity: VisualDensity.compact,
                              ),
                              // Image attachment button
                              IconButton(
                                icon: Icon(
                                  Icons.image_outlined,
                                  size: 20.0,
                                  color: widgetColors.onSurfaceVariant,
                                ),
                                onPressed: isSending ? null : onAttachImage,
                                tooltip: attachImageTooltip,
                                visualDensity: VisualDensity.compact,
                              ),
                              const Spacer(),
                              sendButton,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isInternalNote) ...[
                    const SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        helperText,
                        style: AppFonts()
                            .mobileWorkerChatHelperTextInter11Regular(
                          context,
                          color: widgetColors.tertiary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
