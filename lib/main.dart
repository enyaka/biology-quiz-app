// ignore_for_file: prefer_const_constructors
import 'package:enyaka_biology_quiz/screens/login/viewmodel/login_ad_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.bottom]);
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
          //Koyu ve açık temanın ayarlandığı Cubit
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          //Toplam skorun ve ileride gelebilecek olan özelliklerin toplandığı cubit
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          //Geçiş reklamını yöneten cubit
          create: (context) => LoginInterstitialCubit(),
        )
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
                home: BlocListener<LoginInterstitialCubit, bool>(
                  listener: (context, state) {
                    if (state) {
                      //Geçiş reklamı hazır olduğu zaman reklam gösterir.
                      final ad = context.read<LoginInterstitialCubit>();
                      ad.interstitialAd.show();
                    }
                  },
                  child: BlocBuilder<LoginCubit, int>(
                    builder: (context, state) {
                      return Login();
                    },
                  ),
                )

                /*BlocBuilder<LoginCubit, int>(
                builder: (context, state) {
                  return Login();
                },
              ),*/
                );
          },
        );
      }),
    );
  }
}
