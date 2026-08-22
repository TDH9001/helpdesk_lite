import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/chat_message_model.dart';
import 'package:helpdesk_lite/core/widgets/image_preview_dialog_widget.dart';

/// Single chat message bubble with distinct styles for customer vs worker messages.
class CustomerChatBubbleWidget extends StatelessWidget {
  final ChatMessageModel message;
  final String workerTag;
  final String youTag;

  const CustomerChatBubbleWidget({
    super.key,
    required this.message,
    required this.workerTag,
    required this.youTag,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;
    final isCustomer = message.isCustomer;

    // Sender name label
    final senderLabel = isCustomer
        ? youTag
        : (message.senderName ?? workerTag);

    // Bubble decoration
    final bubbleDecoration = BoxDecoration(
      color: isCustomer
          ? widgetColors.primary
          : widgetColors.surfaceContainerHigh,
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(16.0),
        topRight: const Radius.circular(16.0),
        bottomLeft: Radius.circular(isCustomer ? 16.0 : 4.0),
        bottomRight: Radius.circular(isCustomer ? 4.0 : 16.0),
      ),
      border: isCustomer
          ? null
          : Border.all(
              color: widgetColors.outlineVariant.withValues(alpha: 0.5),
              width: 1.0,
            ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 4.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    );

    // Text color
    final textColor = isCustomer
        ? widgetColors.onPrimary
        : widgetColors.onSurface;

    final timeColor = isCustomer
        ? widgetColors.onPrimary.withValues(alpha: 0.75)
        : widgetColors.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment:
            isCustomer ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Agent avatar icon if worker
          if (!isCustomer) ...[
            CircleAvatar(
              radius: 14.0,
              backgroundColor: widgetColors.primaryContainer,
              child: Icon(
                Icons.support_agent_rounded,
                size: 16.0,
                color: widgetColors.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 8.0),
          ],
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 10.0,
              ),
              decoration: bubbleDecoration,
              child: Column(
                crossAxisAlignment: isCustomer
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  // Sender name header for non-customer
                  if (!isCustomer) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          senderLabel,
                          style: AppFonts()
                              .mobileCustomerChatBubbleSenderInter12SemiBold(
                            context,
                            color: widgetColors.primary,
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 1.0,
                          ),
                          decoration: BoxDecoration(
                            color: widgetColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            workerTag,
                            style: AppFonts()
                                .mobileCustomerChatBubbleTimeInter10Regular(
                              context,
                              color: widgetColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                  ],
                  // Message content text
                  if (message.content.isNotEmpty) ...[
                    Text(
                      message.content,
                      style: AppFonts()
                          .mobileCustomerChatBubbleMessageInter14Regular(
                        context,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                  ],
                  // Message attachments if any
                  if (message.attachments.isNotEmpty) ...[
                    Wrap(
                      spacing: 6.0,
                      runSpacing: 6.0,
                      children: message.attachments.map((url) {
                        final lower = url.toLowerCase().split('?').first;
                        final isImg = lower.endsWith('.png') ||
                            lower.endsWith('.jpg') ||
                            lower.endsWith('.jpeg') ||
                            lower.endsWith('.webp') ||
                            lower.endsWith('.gif');

                        return Container(
                          constraints: const BoxConstraints(
                            maxWidth: 180.0,
                            maxHeight: 140.0,
                          ),
                          decoration: BoxDecoration(
                            color: isCustomer
                                ? Colors.white.withValues(alpha: 0.15)
                                : widgetColors.surface,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: isImg
                              ? InkWell(
                                  onTap: () => ImagePreviewDialogWidget.show(
                                    context,
                                    imageUrl: url,
                                  ),
                                  child: Image.network(
                                    url,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Icon(
                                        Icons.broken_image_rounded,
                                        color: textColor,
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.insert_drive_file_rounded,
                                        size: 18.0,
                                        color: textColor,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Flexible(
                                        child: Text(
                                          url.split('/').last.split('?').first,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFonts()
                                              .mobileCustomerChatBubbleTimeInter10Regular(
                                            context,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 6.0),
                  ],
                  // Timestamp
                  Text(
                    message.formattedTime,
                    style: AppFonts()
                        .mobileCustomerChatBubbleTimeInter10Regular(
                      context,
                      color: timeColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
