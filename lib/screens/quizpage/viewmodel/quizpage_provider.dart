// ignore_for_file: unnecessary_getters_setters, curly_braces_in_flow_control_structures, prefer_final_fields
import 'dart:math';

import 'package:enyaka_biology_quiz/constants.dart';
import 'package:enyaka_biology_quiz/screens/quizpage/model/question.dart';
import 'package:flutter/material.dart';

class QuestionManager extends ChangeNotifier {
  @override
  void dispose() {
    quest!.clear();
    super.dispose();
  }

  final List<QuestionModel>? quest;
  List<int> _numberKeeper = [];
  int _score = 0;
  Color? _buttonColorA;
  Color? _buttonColorB;
  Color? _buttonColorC;
  Color? _buttonColorD;
  bool isDark;
  int? _questionID;
  String? _question;
  String? _option1;
  String? _option2;
  String? _option3;
  String? _option4;
  String? _rightAnswer;

  int listLength;
  bool _opacity = true;

  QuestionManager(
      {required this.quest, required this.listLength, required this.isDark}) {
    if (isDark) {
      _buttonColorA = kDarkChoiceButtonColor;
      _buttonColorB = kDarkChoiceButtonColor;
      _buttonColorC = kDarkChoiceButtonColor;
      _buttonColorD = kDarkChoiceButtonColor;
    } else {
      _buttonColorA = kWhiteChoiceButtonColor;
      _buttonColorB = kWhiteChoiceButtonColor;
      _buttonColorC = kWhiteChoiceButtonColor;
      _buttonColorD = kWhiteChoiceButtonColor;
    }
    randomQuest();
  }
  get rightAnswer => _rightAnswer;
  set rightAnswer(value) => _rightAnswer = value;
  get questionID => _questionID;
  get question => _question;
  get option1 => _option1;
  get option2 => _option2;
  get option3 => _option3;
  get option4 => _option4;
  int get score => _score;
  set score(int value) => _score = value;
  bool get opacity => _opacity;
  set opacity(bool value) {
    _opacity = value;
    notifyListeners();
  }

  get buttonColorA => _buttonColorA;
  get buttonColorB => _buttonColorB;
  get buttonColorC => _buttonColorC;
  get buttonColorD => _buttonColorD;

  void randomQuest() {
    Random _random = Random();
    debugPrint(listLength.toString());
    int _randomNumb = _random.nextInt(listLength);
    randomNumberChecker(listLength, _randomNumb);
    notifyListeners();
  }

  void randomNumberChecker(int listLength, int rand) {
    bool _isThere = false;
    for (var element in _numberKeeper) {
      if (element == rand) _isThere = true;
    }
    debugPrint(_numberKeeper.toString());
    debugPrint(
        'Çekilen yeni sayıyı listede bulunuyor mu : $_isThere eğer bulunuyor ise bu sayı $rand');
    if (_isThere) {
      randomQuest();
    } else {
      if (_numberKeeper.length < 30) {
        _numberKeeper.add(rand);
        debugPrint('Bu quest numarasını listeye ekledim $rand');
        toObject(rand);
      } else {
        var index = _numberKeeper.removeAt(0);
        debugPrint('$index Numaralı Questi listeden çıkardım :)');
        _numberKeeper.add(rand);
        debugPrint('Çıkardığımın yerine $rand numaralı soruyu koydum');
        toObject(rand);
      }
    }
  }

  void toObject(int rand) {
    _questionID = quest![rand].id;
    _question = quest![rand].question;
    _option1 = quest![rand].option1;
    _option2 = quest![rand].option2;
    _option3 = quest![rand].option3;
    _option4 = quest![rand].option4;
    _rightAnswer = quest![rand].rightAnswer;
  }

  Future<void> animateButton(int index, bool isCorrect) async {
    //Doğru olan şıkkı ne olursa olsun yeşile çeviren yapı
    if (_option1 == _rightAnswer) {
      _buttonColorA = kCorrectAnswerColor;
    } else if (_option2 == _rightAnswer) {
      _buttonColorB = kCorrectAnswerColor;
    } else if (_option3 == _rightAnswer) {
      _buttonColorC = kCorrectAnswerColor;
    } else {
      _buttonColorD = kCorrectAnswerColor;
    }
    debugPrint(isCorrect.toString());
    if (!isCorrect) {
      //Eğer yanlış şık seçildiyse seçilen şıkkı kırmızıya çeviren yapı
      if (index == 0) {
        _buttonColorA = kWrongAnswerColor;
      } else if (index == 1) {
        _buttonColorB = kWrongAnswerColor;
      } else if (index == 2) {
        _buttonColorC = kWrongAnswerColor;
      } else {
        _buttonColorD = kWrongAnswerColor;
      }
    }
    _opacity = false;
    notifyListeners();
    //Soru cevaplandığında sorunun hemen değişmesini engeller böylece kullanıcı doğru şıkkı görüp okuyabilir.
    await Future.delayed(const Duration(milliseconds: 1500));
    if (isDark) {
      _buttonColorA = kDarkChoiceButtonColor;
      _buttonColorB = kDarkChoiceButtonColor;
      _buttonColorC = kDarkChoiceButtonColor;
      _buttonColorD = kDarkChoiceButtonColor;
    } else {
      _buttonColorA = kWhiteChoiceButtonColor;
      _buttonColorB = kWhiteChoiceButtonColor;
      _buttonColorC = kWhiteChoiceButtonColor;
      _buttonColorD = kWhiteChoiceButtonColor;
    }
    _opacity = true;
    notifyListeners();
  }
}
