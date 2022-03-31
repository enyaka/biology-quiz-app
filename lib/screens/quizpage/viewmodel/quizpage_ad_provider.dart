import 'package:enyaka_biology_quiz/ads/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class QuizPageAdProvider extends ChangeNotifier {
  late BannerAd _ad;
  bool _isLoaded = false;

  QuizPageAdProvider() {
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(onAdLoaded: (_) {
        _isLoaded = true;
        notifyListeners();
      }, onAdFailedToLoad: (_, error) {
        debugPrint('Reklam yüklemede hata oluştu : ${error.message}');
      }),
    )..load();
  }
  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  Widget checkForAd() {
    if (_isLoaded == true) {
      return Container(
        child: AdWidget(ad: _ad),
        width: _ad.size.width.toDouble(),
        height: _ad.size.height.toDouble(),
        alignment: Alignment.bottomCenter,
      );
    } else {
      return const SizedBox();
    }
  }
}
