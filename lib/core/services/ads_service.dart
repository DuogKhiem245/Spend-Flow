import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/config/ad_config.dart';

enum RewardedAdType { scanReceipt, voiceInput, syncData }

class AdsService {
  static final AdsService _instance = AdsService._internal();

  factory AdsService() {
    return _instance;
  }

  AdsService._internal();

  InterstitialAd? _interstitialAd;

  final Map<RewardedAdType, RewardedAd?> _rewardedAds = {};
  final Map<RewardedAdType, bool> _isRewardedAdLoading = {};

  static const String _adCounterKey = 'interstitial_ad_counter';

  String get interstitialAdUnitId => AdConfig.interstitialAdUnitId;

  String get bannerAdUnitId => AdConfig.bannerAdUnitId;

  Future<bool> checkBannerAdAvailable({String? customAdUnitId}) async {
    final completer = Completer<bool>();

    final bannerAd = BannerAd(
      adUnitId: customAdUnitId ?? bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          ad.dispose();
          if (!completer.isCompleted) {
            completer.complete(true);
          }
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd lỗi tải chi tiết: Domain=${error.domain}, Code=${error.code}, Message=${error.message}');
          ad.dispose();
          if (!completer.isCompleted) {
            completer.complete(false);
          }
        },
      ),
    );

    bannerAd.load();
    return completer.future;
  }

  String getRewardedAdUnitId(RewardedAdType type) {
    return AdConfig.getRewardedAdUnitId(type.name);
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (error) => _interstitialAd = null,
      ),
    );
  }

  void loadRewardedAd(RewardedAdType type) {
    if (_rewardedAds[type] != null || _isRewardedAdLoading[type] == true) {
      return;
    }

    _isRewardedAdLoading[type] = true;

    RewardedAd.load(
      adUnitId: getRewardedAdUnitId(type),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAds[type] = ad;
          _isRewardedAdLoading[type] = false;
        },
        onAdFailedToLoad: (error) {
          _rewardedAds[type] = null;
          _isRewardedAdLoading[type] = false;
          debugPrint("Lỗi load quảng cáo $type: ${error.message}");
        },
      ),
    );
  }

  void loadAllRewardedAds() {
    for (var type in RewardedAdType.values) {
      loadRewardedAd(type);
    }
  }

  Future<void> showInterstitialWithFrequency({
    required bool isPremium,
    required Function onAdClosed,
  }) async {
    if (isPremium) {
      onAdClosed();
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    int currentCount = prefs.getInt(_adCounterKey) ?? 0;
    currentCount++;

    if (currentCount >= 5 && _interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) async {
          ad.dispose();
          await prefs.setInt(_adCounterKey, 0);
          loadInterstitialAd();
          onAdClosed();
        },
        onAdFailedToShowFullScreenContent: (ad, error) async {
          ad.dispose();
          onAdClosed();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    } else {
      await prefs.setInt(_adCounterKey, currentCount);
      onAdClosed();
    }
  }

  void showRewardedAd({
    required RewardedAdType type,
    required Function onRewardEarned,
    required Function onAdFailed,
  }) {
    final ad = _rewardedAds[type];

    if (ad != null) {
      ad.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (dismissedAd) {
          dismissedAd.dispose();
          loadRewardedAd(type);
        },
        onAdFailedToShowFullScreenContent: (failedAd, error) {
          failedAd.dispose();
          loadRewardedAd(type);
          onAdFailed();
          debugPrint("Lỗi hiển thị quảng cáo $type: ${error.message}");
        },
      );

      ad.show(
        onUserEarnedReward: (adInfo, reward) {
          onRewardEarned();
        },
      );
      _rewardedAds[type] = null;
    } else {
      loadRewardedAd(type);
      onAdFailed();
    }
  }
}
