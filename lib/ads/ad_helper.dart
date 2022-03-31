import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4271529819148594/6792815157';
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4271529819148594/5497482148';
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
