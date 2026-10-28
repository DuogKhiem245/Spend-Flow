import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:spend_flow/core/services/ads_service.dart';

void main() {
  group('AdError Classification Tests', () {
    test('Classifies Android No Fill (code 3) correctly', () {
      final error = LoadAdError(
        3,
        'com.google.android.gms.ads',
        'No ad config.',
        null,
      );
      final reason = AdsService.classifyAdError(error);
      expect(reason, AdFailureReason.noFill);
    });

    test('Classifies "No ads to show" message correctly', () {
      final error = LoadAdError(
        1,
        'com.google.android.gms.ads',
        'Request Error: No ads to show.',
        null,
      );
      final reason = AdsService.classifyAdError(error);
      expect(reason, AdFailureReason.noFill);
    });

    test('Classifies iOS No Fill (code 1 in google domain) correctly', () {
      final error = LoadAdError(
        1,
        'com.google.admob',
        'No fill',
        null,
      );
      final reason = AdsService.classifyAdError(error);
      expect(reason, AdFailureReason.noFill);
    });

    test('Classifies mediation no fill (code 9) correctly', () {
      final error = LoadAdError(
        9,
        'com.google.android.gms.ads',
        'Mediation no fill.',
        null,
      );
      final reason = AdsService.classifyAdError(error);
      expect(reason, AdFailureReason.noFill);
    });

    test('Classifies Network Error (code 2) correctly', () {
      final error = LoadAdError(
        2,
        'com.google.android.gms.ads',
        'Network error.',
        null,
      );
      final reason = AdsService.classifyAdError(error);
      expect(reason, AdFailureReason.networkError);
    });

    test('Classifies connection error by message correctly', () {
      final error = LoadAdError(
        0,
        'custom.domain',
        'Internet connection offline',
        null,
      );
      final reason = AdsService.classifyAdError(error);
      expect(reason, AdFailureReason.networkError);
    });

    test('Classifies Timeout correctly', () {
      final error = LoadAdError(
        5,
        'com.google.admob',
        'The request timed out.',
        null,
      );
      final reason = AdsService.classifyAdError(error);
      expect(reason, AdFailureReason.timeout);
    });

    test('Classifies internal/other errors as loadFailed', () {
      final error = LoadAdError(
        0,
        'com.google.android.gms.ads',
        'Internal error.',
        null,
      );
      final reason = AdsService.classifyAdError(error);
      expect(reason, AdFailureReason.loadFailed);
    });
  });

  group('AdsService Rewarded Ads State Tests', () {
    test('Initial rewarded ads state is not loaded and not loading', () {
      final adsService = AdsService();
      expect(adsService.isRewardedAdLoaded(RewardedAdType.scanReceipt), false);
      expect(adsService.isRewardedAdLoading(RewardedAdType.scanReceipt), false);
    });
  });
}

