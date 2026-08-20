import 'package:flutter_bloc/flutter_bloc.dart';

enum ThemeModes { light, dark }

class ThemeCubit extends Cubit<ThemeModes> {
  ThemeCubit() : super(ThemeModes.dark);
}
