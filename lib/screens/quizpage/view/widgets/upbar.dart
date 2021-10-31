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
            icon: const Icon(Icons.arrow_back_rounded)),
        Row(
          children: [
            Image(
              image: const AssetImage('assets/images/star.png'),
              height: 3.0.h,
              width: 7.0.w,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.0.w),
              child: Text('Skor : ' + _provider.score.toString(),
                  style: TextStyle(
                      fontSize: 15.0.sp,
                      color: _theme.isDark ? Colors.white : Colors.grey[800])),
            ),
          ],
        ),
        IconButton(
          onPressed: () async {
            await showDialog(
                context: context,
                builder: (context) {
                  return BugReport(questionID: _provider.questionID, question: _provider.question,);
                });
          },
          icon: Icon(
            Icons.bug_report_rounded,
            color: Colors.yellow.shade700,
            size: 4.0.h,
          ),
        )
      ],
    );
  }
}
