import 'package:flutter_bloc/flutter_bloc.dart';

enum SupportedLanguages { arabic, english }

class LocalizationCubit extends Cubit<SupportedLanguages> {
  LocalizationCubit() : super(SupportedLanguages.english);
  //cubit does not need classes really, jsut objects

  void setLanguage(SupportedLanguages language) => emit(language);
  /*
  to cahnge the lang

  context.read<LocaleCubit>().setLanguage(AppLanguage.arabic);
// or
context.read<LocaleCubit>().toggle();
 */
  void toggle() => state == SupportedLanguages.english
      ? emit(SupportedLanguages.arabic)
      : emit(SupportedLanguages.english);
}
