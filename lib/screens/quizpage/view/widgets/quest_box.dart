import '../../viewmodel/quizpage_provider.dart';
import '../../../../theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../../constants.dart';

class QuestBox extends StatelessWidget {
  const QuestBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<QuestionManager>(context);
    final _theme = BlocProvider.of<ThemeCubit>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 1.5.h),
      child: Container(
          decoration: BoxDecoration(
              color: _theme.isDark ? kDarkQuestBoxColor : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: _theme.isDark ? Colors.black87 : Colors.grey,
                    offset: const Offset(0.0, 5.0), //(x,y)
                    blurRadius: 17.0,
                    spreadRadius: -4.5),
              ]),
          width: double.infinity,
          child: myQuestBox(_theme, _provider)),
    );
  }
}

Padding myQuestBox(ThemeCubit theme, QuestionManager provider) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.0.w, vertical: 3.0.h),
      child: AnimatedOpacity(
        opacity: provider.opacity ? 1 : 0,
        duration: const Duration(seconds: 1),
        child: Center(
          child: AutoSizeText(
            provider.question,
            style: TextStyle(
              color: theme.isDark ? Colors.white : Colors.grey[800],
              fontSize: 25.0.sp,
            ),
          ),
        ),
      ),
    );
