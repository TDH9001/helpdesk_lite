import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_colors/app_colros.dart';

class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final AppColors colors;

  AppThemeColors({required this.colors});

  @override
  AppThemeColors copyWith({AppColors? colors}) {
    return AppThemeColors(colors: colors ?? this.colors);
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    return this;
  }

  /*using the colors example

    color: Theme.of(
        context,
      ).extension<AppThemeColors>()!.colors.primaryContainer,

  */
}
