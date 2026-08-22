import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/chat_message_model.dart';
import 'package:helpdesk_lite/core/widgets/image_preview_dialog_widget.dart';

/// Single chat message bubble with distinct styles for customer, worker public, and internal notes.
class WorkerChatBubbleWidget extends StatelessWidget {
  final ChatMessageModel message;
  final String workerTag;
  final String customerTag;
  final String youTag;
  final String internalBadgeLabel;

  const WorkerChatBubbleWidget({
    super.key,
    required this.message,
    required this.workerTag,
    required this.customerTag,
    required this.youTag,
    required this.internalBadgeLabel,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    final isInternal = message.isInternal;
    final isCustomer = message.isCustomer;

    // Sender name label
    final senderLabel = isCustomer
        ? (message.senderName ?? customerTag)
        : (message.senderName ?? workerTag);

    // Box Decoration
    BoxDecoration bubbleDecoration;
    Color textColor;
    Color timeColor;

    if (isInternal) {
      // Internal Note styling - distinctive amber/tertiary container
      bubbleDecoration = BoxDecoration(
        color: widgetColors.tertiaryContainer.withValues(alpha: 0.35),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(4.0),
        ),
        border: Border.all(
          color: widgetColors.tertiary.withValues(alpha: 0.5),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      );
      textColor = widgetColors.onSurface;
      timeColor = widgetColors.onSurfaceVariant;
    } else if (isCustomer) {
      // Customer message styling - left aligned
      bubbleDecoration = BoxDecoration(
        color: widgetColors.surfaceContainerHigh,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
          bottomLeft: Radius.circular(4.0),
          bottomRight: Radius.circular(16.0),
        ),
        border: Border.all(
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
      textColor = widgetColors.onSurface;
      timeColor = widgetColors.onSurfaceVariant;
    } else {
      // Agent Public Reply styling - right aligned
      bubbleDecoration = BoxDecoration(
        color: widgetColors.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(4.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      );
      textColor = widgetColors.onPrimary;
      timeColor = widgetColors.onPrimary.withValues(alpha: 0.75);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment:
            isCustomer ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Customer Avatar on the left
          if (isCustomer) ...[
            CircleAvatar(
              radius: 14.0,
              backgroundColor: widgetColors.secondaryContainer,
              child: Icon(
                Icons.person_outline_rounded,
                size: 16.0,
                color: widgetColors.onSecondaryContainer,
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
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  // Sender name header & badge
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isInternal) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: widgetColors.tertiary,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            internalBadgeLabel.toUpperCase(),
                            style: AppFonts()
                                .mobileWorkerChatInternalBadgeInter10Bold(
                              context,
                              color: widgetColors.onTertiary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6.0),
                      ],
                      Text(
                        senderLabel,
                        style: AppFonts()
                            .mobileWorkerChatBubbleSenderInter12SemiBold(
                          context,
                          color: isInternal
                              ? widgetColors.tertiary
                              : (isCustomer
                                  ? widgetColors.primary
                                  : widgetColors.onPrimary),
                        ),
                      ),
                      if (!isCustomer && !isInternal) ...[
                        const SizedBox(width: 6.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 1.0,
                          ),
                          decoration: BoxDecoration(
                            color: widgetColors.onPrimary
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            workerTag,
                            style: AppFonts()
                                .mobileWorkerChatBubbleTimeInter10Regular(
                              context,
                              color: widgetColors.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  // Message Text Content
                  if (message.content.isNotEmpty) ...[
                    Text(
                      message.content,
                      style: AppFonts()
                          .mobileWorkerChatBubbleMessageInter14Regular(
                        context,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                  ],
                  // Attachments if any
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
                                ? widgetColors.surface
                                : (isInternal
                                    ? widgetColors.surface
                                    : Colors.white.withValues(alpha: 0.15)),
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
                                              .mobileWorkerChatBubbleTimeInter10Regular(
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
                  // Time
                  Text(
                    message.formattedTime,
                    style: AppFonts().mobileWorkerChatBubbleTimeInter10Regular(
                      context,
                      color: timeColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Agent Avatar on the right
          if (!isCustomer) ...[
            const SizedBox(width: 8.0),
            CircleAvatar(
              radius: 14.0,
              backgroundColor: isInternal
                  ? widgetColors.tertiaryContainer
                  : widgetColors.primaryContainer,
              child: Icon(
                isInternal
                    ? Icons.lock_outline_rounded
                    : Icons.support_agent_rounded,
                size: 16.0,
                color: isInternal
                    ? widgetColors.onTertiaryContainer
                    : widgetColors.onPrimaryContainer,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
