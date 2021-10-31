// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:enyaka_biology_quiz/locator.dart';
import 'package:enyaka_biology_quiz/screens/login/view/login_view.dart';
import 'package:enyaka_biology_quiz/screens/login/viewmodel/login_cubit.dart';
import 'package:enyaka_biology_quiz/theme/theme_cubit.dart';

void main() async {
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, state) {
            debugPrint(state.scaffoldBackgroundColor.toString());
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.copyWith(
                textTheme: GoogleFonts.montserratTextTheme(
                    Theme.of(context).textTheme),
              ),
              title: 'YKS Biyoloji',
              home: BlocBuilder<LoginCubit, int>(
                builder: (context, state) {
                  return Login();
                },
              ),
            );
          },
        );
      }),
    );
  }
}
