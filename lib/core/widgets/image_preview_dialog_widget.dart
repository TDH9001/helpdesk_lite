import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Modal dialog overlay displaying a full-resolution preview of an image attachment.
class ImagePreviewDialogWidget extends StatelessWidget {
  final String imageUrl;

  const ImagePreviewDialogWidget({
    super.key,
    required this.imageUrl,
  });

  /// Displays the full-screen image preview modal dialog over the given BuildContext.
  static Future<void> show(
    BuildContext context, {
    required String imageUrl,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => ImagePreviewDialogWidget(imageUrl: imageUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Modal dialog container with dark translucent backdrop and close button
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          // Expanded Image View
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: InteractiveViewer(
              minScale: 0.8,
              maxScale: 4.0,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => Container(
                  padding: const EdgeInsets.all(48.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: widgetColors.primary,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: widgetColors.surfaceContainerHigh,
                  padding: const EdgeInsets.all(32.0),
                  child: Icon(
                    Icons.broken_image_rounded,
                    color: widgetColors.error,
                    size: 48.0,
                  ),
                ),
              ),
            ),
          ),
          // Close button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: widgetColors.surface.withValues(alpha: 0.8),
              shape: const CircleBorder(),
              child: IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  color: widgetColors.onSurface,
                  size: 24.0,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
