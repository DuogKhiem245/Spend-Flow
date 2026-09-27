import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  final String adUnitId;
  final ValueChanged<bool>? onAdStatusChanged;

  const BannerAdWidget({
    super.key,
    required this.adUnitId,
    this.onAdStatusChanged,
  });

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget>
    with WidgetsBindingObserver {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  Timer? _retryTimer;

  bool get isAdAvailable => _bannerAd != null && _isLoaded;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadAd();
  }

  void _loadAd() {
    _retryTimer?.cancel();
    _bannerAd?.dispose();

    setState(() {
      _isLoaded = false;
    });
    widget.onAdStatusChanged?.call(false);

    _bannerAd = BannerAd(
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            _retryTimer?.cancel();
            _retryTimer = null;
            setState(() => _isLoaded = true);
            widget.onAdStatusChanged?.call(true);
          }
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint(
            'BannerAd không tải được (${error.code}): ${error.message}',
          );
          ad.dispose();
          _bannerAd = null;
          if (mounted) {
            setState(() => _isLoaded = false);
            widget.onAdStatusChanged?.call(false);
            _retryTimer = Timer(const Duration(seconds: 30), () {
              _retryTimer = null;
              if (mounted && !_isLoaded) {
                _loadAd();
              }
            });
          }
        },
      ),
    )..load();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!_isLoaded && _retryTimer == null) {
        debugPrint('Tự động tải lại BannerAd do đang trống...');
        _loadAd();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _retryTimer?.cancel();
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd != null && _isLoaded) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: ClipRRect(
          borderRadius: Platform.isIOS
              ? BorderRadius.circular(30.r)
              : BorderRadius.zero,
          child: Container(
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            alignment: Alignment.center,
            child: AdWidget(ad: _bannerAd!),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
