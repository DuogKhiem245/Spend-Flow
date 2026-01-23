import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';

class VerifyPasscodeSheet extends StatefulWidget {
  final Future<bool> Function(String code) onVerify;

  const VerifyPasscodeSheet({super.key, required this.onVerify});

  @override
  State<VerifyPasscodeSheet> createState() => _VerifyPasscodeSheetState();
}

class _VerifyPasscodeSheetState extends State<VerifyPasscodeSheet> {
  final TextEditingController _controller = TextEditingController();
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text.length == 6) {
        _verify();
      }
    });
  }

  Future<void> _verify() async {
    final success = await widget.onVerify(_controller.text);

    if (success) {
      if (mounted) Navigator.pop(context);
    } else {
      setState(() => _isError = true);
      _controller.clear();
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) setState(() => _isError = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Text(
            l10n.enter_passcode,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          ),

          SizedBox(height: 30.h),

          _buildPinInput(),

          SizedBox(height: 10.h),
          if (_isError)
            Text(
              l10n.incorrect_passcode,
              style: TextStyle(
                color: CupertinoColors.systemRed,
                fontSize: 14.sp,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPinInput() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final text = _controller.text;
        final length = text.length;

        return SizedBox(
          height: 60.h,
          child: Stack(
            children: [
              Positioned.fill(
                child: CupertinoTextField(
                  controller: _controller,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: const TextStyle(color: Colors.transparent),
                  cursorColor: Colors.transparent,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) => {
                    HapticFeedback.lightImpact()
                  },
                ),
              ),
              IgnorePointer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    final isFilled = index < length;
                    final isFocused = index == length;
                    String displayChar = "";
                    bool showDot = false;
                    if (isFilled) {
                      if (index == length - 1) {
                        displayChar = text[index];
                      } else {
                        showDot = true;
                      }
                    }
                    return Container(
                      width: 48.w,
                      height: 56.h,
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                      decoration: BoxDecoration(
                        color: CupertinoTheme.of(context).barBackgroundColor,
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          color: _isError
                              ? CupertinoColors.systemRed
                              : (isFocused
                                    ? CupertinoTheme.of(context).primaryColor
                                    : Colors.grey.withValues(alpha: .3)),
                          width: isFocused || _isError ? 2 : 1,
                        ),
                      ),
                      child: Center(
                        child: isFilled
                            ? (showDot
                                  ? Container(
                                      width: 10.w,
                                      height: 10.w,
                                      decoration: BoxDecoration(
                                        color: CupertinoTheme.of(
                                          context,
                                        ).textTheme.textStyle.color,
                                        shape: BoxShape.circle,
                                      ),
                                    )
                                  : Text(
                                      displayChar,
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: CupertinoTheme.of(
                                          context,
                                        ).textTheme.textStyle.color,
                                      ),
                                    ))
                            : null,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
