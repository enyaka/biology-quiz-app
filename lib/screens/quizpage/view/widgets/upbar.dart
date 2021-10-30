import 'package:enyaka_biology_quiz/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class UpBar extends StatelessWidget {
  const UpBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = BlocProvider.of<ThemeCubit>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
              child: Text('Skor : ' /* + _question.score.toString()*/,
                  style: TextStyle(
                      fontSize: 15.0.sp,
                      color: _theme.isDark ? Colors.white : Colors.black)),
            ),
          ],
        ),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.transparent,
          onTap: () {},
          child: Row(
            children: [
              Icon(
                Icons.bug_report,
                color: Colors.yellow.shade700,
                size: 4.0.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.0.w),
                child: Text(
                  'Hata Bildir',
                  style: TextStyle(
                      fontSize: 15.0.sp,
                      color: _theme.isDark ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
