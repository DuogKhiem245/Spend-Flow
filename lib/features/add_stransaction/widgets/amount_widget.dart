import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/utils/leading_zero_formatter_helper.dart';

class AmountWidget extends StatefulWidget {
  final TextEditingController amountController;
  final Color? baseColor;
  final ValueChanged<String>? onChanged;

  const AmountWidget({
    super.key,
    required this.amountController,
    this.baseColor,
    this.onChanged,
  });

  @override
  State<AmountWidget> createState() => _AmountWidgetState();
}

class _AmountWidgetState extends State<AmountWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            l10n.amount,
            style: TextStyle(
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color?.withValues(alpha: .7),
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          height: 100.h,
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).barBackgroundColor,
            borderRadius: BorderRadius.circular(30.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$',
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w700,
                  color: widget.amountController.text.isEmpty
                      ? widget.baseColor?.withValues(alpha: .7)
                      : widget.baseColor,
                ),
              ),
              Expanded(
                child: CupertinoTextField(
                  controller: widget.amountController,
                  onChanged: (value) {
                    setState(() {});
                    if (widget.onChanged != null) {
                      widget.onChanged!(value);
                    }
                  },
                  decoration: null,
                  textAlign: TextAlign.end,
                  cursorColor: CupertinoColors.transparent,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\,?\d{0,2}'),
                    ),
                    LeadingZeroFormatter(),
                  ],
                  placeholder: '0,00',
                  placeholderStyle: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w700,
                    color: widget.baseColor?.withAlpha((0.7 * 255).toInt()),
                  ),
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w700,
                    color: widget.baseColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
