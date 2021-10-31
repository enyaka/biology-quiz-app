import 'package:enyaka_biology_quiz/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';

class MyAlertDiolog extends StatelessWidget {
  const MyAlertDiolog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = BlocProvider.of<ThemeCubit>(context);
    final _textColor = theme.isDark ? Colors.white : Colors.grey[800];
    return AlertDialog(
      backgroundColor:
          theme.isDark ? kDarkModeBackrgoundColor : kWhiteModeBackgroundColor,
      title: Text(
        'Emin misiniz?',
        style: TextStyle(color: _textColor),
      ),
      content: Text(
        'Geri çıkmak istediğinize emin misiniz ?',
        style: TextStyle(color: _textColor),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Evet')),
        TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Hayır',
            ))
      ],
    );
  }
}
