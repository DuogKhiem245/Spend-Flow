import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  final String adUnitId;
  const BannerAdWidget({super.key, required this.adUnitId});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

// THÊM WidgetsBindingObserver VÀO ĐÂY ĐỂ LẮNG NGHE VÒNG ĐỜI APP
class _BannerAdWidgetState extends State<BannerAdWidget>
    with WidgetsBindingObserver {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); 
    _loadAd();
  }

  void _loadAd() {
    _bannerAd?.dispose();

    setState(() {
      _isLoaded = false;
    });

    _bannerAd = BannerAd(
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() => _isLoaded = true);
          }
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd lỗi tải: ${error.message}');
          ad.dispose();
          _bannerAd = null; 
          if (mounted) {
            setState(() => _isLoaded = false);
          }
        },
      ),
    )..load();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!_isLoaded) {
        debugPrint('Tự động tải lại BannerAd do đang trống...');
        _loadAd();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); 
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
