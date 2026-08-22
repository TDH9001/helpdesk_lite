import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

/// Progress bar widget replacing the submit button during file uploads and submission.
class CreateTicketUploadProgressWidget extends StatelessWidget {
  final double progress; // Value between 0.0 and 1.0
  final String statusMessage;

  const CreateTicketUploadProgressWidget({
    super.key,
    required this.progress,
    required this.statusMessage,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    final clampedProgress = progress.clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: widgetColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: widgetColors.outlineVariant.withValues(alpha: 0.5),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 14.0,
                    height: 14.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(widgetColors.primary),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    statusMessage,
                    style: AppFonts()
                        .mobileCreateTicketUploadProgressInter12Medium(
                      context,
                      color: widgetColors.onSurface,
                    ),
                  ),
                ],
              ),
              Text(
                '${(clampedProgress * 100).toInt()}%',
                style: AppFonts()
                    .mobileCreateTicketUploadProgressInter12Medium(
                  context,
                  color: widgetColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(9999.0),
            child: LinearProgressIndicator(
              value: clampedProgress,
              minHeight: 6.0,
              backgroundColor: widgetColors.surfaceContainerHighest,
              valueColor:
                  AlwaysStoppedAnimation<Color>(widgetColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
