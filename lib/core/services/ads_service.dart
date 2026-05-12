import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RewardedAdType { scanReceipt, voiceInput, syncData, importExportData }

class AdsService {
  InterstitialAd? _interstitialAd;

  final Map<RewardedAdType, RewardedAd?> _rewardedAds = {};

  static const String _adCounterKey = 'interstitial_ad_counter';
  static const bool isTestMode = true;

  final String interstitialAdUnitId = isTestMode
      ? (Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/1033173712'
            : 'ca-app-pub-3940256099942544/4411468910')
      : (Platform.isAndroid
            ? 'ca-app-pub-5260847065768800/4944164516'
            : 'ca-app-pub-5260847065768800/1989258729');

  String getRewardedAdUnitId(RewardedAdType type) {
    if (isTestMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5224354917'
          : 'ca-app-pub-3940256099942544/1712485313';
    } else {
      switch (type) {
        case RewardedAdType.scanReceipt:
          return Platform.isAndroid
              ? 'ca-app-pub-5260847065768800/7566458429'
              : 'ca-app-pub-5260847065768800/2697275128';
        case RewardedAdType.voiceInput:
          return Platform.isAndroid
              ? 'ca-app-pub-5260847065768800/3039450667'
              : 'ca-app-pub-5260847065768800/7841790594';
        case RewardedAdType.syncData:
          return Platform.isAndroid
              ? 'ca-app-pub-5260847065768800/4459124955'
              : 'ca-app-pub-5260847065768800/2589463911';
        case RewardedAdType.importExportData:
          return Platform.isAndroid
              ? 'ca-app-pub-5260847065768800/8100205653'
              : 'ca-app-pub-5260847065768800/1084810551';
      }
    }
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
    debugPrint("Loading rewarded ad for type: $type");
    RewardedAd.load(
      adUnitId: getRewardedAdUnitId(type),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAds[type] = ad;
        },
        onAdFailedToLoad: (error) {
          _rewardedAds[type] = null;
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
