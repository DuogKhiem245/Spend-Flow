import 'dart:io';

class AdConfig {
  // Trạng thái kiểm thử:
  // - true: Sử dụng các ID quảng cáo Test của Google (an toàn khi phát triển)
  // - false: Sử dụng các ID quảng cáo Production thực tế để hiển thị quảng cáo thật và kiếm doanh thu
  static const bool isTestMode = true;

  // ==========================================
  // 1. ID QUẢNG CÁO THỬ NGHIỆM (Test Ad Unit IDs từ Google)
  // ==========================================

  // Quảng cáo Banner
  static const String testAndroidBanner =
      'ca-app-pub-3940256099942544/6300978111';
  static const String testIosBanner = 'ca-app-pub-3940256099942544/2934735716';

  // Quảng cáo Xen kẽ toàn màn hình
  static const String testAndroidInterstitial =
      'ca-app-pub-3940256099942544/1033173712';
  static const String testIosInterstitial =
      'ca-app-pub-3940256099942544/4411468910';

  // Quảng cáo Video nhận thưởng
  static const String testAndroidRewarded =
      'ca-app-pub-3940256099942544/5224354917';
  static const String testIosRewarded =
      'ca-app-pub-3940256099942544/1712485313';

  // ==========================================
  // 2. ID QUẢNG CÁO THỰC TẾ (Production Ad Unit IDs)
  // ==========================================

  // Quảng cáo Banner
  static const String prodAndroidBanner =
      'ca-app-pub-7163558183405140/9319825503';
  static const String prodIosBanner = 'ca-app-pub-7163558183405140/2878127543';

  // Quảng cáo Xen kẽ toàn màn hình
  static const String prodAndroidInterstitial =
      'ca-app-pub-7163558183405140/5005597435';
  static const String prodIosInterstitial =
      'ca-app-pub-7163558183405140/7631760770';

  // Quảng cáo Video nhận thưởng - Tính năng Quét hóa đơn
  static const String prodAndroidRewardedScanReceipt =
      'ca-app-pub-7163558183405140/7917711557';
  static const String prodIosRewardedScanReceipt =
      'ca-app-pub-7163558183405140/2945988846';

  // Quảng cáo Video nhận thưởng - Tính năng Nhập liệu bằng giọng nói
  static const String prodAndroidRewardedVoiceInput =
      'ca-app-pub-7163558183405140/7917711557';
  static const String prodIosRewardedVoiceInput =
      'ca-app-pub-7163558183405140/29459888464';

  // Quảng cáo Video nhận thưởng - Tính năng Đồng bộ dữ liệu
  static const String prodAndroidRewardedSyncData =
      'ca-app-pub-7163558183405140/7917711557';
  static const String prodIosRewardedSyncData =
      'ca-app-pub-7163558183405140/2945988846';

  // ==========================================
  // 3. ID ỨNG DỤNG ADMOB (Native App IDs)
  // Lưu ý: Các ID này cấu hình trực tiếp trong android/app/src/main/AndroidManifest.xml và ios/Runner/Info.plist
  // ==========================================
  static const String androidAppId = 'ca-app-pub-7163558183405140~6783939346';
  static const String iosAppId = 'ca-app-pub-7163558183405140~6936138115';

  /// Lấy ID quảng cáo Xen kẽ dựa trên nền tảng và chế độ (Test/Production)
  static String get interstitialAdUnitId {
    if (isTestMode) {
      return Platform.isAndroid ? testAndroidInterstitial : testIosInterstitial;
    }
    return Platform.isAndroid ? prodAndroidInterstitial : prodIosInterstitial;
  }

  /// Lấy ID quảng cáo Banner dựa trên nền tảng và chế độ (Test/Production)
  static String get bannerAdUnitId {
    if (isTestMode) {
      return Platform.isAndroid ? testAndroidBanner : testIosBanner;
    }
    return Platform.isAndroid ? prodAndroidBanner : prodIosBanner;
  }

  /// Lấy ID quảng cáo Video nhận thưởng dựa trên nền tảng, chế độ và loại hành động
  static String getRewardedAdUnitId(String typeName) {
    if (isTestMode) {
      return Platform.isAndroid ? testAndroidRewarded : testIosRewarded;
    }
    switch (typeName) {
      case 'scanReceipt':
        return Platform.isAndroid
            ? prodAndroidRewardedScanReceipt
            : prodIosRewardedScanReceipt;
      case 'voiceInput':
        return Platform.isAndroid
            ? prodAndroidRewardedVoiceInput
            : prodIosRewardedVoiceInput;
      case 'syncData':
        return Platform.isAndroid
            ? prodAndroidRewardedSyncData
            : prodIosRewardedSyncData;
      default:
        return Platform.isAndroid ? testAndroidRewarded : testIosRewarded;
    }
  }
}
