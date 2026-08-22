import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Modal dialog for inspecting attachments linked to the ticket in Worker Chat.
class WorkerChatAttachmentsDialogWidget extends StatelessWidget {
  final List<String> attachments;
  final String title;
  final String noAttachmentsText;

  const WorkerChatAttachmentsDialogWidget({
    super.key,
    required this.attachments,
    required this.title,
    required this.noAttachmentsText,
  });

  /// Displays the modal dialog over current BuildContext.
  static Future<void> show(
    BuildContext context, {
    required List<String> attachments,
    required String title,
    required String noAttachmentsText,
  }) {
    return showDialog(
      context: context,
      builder: (context) => WorkerChatAttachmentsDialogWidget(
        attachments: attachments,
        title: title,
        noAttachmentsText: noAttachmentsText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor: widgetColors.surface,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        constraints: const BoxConstraints(maxWidth: 480.0, maxHeight: 520.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppFonts()
                      .mobileCustomerChatDialogTitleInter16Bold(
                    context,
                    color: widgetColors.onSurface,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: widgetColors.onSurfaceVariant,
                  ),
                  onPressed: () => context.pop(),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8.0),
            if (attachments.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36.0),
                child: Center(
                  child: Text(
                    noAttachmentsText,
                    style: AppFonts()
                        .mobileCustomerChatEmptyMessageInter14Regular(
                      context,
                      color: widgetColors.onSurfaceVariant,
                    ),
                  ),
                ),
              )
            else
              Flexible(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: attachments.length,
                  itemBuilder: (context, index) {
                    final url = attachments[index];
                    final lower = url.toLowerCase().split('?').first;
                    final isImage = lower.endsWith('.png') ||
                        lower.endsWith('.jpg') ||
                        lower.endsWith('.jpeg') ||
                        lower.endsWith('.webp') ||
                        lower.endsWith('.gif');

                    return Container(
                      decoration: BoxDecoration(
                        color: widgetColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: widgetColors.outlineVariant
                              .withValues(alpha: 0.5),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: isImage
                          ? Image.network(
                              url,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Center(
                                child: Icon(
                                  Icons.broken_image_rounded,
                                  color: widgetColors.onSurfaceVariant,
                                ),
                              ),
                            )
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.insert_drive_file_rounded,
                                      size: 32.0,
                                      color: widgetColors.primary,
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      url.split('/').last.split('?').first,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFonts()
                                          .mobileCustomerChatBubbleTimeInter10Regular(
                                        context,
                                        color: widgetColors.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
