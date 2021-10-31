import 'package:enyaka_biology_quiz/screens/login/viewmodel/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../quizpage/view/quizpage.dart';

class SubjectButtons extends StatelessWidget {
  const SubjectButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _loginCubit = BlocProvider.of<LoginCubit>(context);

    return SizedBox(
      width: 60.0.w,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 1.5.h),
            child: Container(
              height: 6.8.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFF512DA8), Color(0xFFE040FB)]),
                borderRadius: BorderRadius.circular(25),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  final type = index == 0 ? 'tyt' : (index == 1 ? 'ayt' : '');
                  debugPrint('Seçilen şık : ' + index.toString());
                  final returnedScore = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuizPage(
                                  type: type,
                                )),
                      ) ??
                      0;
                  _loginCubit.addToScore(returnedScore);
                },
                child: Text(
                  index == 0 ? 'TYT' : (index == 1 ? 'AYT' : 'Karışık Sorular'),
                  style: TextStyle(fontSize: 15.sp),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onSurface: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
