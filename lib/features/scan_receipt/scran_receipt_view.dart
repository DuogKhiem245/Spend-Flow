import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/features/scan_receipt/scan_recept_viewmodel.dart';

class ScanReceiptView extends StatefulWidget {
  const ScanReceiptView({super.key});

  @override
  State<ScanReceiptView> createState() => _ScanReceiptViewState();
}

class _ScanReceiptViewState extends State<ScanReceiptView>
    with WidgetsBindingObserver {
  final ScanReceiptViewModel _viewModel = ScanReceiptViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _viewModel.initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _viewModel.handleLifecycleChange(state);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            border: null,
            padding: EdgeInsetsDirectional.only(bottom: 10.h),
            backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
            leading: CupertinoNavigationBarBackButton(
              color: AppColors.primaryColor,
              onPressed: () => Navigator.pop(context),
            ),
            middle: Text(
              l10n.scan_receipt,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(child: _buildCameraPreview()),

              Column(
                children: [
                  const Spacer(),

                  _buildScanFrame(),

                  SizedBox(height: 20.h),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: .6),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Text(
                      l10n.align_receipt,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const Spacer(),

                  _buildBottomBar(),
                ],
              ),

              if (_viewModel.isScanning)
                Container(
                  color: Colors.black.withValues(alpha: 0.7),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 50.w,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          l10n.invoice_analysis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCameraPreview() {
    return FutureBuilder<void>(
      future: _viewModel.initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            _viewModel.controller != null &&
            _viewModel.controller!.value.isInitialized) {
          return CameraPreview(_viewModel.controller!);
        } else {
          return Container(color: Colors.black);
        }
      },
    );
  }

  Widget _buildScanFrame() {
    return Container(
      width: 300.w,
      height: 450.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor, width: 3.w),
        borderRadius: BorderRadius.circular(30.r),
        color: Colors.transparent,
      ),
      child: FutureBuilder(
        future: _viewModel.initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: CupertinoTheme.of(context).primaryColor,
                size: 30.w,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 50.h, top: 20.h),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCircleButton(
            icon: _viewModel.isFlashOn
                ? CupertinoIcons.bolt_fill
                : CupertinoIcons.bolt_slash_fill,
            iconColor: _viewModel.isFlashOn ? Colors.yellow : Colors.white,
            onTap: () => _viewModel.toggleFlash(),
          ),

          GestureDetector(
            onTap: () {
              _viewModel.takePicture(context);
            },
            child: Container(
              width: 72.w,
              height: 72.w,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryColor, width: 4.w),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: _viewModel.isTakingPicture
                    ? const CupertinoActivityIndicator(color: Colors.white)
                    : null,
              ),
            ),
          ),

          _buildCircleButton(
            icon: CupertinoIcons.photo,
            backgroundColor: const Color(0xFF2C2C2E),
            onTap: () {
              _viewModel.pickFromGallery(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color backgroundColor = const Color(0xFF1C1C1E),
    Color iconColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 20.sp),
      ),
    );
  }
}
