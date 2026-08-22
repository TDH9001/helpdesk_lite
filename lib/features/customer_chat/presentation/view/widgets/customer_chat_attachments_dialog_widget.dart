import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Modal dialog overlay displaying all attachments and images belonging to a ticket.
class CustomerChatAttachmentsDialogWidget extends StatelessWidget {
  final List<String> attachments;
  final String title;
  final String noAttachmentsText;

  const CustomerChatAttachmentsDialogWidget({
    super.key,
    required this.attachments,
    required this.title,
    required this.noAttachmentsText,
  });

  /// Helper to open the dialog easily from any build context.
  static Future<void> show(
    BuildContext context, {
    required List<String> attachments,
    required String title,
    required String noAttachmentsText,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => CustomerChatAttachmentsDialogWidget(
        attachments: attachments,
        title: title,
        noAttachmentsText: noAttachmentsText,
      ),
    );
  }

  bool _isImageUrl(String url) {
    final lower = url.toLowerCase().split('?').first;
    return lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.webp') ||
        lower.endsWith('.gif');
  }

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Header with title and close button
    final headerRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.collections_rounded,
              color: widgetColors.primary,
              size: 20.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              '$title (${attachments.length})',
              style: AppFonts().mobileCustomerChatDialogTitleInter16Bold(
                context,
                color: widgetColors.onSurface,
              ),
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.close_rounded,
            color: widgetColors.onSurfaceVariant,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );

    // Content view
    Widget bodyContent;
    if (attachments.isEmpty) {
      bodyContent = Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.image_not_supported_outlined,
                size: 48.0,
                color: widgetColors.outlineVariant,
              ),
              const SizedBox(height: 12.0),
              Text(
                noAttachmentsText,
                textAlign: TextAlign.center,
                style: AppFonts().mobileCustomerChatEmptyMessageInter14Regular(
                  context,
                  color: widgetColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      bodyContent = ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 450.0),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 1.0,
          ),
          itemCount: attachments.length,
          itemBuilder: (context, index) {
            final url = attachments[index];
            final isImg = _isImageUrl(url);

            return InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () {
                // Show full preview in new dialog
                showDialog(
                  context: context,
                  builder: (ctx) => Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: const EdgeInsets.all(16.0),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: CachedNetworkImage(
                            imageUrl: url,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.black54,
                              padding: const EdgeInsets.all(24.0),
                              child: const Icon(
                                Icons.broken_image_rounded,
                                color: Colors.white,
                                size: 48.0,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 28.0,
                          ),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: widgetColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: widgetColors.outlineVariant.withValues(alpha: 0.6),
                    width: 1.0,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: isImg
                    ? CachedNetworkImage(
                        imageUrl: url,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2.0),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.broken_image_rounded,
                          color: widgetColors.outlineVariant,
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.insert_drive_file_rounded,
                              size: 36.0,
                              color: widgetColors.primary,
                            ),
                            const SizedBox(height: 6.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                url.split('/').last.split('?').first,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts()
                                    .mobileCustomerChatBubbleTimeInter10Regular(
                                  context,
                                  color: widgetColors.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            );
          },
        ),
      );
    }

    return Dialog(
      backgroundColor: widgetColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      insetPadding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(maxWidth: 520.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            headerRow,
            const Divider(height: 20.0),
            bodyContent,
          ],
        ),
      ),
    );
  }
}
