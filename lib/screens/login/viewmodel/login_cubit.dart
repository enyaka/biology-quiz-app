import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<int> {
  final String _key = 'score';
  int _totalScore = 0;
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
    _preferences!.setInt(_key, totalScore);
  }

  _loadFromPreferences() async {
    await _initialPreferences();
    _totalScore = _preferences!.getInt(_key) ?? 0;
    emit(_totalScore);
  }

  void addToScore(int score) {
    _totalScore = totalScore + score;
    _savePreferences();
    emit(totalScore);
  }
}
