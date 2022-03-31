import 'package:enyaka_biology_quiz/ads/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LoginInterstitialCubit extends Cubit<bool> {
  late InterstitialAd interstitialAd;
  bool isLoaded = false;
  LoginInterstitialCubit() : super(false) {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          interstitialAd = ad;
          isLoaded = true;
          debugPrint('dsadsadsafdsafdsasa');
        }, onAdFailedToLoad: (error) {
          debugPrint('InterstitialAd Error : ${error.message}');
        }));
  }
}
