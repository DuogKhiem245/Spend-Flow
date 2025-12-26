import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/features/voice_input/voice_input_viewmodel.dart';

class VoiceInputView extends StatefulWidget {
  const VoiceInputView({super.key});

  @override
  State<VoiceInputView> createState() => _VoiceInputViewState();
}

class _VoiceInputViewState extends State<VoiceInputView> {
  final VoiceInputViewModel _viewModel = VoiceInputViewModel();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _viewModel.initSpeech().then((_) {
        if (!mounted) return;
        final currentLocale = Localizations.localeOf(context);
        final localeId = currentLocale.toString();

        _viewModel.startListening(localeId);
      });
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final primaryColor = AppColors.primaryColor;

    final currentLocale = Localizations.localeOf(context);
    final localeId = currentLocale.toString();

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            border: null,
            padding: EdgeInsetsDirectional.only(bottom: 10.h),
            leading: CupertinoNavigationBarBackButton(
              color: CupertinoTheme.of(context).primaryColor,
              onPressed: () => Navigator.pop(context),
            ),
            middle: Text(
              l10n.add_via_voice,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: CupertinoTheme.of(context).textTheme.textStyle.color,
              ),
            ),
          ),
          child: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    SizedBox(
                      height: 100.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(_viewModel.heights.length, (
                          index,
                        ) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            width: 8.w,
                            height: _viewModel.heights[index],
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(50.r),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withValues(alpha: .4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    Text(
                      _viewModel.isListening
                          ? l10n.listening
                          : (l10n.tap_to_listen),
                      style: TextStyle(
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        _viewModel.lastWords.isEmpty
                            ? l10n.voice_example
                            : _viewModel.lastWords,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _viewModel.lastWords.isEmpty
                              ? CupertinoColors.systemGrey
                              : CupertinoTheme.of(
                                  context,
                                ).textTheme.textStyle.color,
                          fontSize: 18.sp,
                          fontWeight: _viewModel.lastWords.isEmpty
                              ? FontWeight.normal
                              : FontWeight.w500,
                        ),
                      ),
                    ),

                    const Spacer(flex: 3),

                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120.w,
                          height: 120.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                primaryColor.withValues(alpha: .2),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 90.w,
                          height: 90.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primaryColor.withValues(alpha: .3),
                              width: 1,
                            ),
                            color: primaryColor.withValues(alpha: .1),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              _viewModel.toggleListening(context, localeId),
                          child: Container(
                            width: 70.w,
                            height: 70.w,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withValues(alpha: .4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              _viewModel.isListening
                                  ? CupertinoIcons
                                        .stop_fill 
                                  : CupertinoIcons.mic_fill,
                              color: Colors.white,
                              size: 32.sp,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    if (_viewModel.isListening)
                      Text(
                        l10n.tap_to_stop,
                        style: TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 14.sp,
                        ),
                      )
                    else
                      SizedBox(height: 18.h),

                    SizedBox(height: 50.h),
                  ],
                ),
              ),

              if (_viewModel.isProcessing)
                Container(
                  color: Colors.black.withValues(alpha: 0.7),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LoadingAnimationWidget.staggeredDotsWave(
                          color: AppColors.primaryColor,
                          size: 30.w,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Đang phân tích giọng nói...",
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
}
