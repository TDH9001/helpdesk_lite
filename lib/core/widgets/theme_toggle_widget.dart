import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/app_theme/theme_cubit/theme_cubit.dart';

/// Segmented pill toggle widget allowing users to switch between Light and Dark
/// themes using ThemeCubit.
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

    return BlocBuilder<ThemeCubit, ThemeModes>(
      builder: (context, currentMode) {
        final isDark = currentMode == ThemeModes.dark;

        // Outer pill container holding both theme segment options
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: widgetColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: widgetColors.outlineVariant.withValues(alpha: 0.35),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Light theme segment
              _ThemeSegment(
                icon: Icons.light_mode_outlined,
                title: 'Light',
                isSelected: !isDark,
                onTap: () {
                  if (isDark) {
                    context.read<ThemeCubit>().toggleTheme();
                    onToggle?.call();
                  }
                },
              ),
              // Dark theme segment
              _ThemeSegment(
                icon: Icons.dark_mode_outlined,
                title: 'Dark',
                isSelected: isDark,
                onTap: () {
                  if (!isDark) {
                    context.read<ThemeCubit>().toggleTheme();
                    onToggle?.call();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Private individual theme option button for ThemeToggleWidget.
class _ThemeSegment extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeSegment({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors =
        Theme.of(context).extension<AppThemeColors>()!.colors;

    // Interactive button with animated background pill
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isSelected ? widgetColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected
                  ? widgetColors.onPrimary
                  : widgetColors.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: isSelected
                  ? AppFonts().mobileCoreThemeToggleActiveInter13SemiBold(
                      context,
                      color: widgetColors.onPrimary,
                    )
                  : AppFonts().mobileCoreThemeToggleInactiveInter13Medium(
                      context,
                      color: widgetColors.onSurfaceVariant,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
