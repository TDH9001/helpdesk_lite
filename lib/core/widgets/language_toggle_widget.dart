import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/localization_service/localization_cubit/localization_cubit.dart';

/// Segmented pill toggle widget allowing users to switch between English
/// and Arabic languages.
class LanguageToggleWidget extends StatelessWidget {
  const LanguageToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final widgetColors =
        Theme.of(context).extension<AppThemeColors>()!.colors;

    return BlocBuilder<LocalizationCubit, SupportedLanguages>(
      builder: (context, currentLanguage) {
        final isArabic = currentLanguage == SupportedLanguages.arabic;

        // Outer pill container holding both language segment options
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
              // English segment option
              _LanguageSegment(
                title: 'English',
                isSelected: !isArabic,
                onTap: () {
                  if (isArabic) {
                    context.read<LocalizationCubit>().setLanguage(
                          SupportedLanguages.english,
                        );
                  }
                },
              ),
              // Arabic segment option
              _LanguageSegment(
                title: 'العربية',
                isSelected: isArabic,
                onTap: () {
                  if (!isArabic) {
                    context.read<LocalizationCubit>().setLanguage(
                          SupportedLanguages.arabic,
                        );
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

/// Private individual language option button for LanguageToggleWidget.
class _LanguageSegment extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageSegment({
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
          horizontal: 16,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isSelected ? widgetColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: isSelected
              ? AppFonts().mobileCoreLanguageToggleActiveCairo13SemiBold(
                  context,
                  color: widgetColors.onPrimary,
                )
              : AppFonts().mobileCoreLanguageToggleInactiveCairo13Medium(
                  context,
                  color: widgetColors.onSurfaceVariant,
                ),
        ),
      ),
    );
  }
}
