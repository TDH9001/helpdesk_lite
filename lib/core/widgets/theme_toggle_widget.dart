import 'package:flutter/material.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app_theme/app_theme_colors.dart';

/// Interactive button widget to toggle application theme between Light and Dark
/// modes with animated icon indicator.
class ThemeToggleWidget extends StatelessWidget {
  final VoidCallback? onToggle;

  const ThemeToggleWidget({
    super.key,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors =
        Theme.of(context).extension<AppThemeColors>()!.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Interactive button container with outline and background
    return InkWell(
      onTap: () {
        //! <Where ThemeCubit / theme mode toggle state management should be handled>
        onToggle?.call();
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: widgetColors.surfaceContainerLow,
          shape: BoxShape.circle,
          border: Border.all(
            color: widgetColors.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        // Theme mode icon representation
        child: Icon(
          isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          size: 18,
          color: isDark ? widgetColors.tertiaryFixed : widgetColors.primary,
        ),
      ),
    );
  }
}
