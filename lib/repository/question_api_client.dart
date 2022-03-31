import 'dart:convert';

import '../screens/quizpage/model/question.dart';
import 'package:flutter/services.dart';

class QuestionApiClient {
  static const _path = 'assets/questions/';

  Future<List<QuestionModel>?> getQuestions(String type) async {
    const localPathAyt = _path + 'ayt.json';
    const localPathTyt = _path + 'tyt.json';
    switch (type) {
      case 'tyt':
        final response = await rootBundle.loadString(localPathTyt);
        final returnedAnswer = jsonDecode(response);
        final list = Question.fromJson(returnedAnswer).questions;
        return list;
      case 'ayt':
        final response = await rootBundle.loadString(localPathAyt);
        final returnedAnswer = jsonDecode(response);
        final list = Question.fromJson(returnedAnswer).questions;
        return list;
      default:
        final responseTyt = await rootBundle.loadString(localPathTyt);
        final responseAyt = await rootBundle.loadString(localPathAyt);
        final returnedListTyt =
            Question.fromJson(jsonDecode(responseTyt)).questions;
        final returnedListAyt =
            Question.fromJson(jsonDecode(responseAyt)).questions;
        returnedListTyt!.addAll(returnedListAyt!);

        return returnedListTyt;
    }
  }
}
