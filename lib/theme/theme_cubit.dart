import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class ThemeCubit extends Cubit<ThemeData> {
  bool isDark = false;
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
    scaffoldBackgroundColor: kWhiteModeBackgroundColor,
  );
  static final _darkTheme = ThemeData(
    scaffoldBackgroundColor: kDarkModeBackrgoundColor,
  );
  void changeMode(bool newMode) {
    isDark = newMode;
    emit(isDark ? _darkTheme : _lightTheme);
  }
}
