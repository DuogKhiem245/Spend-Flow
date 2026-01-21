import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';

class NameTransactionWidget extends StatefulWidget {
  final TextEditingController nameController;
  final Color? baseColor;
  const NameTransactionWidget({super.key, required this.nameController, this.baseColor});

  @override
  State<NameTransactionWidget> createState() => _NameTransactionWidgetState();
}

class _NameTransactionWidgetState extends State<NameTransactionWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          alignment: Alignment.centerLeft,
          child: Text(
            l10n.name,
            style: TextStyle(
              color: CupertinoTheme.of(context)
            .textTheme
            .textStyle
            .color
            ?.withValues(alpha: .7),
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).barBackgroundColor,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.boxShadow,
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: CupertinoTextField(
            controller: widget.nameController,
            decoration: null,
            cursorColor: widget.baseColor,
            keyboardType: TextInputType.text,
            placeholder: l10n.enter_transaction_name,
            placeholderStyle: TextStyle(
              fontSize: 16.sp,
              color: widget.baseColor?.withAlpha((0.7 * 255).toInt()),
            ),
            style: TextStyle(fontSize: 16.sp, color: widget.baseColor),
          ),
        ),
      ],
    );
  }
}
