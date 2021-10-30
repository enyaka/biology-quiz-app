import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  String? title;
  List<QuestionModel>? questions;

  Question({
    this.title,
    this.questions,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class QuestionModel {
  int? id;
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? rightAnswer;
  QuestionModel({
    this.id,
    this.question,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.rightAnswer,
  });
  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
