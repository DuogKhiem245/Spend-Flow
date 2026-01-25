import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/config/app_colors.dart';

class OTPInputView extends StatefulWidget {
  final int length;
  final ValueChanged<String> onChanged;

  const OTPInputView({super.key, this.length = 6, required this.onChanged});

  @override
  State<OTPInputView> createState() => _OTPInputViewState();
}

class _OTPInputViewState extends State<OTPInputView> {
  late TextEditingController _controller;
  String _otp = "";

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Hàm xử lý khi user nhập liệu
  void _handleOnChange(String value) {
    setState(() {
      _otp = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: AppColors.borderColor, width: 0.5.w),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildOtpVisuals(context),

          Positioned.fill(
            child: Opacity(
              opacity: 0.0,
              child: CupertinoTextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                maxLength: widget.length,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: _handleOnChange,
                decoration: null,
                showCursor: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpVisuals(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.length, (index) {
        final char = index < _otp.length ? _otp[index] : "-";
        final bool isPlaceholder = index >= _otp.length;

        return Expanded(
          child: Center(
            child: Text(
              char,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 24.sp,
                fontWeight: isPlaceholder ? FontWeight.w400 : FontWeight.bold,
                color: CupertinoColors.label.resolveFrom(context),
              ),
            ),
          ),
        );
      }),
    );
  }
}
