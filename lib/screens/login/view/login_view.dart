import 'package:enyaka_biology_quiz/screens/login/viewmodel/login_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/theme_cubit.dart';
import 'widgets/clipper.dart';
import 'widgets/subject_buttons.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeCubit = BlocProvider.of<ThemeCubit>(context);
    final _loginCubit = BlocProvider.of<LoginCubit>(context);
    const _totalScoreImagePath = 'assets/images/toplam_star.png';
    return Scaffold(
      body: Column(
        children: [
          const MyClipPath(),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(top: 8.5.h),
            child: const SubjectButtons(),
          )),
          myBottomLayer(_themeCubit, _loginCubit, _totalScoreImagePath),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

Padding myBottomLayer(
        ThemeCubit themeCubit, LoginCubit loginCubit, String path) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          myTotalScore(loginCubit, themeCubit, path),
          myDarkModeSwitch(themeCubit),
        ],
      ),
    );
Row myTotalScore(LoginCubit loginCubit, ThemeCubit theme, String path) => Row(
      children: [
        Image(
          image: AssetImage(path),
          height: 3.0.h,
          width: 7.0.w,
          fit: BoxFit.fill,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          'Toplam Skor : ' + loginCubit.totalScore.toString(),
          style: TextStyle(
              fontSize: 15.0.sp,
              fontWeight: FontWeight.bold,
              color: theme.isDark ? Colors.white : Colors.grey[800]),
        ),
      ],
    );
Row myDarkModeSwitch(ThemeCubit themeCubit) => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.light_mode_rounded,
          color: themeCubit.isDark ? Colors.grey[700] : Colors.amber,
        ),
        CupertinoSwitch(
            trackColor: Colors.amber,
            activeColor: Colors.grey.shade500,
            value: themeCubit.isDark,
            onChanged: (newMode) {
              debugPrint(newMode.toString());
              themeCubit.changeMode(newMode);
            }),
        Icon(
          Icons.dark_mode_rounded,
          color: themeCubit.isDark ? Colors.white : Colors.black,
        ),
      ],
    );
