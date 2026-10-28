import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/config/ad_config.dart';

enum RewardedAdType { scanReceipt, voiceInput, syncData }

enum AdFailureReason {
  noFill, // Mã 3 (Android) / 1 (iOS) hoặc thông điệp 'no ad to show'
  networkError, // Mã 2 hoặc lỗi mất kết nối mạng
  timeout, // Chờ tải quảng cáo quá thời gian quy định
  notReady, // Quảng cáo đang được tải, chưa sẵn sàng
  failedToShow, // Lỗi hiển thị toàn màn hình
  loadFailed, // Các lỗi nội bộ khác từ SDK AdMob
}

class AdFailure {
  final AdFailureReason reason;
  final String? message;
  final int? code;

  const AdFailure({
    required this.reason,
    this.message,
    this.code,
  });

  @override
  String toString() => 'AdFailure(reason: $reason, code: $code, message: $message)';
}

class AdsService {
  static final AdsService _instance = AdsService._internal();

  factory AdsService() {
    return _instance;
  }

  AdsService._internal();

  InterstitialAd? _interstitialAd;

  final Map<RewardedAdType, RewardedAd?> _rewardedAds = {};
  final Map<RewardedAdType, bool> _isRewardedAdLoading = {};
  final Map<RewardedAdType, AdFailure?> _lastRewardedErrors = {};
  final Map<RewardedAdType, List<Completer<bool>>> _adLoadCompleters = {};

  static const String _adCounterKey = 'interstitial_ad_counter';

  String get interstitialAdUnitId => AdConfig.interstitialAdUnitId;

  String get bannerAdUnitId => AdConfig.bannerAdUnitId;

  /// Phân loại lỗi AdMob dựa trên mã lỗi, domain và thông điệp trả về
  static AdFailureReason classifyAdError(AdError error) {
    final msg = error.message.toLowerCase();

    // 1. Kiểm tra lỗi không có quảng cáo (No Fill / No ads to show)
    // Android: ERROR_CODE_NO_FILL = 3, ERROR_CODE_MEDIATION_NO_FILL = 9
    // iOS: GADErrorNoFill = 1 trong domain com.google.admob
    if (error.code == 3 ||
        error.code == 9 ||
        (error.code == 1 && error.domain.toLowerCase().contains('google')) ||
        msg.contains('no ad to show') ||
        msg.contains('no fill') ||
        msg.contains('no ad config') ||
        msg.contains('inventory')) {
      return AdFailureReason.noFill;
    }

    // 2. Kiểm tra lỗi kết nối mạng (Network Error)
    // Android: ERROR_CODE_NETWORK_ERROR = 2
    // iOS: GADErrorNetworkError = 2
    if (error.code == 2 ||
        msg.contains('network') ||
        msg.contains('connection') ||
        msg.contains('offline')) {
      return AdFailureReason.networkError;
    }

    // 3. Kiểm tra timeout
    // iOS: GADErrorTimeout = 5
    if (error.code == 5 || msg.contains('timeout')) {
      return AdFailureReason.timeout;
    }

    // 4. Mặc định: Lỗi tải quảng cáo nội bộ / không xác định
    return AdFailureReason.loadFailed;
  }

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

  bool isRewardedAdLoaded(RewardedAdType type) => _rewardedAds[type] != null;

  bool isRewardedAdLoading(RewardedAdType type) => _isRewardedAdLoading[type] == true;

  AdFailure? getLastRewardedError(RewardedAdType type) => _lastRewardedErrors[type];

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
          _lastRewardedErrors[type] = null;
          _completeLoadWaiters(type, true);
        },
        onAdFailedToLoad: (error) {
          _rewardedAds[type] = null;
          _isRewardedAdLoading[type] = false;
          final failure = AdFailure(
            reason: classifyAdError(error),
            message: error.message,
            code: error.code,
          );
          _lastRewardedErrors[type] = failure;
          debugPrint("Lỗi load quảng cáo $type (${error.code}): ${error.message} -> ${failure.reason}");
          _completeLoadWaiters(type, false);
        },
      ),
    );
  }

  void _completeLoadWaiters(RewardedAdType type, bool success) {
    final waiters = _adLoadCompleters[type];
    if (waiters != null && waiters.isNotEmpty) {
      for (final completer in List<Completer<bool>>.from(waiters)) {
        if (!completer.isCompleted) {
          completer.complete(success);
        }
      }
      _adLoadCompleters[type] = [];
    }
  }

  /// Chờ quảng cáo nạp xong với thời gian timeout (mặc định 6 giây)
  Future<bool> waitForRewardedAd(
    RewardedAdType type, {
    Duration timeout = const Duration(seconds: 6),
  }) async {
    if (_rewardedAds[type] != null) {
      return true;
    }

    if (_isRewardedAdLoading[type] != true) {
      loadRewardedAd(type);
    }

    final completer = Completer<bool>();
    _adLoadCompleters.putIfAbsent(type, () => []).add(completer);

    try {
      return await completer.future.timeout(
        timeout,
        onTimeout: () {
          _adLoadCompleters[type]?.remove(completer);
          _lastRewardedErrors[type] = const AdFailure(
            reason: AdFailureReason.timeout,
            message: 'Timed out waiting for ad to load',
          );
          return false;
        },
      );
    } catch (_) {
      return false;
    }
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
          loadInterstitialAd();
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
    required VoidCallback onRewardEarned,
    required void Function(AdFailure failure) onAdFailed,
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
          final failure = AdFailure(
            reason: AdFailureReason.failedToShow,
            message: error.message,
            code: error.code,
          );
          debugPrint("Lỗi hiển thị quảng cáo $type: ${error.message}");
          onAdFailed(failure);
        },
      );

      ad.show(
        onUserEarnedReward: (adInfo, reward) {
          onRewardEarned();
        },
      );
      _rewardedAds[type] = null;
    } else {
      final failure = _lastRewardedErrors[type] ??
          (_isRewardedAdLoading[type] == true
              ? const AdFailure(reason: AdFailureReason.notReady)
              : const AdFailure(reason: AdFailureReason.loadFailed));
      loadRewardedAd(type);
      onAdFailed(failure);
    }
  }
}
