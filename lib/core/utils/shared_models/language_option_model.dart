import 'package:mvvvm_template_with_basic_services/core/utils/localization_service/localization_cubit/localization_cubit.dart';

class LanguageOptionModel {
  final String label;
  final SupportedLanguages language;

  const LanguageOptionModel({required this.label, required this.language});
}
