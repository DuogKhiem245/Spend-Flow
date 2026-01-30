import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';

class NoteWidget extends StatefulWidget {
  final Color? baseColor;
  final TextEditingController? controller;

  const NoteWidget({super.key, this.baseColor, this.controller});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.note,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color?.withValues(alpha: .7),
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            height: 180.h,
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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
            child: CupertinoTextField(
              controller: widget.controller,
              decoration: null,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              cursorColor: widget.baseColor,
              placeholder: l10n.enter_note,
              placeholderStyle: CupertinoTheme.of(context).textTheme.textStyle
                  .copyWith(
                    fontSize: 18.sp,
                    color: widget.baseColor?.withAlpha((0.7 * 255).toInt()),
                  ),
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 18.sp,
                color: widget.baseColor,
              ),
              padding: EdgeInsets.zero,
              scrollPadding: EdgeInsets.only(bottom: 210.h),
            ),
          ),
        ],
      ),
    );
  }
}
