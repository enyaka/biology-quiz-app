import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class ThemeCubit extends Cubit<ThemeData> {
  final String key = 'themeMode';
  bool isDark = false;
  SharedPreferences? _preferences;
  ThemeCubit() : super(_lightTheme) {
    _loadFromPreferences();
  }
  _initialPreferences() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  _savePreferences() async {
    await _initialPreferences();
    _preferences!.setBool(key, isDark);
  }

  _loadFromPreferences() async {
    await _initialPreferences();
    isDark = _preferences!.getBool(key) ?? false;
    emit(isDark ? _darkTheme : _lightTheme);
  }

  static final _lightTheme = ThemeData(
    scaffoldBackgroundColor: kWhiteModeBackgroundColor,
  );
  static final _darkTheme = ThemeData(
    scaffoldBackgroundColor: kDarkModeBackrgoundColor,
  );

  void changeMode(bool newMode) {
    isDark = newMode;
    _savePreferences();
    emit(isDark ? _darkTheme : _lightTheme);
  }
}
