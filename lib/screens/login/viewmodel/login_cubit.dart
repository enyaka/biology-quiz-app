// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<int> {
  final String _key = 'score';
  int _totalScore = 0;

  set totalScore(int value) => _totalScore = value;
  int get totalScore => _totalScore;
  SharedPreferences? _preferences;
  LoginCubit() : super(0) {
    _loadFromPreferences();
  }
  _initialPreferences() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  _savePreferences() async {
    await _initialPreferences();
    debugPrint('Total skor : ' + _totalScore.toString());
    _preferences!.setInt(_key, _totalScore);
    _loadFromPreferences();
  }

  _loadFromPreferences() async {
    await _initialPreferences();
    _totalScore = _preferences!.getInt(_key) ?? 0;
    emit(_totalScore);
  }

  void addToScore(int score) {
    final newScore = totalScore + score;
    _totalScore = newScore;
    debugPrint('YENİ TOPLAM SKOR ' + newScore.toString());
    _savePreferences();
  }
}
