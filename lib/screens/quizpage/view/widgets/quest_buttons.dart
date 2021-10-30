import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/theme_cubit.dart';
import '../../viewmodel/quizpage_provider.dart';

class QuestButtons extends StatefulWidget {
  const QuestButtons({
    Key? key,
  }) : super(key: key);

  @override
  _QuestButtonsState createState() => _QuestButtonsState();
}

class _QuestButtonsState extends State<QuestButtons> {
  bool _isDisabled = false;
  @override
  Widget build(BuildContext context) {
    final _theme = BlocProvider.of<ThemeCubit>(context);
    var _provider = Provider.of<QuestionManager>(context);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 3.0.h),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 1.3.h),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            highlightColor: Colors.transparent,
            onTap: () => _isDisabled ? null : _checkAnswer(index, _provider),
            child: AnimatedContainer(
              width: 10.0.w,
              height: 7.0.h,
              decoration: BoxDecoration(
                color: _buttonColor(index, _provider),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      color: _theme.isDark ? Colors.black87 : Colors.grey,
                      offset: const Offset(0.0, 5.0), //(x,y)
                      blurRadius: 3.0,
                      spreadRadius: -4),
                ],
              ),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutExpo,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.5.w,
                ),
                child: Center(
                  child: AutoSizeText(
                    _getOptions(index, _provider),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0.sp,
                      color: _theme.isDark ? Colors.white : Colors.white,
                    ),
                    maxLines: 3,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      itemCount: 4,
    );
  }

  Future<void> _checkAnswer(int index, QuestionManager provider) async {
    _isDisabled = true;
    String pressedAnswer = _getOptions(index, provider);
    if (pressedAnswer == provider.rightAnswer) {
      debugPrint('Doğru cevap');
      provider.score++;
      await provider.animateButton(index, true);
      provider.randomQuest();
      debugPrint('************************************************');
      _isDisabled = false;
    } else {
      debugPrint('Yanlış');
      await provider.animateButton(index, false);
      provider.randomQuest();
      debugPrint('************************************************');
      _isDisabled = false;
    }
  }

  Color _buttonColor(int index, QuestionManager provider) {
    if (index == 0) {
      return provider.buttonColorA;
    } else if (index == 1) {
      return provider.buttonColorB;
    } else if (index == 2) {
      return provider.buttonColorC;
    } else {
      return provider.buttonColorD;
    }
  }

  String _getOptions(int index, QuestionManager provider) {
    if (index == 0) {
      return provider.option1;
    } else if (index == 1) {
      return provider.option2 ?? 'a';
    } else if (index == 2) {
      return provider.option3 ?? 'a';
    } else {
      return provider.option4 ?? 'a';
    }
  }
}
