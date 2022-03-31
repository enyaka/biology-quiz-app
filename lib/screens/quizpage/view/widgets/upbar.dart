// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:enyaka_biology_quiz/screens/quizpage/view/widgets/bug_report.dart';
import 'package:enyaka_biology_quiz/screens/quizpage/view/widgets/my_alert_diolog.dart';
import 'package:enyaka_biology_quiz/screens/quizpage/viewmodel/quizpage_provider.dart';
import 'package:enyaka_biology_quiz/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UpBar extends StatelessWidget {
  const UpBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<QuestionManager>(context);
    final _theme = BlocProvider.of<ThemeCubit>(context);
    const _imagePath = 'assets/images/star.png';
    const String _scoreText = 'Skor : ';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () async {
              bool returnedAnswer = await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const MyAlertDiolog();
                  });
              returnedAnswer ? Navigator.pop(context, _provider.score) : false;
            },
            icon: Icon(Icons.arrow_back_rounded,
                color: _theme.isDark ? Colors.white : Colors.grey[800])),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
          child: Row(
            children: [
              Image(
                image: AssetImage(_imagePath),
                height: 3.0.h,
                width: 6.7.w,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.0.w),
                child: Text(_scoreText + _provider.score.toString(),
                    style: TextStyle(
                        fontSize: 15.0.sp,
                        color:
                            _theme.isDark ? Colors.white : Colors.grey[800])),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () async {
            await showGeneralDialog(
                //barrierColor: Colors.black.withOpacity(0.5),
                transitionBuilder: (context, a1, a2, widget) {
                  final curvedValue =
                      Curves.easeInOutBack.transform(a1.value) - 1.0;
                  return Transform(
                    transform:
                        Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                    child: Opacity(
                      opacity: a1.value,
                      child: BugReport(
                        questionID: _provider.questionID,
                        question: _provider.question,
                      ),
                    ),
                  );
                },
                transitionDuration: Duration(milliseconds: 200),
                barrierDismissible: true,
                barrierLabel: '',
                context: context,
                pageBuilder: (context, animation1, animation2) {
                  return Text('data');
                });
          },
          icon: Icon(
            Icons.bug_report_rounded,
            color: _theme.isDark ? Colors.white : Colors.grey[800],
            size: 3.5.h,
          ),
        )
      ],
    );
  }
}
