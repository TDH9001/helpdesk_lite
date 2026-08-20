import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/widgets/language_toggle_widget.dart';
import 'package:helpdesk_lite/core/widgets/theme_toggle_widget.dart';

/// Top bar for desktop layout featuring the language toggle on the left
/// and the theme mode toggle on the right.
class MyTicketsHeaderDesktop extends StatelessWidget {
  const MyTicketsHeaderDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Language toggle on the left, theme mode toggle on the right
    return Container(
      height: 60.0,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: widgetColors.surface,
        border: Border(
          bottom: BorderSide(
            color: widgetColors.outlineVariant.withValues(alpha: 0.5),
            width: 1.0,
          ),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Language switch control
          LanguageToggleWidget(),
          // Right: Theme mode switch control
          ThemeToggleWidget(),
        ],
      ),
    );
  }
}
