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

    return Scaffold(
      body: Column(
        children: [
          const MyClipPath(),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(top: 8.5.h),
            child: const SubjectButtons(),
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                myTotalScore(),
                myDarkModeSwitch(_themeCubit),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

Row myTotalScore() => Row(
      children: [
        Image(
          image: const AssetImage('assets/images/toplam_star.png'),
          height: 3.0.h,
          width: 7.0.w,
          fit: BoxFit.fill,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          'Toplam Skor : ',
          style: TextStyle(fontSize: 15.0.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
Row myDarkModeSwitch(ThemeCubit themeCubit) => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.light_mode_rounded,
          color: themeCubit.isDark ? Colors.black : Colors.amber,
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
