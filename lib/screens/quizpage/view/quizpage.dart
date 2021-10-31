// ignore_for_file: prefer_const_constructors

import 'package:enyaka_biology_quiz/constants.dart';
import 'package:enyaka_biology_quiz/repository/question_api_client.dart';
import 'package:enyaka_biology_quiz/screens/quizpage/model/question.dart';
import 'package:enyaka_biology_quiz/screens/quizpage/view/widgets/my_alert_diolog.dart';
import 'package:enyaka_biology_quiz/screens/quizpage/view/widgets/quest_box.dart';
import 'package:enyaka_biology_quiz/screens/quizpage/view/widgets/quest_buttons.dart';
import 'package:enyaka_biology_quiz/screens/quizpage/view/widgets/upbar.dart';
import 'package:enyaka_biology_quiz/screens/quizpage/viewmodel/quizpage_provider.dart';
import 'package:enyaka_biology_quiz/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../locator.dart';

class QuizPage extends StatelessWidget {
  final String type;
  const QuizPage({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = BlocProvider.of<ThemeCubit>(context);
    return FutureBuilder<List<QuestionModel>?>(
      future: _getData(type),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ChangeNotifierProvider(
              create: (_) => QuestionManager(
                  quest: snapshot.data,
                  listLength: snapshot.data!.length,
                  isDark: _theme.isDark),
              child: QuizPageView());
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
            'BEKLENMEDİK BİR HATA OLUŞTU',
            style: Theme.of(context).textTheme.headline5,
          ));
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: _theme.isDark ? Colors.white : Colors.blue,
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<QuestionModel>?> _getData(String type) async {
    final QuestionApiClient _questionApiClient = locator<QuestionApiClient>();
    final List<QuestionModel>? questions =
        await _questionApiClient.getQuestions(type);
    return questions;
  }
}

class QuizPageView extends StatelessWidget {
  const QuizPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = BlocProvider.of<ThemeCubit>(context);
    final _provider = Provider.of<QuestionManager>(context, listen: false);
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        bool _answer = await _onWillPopScope(context, _theme);
        _answer ? Navigator.pop(context, _provider.score) : false;
        return _answer;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 1.5.h),
        child: Column(
          children: const [
            Expanded(
              child: UpBar(),
              flex: 1,
            ),
            Expanded(
              child: QuestBox(),
              flex: 8,
            ),
            Expanded(
              child: QuestButtons(),
              flex: 10,
            )
          ],
        ),
      ),
    ));
  }

  Future<bool> _onWillPopScope(BuildContext context, ThemeCubit theme) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return MyAlertDiolog();
        });
  }
}
