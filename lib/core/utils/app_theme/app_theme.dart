import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_colors/dark_colors.dart';
import 'package:helpdesk_lite/core/utils/app_colors/light_colors.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';

class AppTheme {
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: DarkColors().background,
    extensions: [AppThemeColors(colors: DarkColors())],
  );
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: LightColors().background,
    extensions: [AppThemeColors(colors: LightColors())],
  );
}
