import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app_theme/app_theme.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/app_theme/theme_cubit/theme_cubit.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/localization_service/app_localizations.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/localization_service/localization_cubit/localization_cubit.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/routing_service/routing-service.dart';

//! need toa dd DIO and it's functions to app
void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LocalizationCubit()),
          BlocProvider(create: (context) => ThemeCubit()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, SupportedLanguages>(
      builder: (context, languages) => BlocBuilder<ThemeCubit, ThemeModes>(
        builder: (context, currentMode) => MaterialApp.router(
          locale: languages == SupportedLanguages.arabic
              ? const Locale('ar')
              : const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: RoutingService.router,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: currentMode == ThemeModes.dark
              ? ThemeMode.dark
              : ThemeMode.light,
        ),
      ),
    );
  }
}
