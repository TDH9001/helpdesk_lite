import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Centralized SnackBar service for displaying contextual banners and errors.
class SnackBarService {
  SnackBarService._();

  /// Displays an informational banner message.
  static void showInfo(BuildContext context, String message) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.info_outline_rounded,
              color: widgetColors.primary,
              size: 20.0,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                message,
                style: AppFonts().mobileCoreSnackBarInter14Medium(
                  context,
                  color: widgetColors.onSurface,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: widgetColors.surfaceContainerHigh,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.3),
            width: 1.0,
          ),
        ),
      ),
    );
  }

  /// Displays an error alert banner message.
  static void showError(BuildContext context, String errorMessage) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: widgetColors.error,
              size: 20.0,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                errorMessage,
                style: AppFonts().mobileCoreSnackBarInter14Medium(
                  context,
                  color: widgetColors.onSurface,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: widgetColors.surfaceContainerHigh,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: widgetColors.error.withValues(alpha: 0.5),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
