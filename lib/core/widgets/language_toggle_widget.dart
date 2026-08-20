import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app%20fonts/app_fonts.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app_theme/app_theme_colors.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/localization_service/localization_cubit/localization_cubit.dart';

/// Interactive button widget to toggle application language between Arabic
/// and English using LocalizationCubit.
class LanguageToggleWidget extends StatelessWidget {
  const LanguageToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final widgetColors =
        Theme.of(context).extension<AppThemeColors>()!.colors;

    return BlocBuilder<LocalizationCubit, SupportedLanguages>(
      builder: (context, currentLanguage) {
        final isArabic = currentLanguage == SupportedLanguages.arabic;
        final label = isArabic ? 'English' : 'العربية';

        // Container with subtle border and theme-aware hover surface
        return InkWell(
          onTap: () => context.read<LocalizationCubit>().toggle(),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: widgetColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: widgetColors.outlineVariant.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Language icon indicator
                Icon(
                  Icons.language,
                  size: 16,
                  color: widgetColors.primary,
                ),
                const SizedBox(width: 6),
                // Target language label
                Text(
                  label,
                  style: AppFonts().mobileCoreLanguageToggleInter12Medium(
                    context,
                    color: widgetColors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
