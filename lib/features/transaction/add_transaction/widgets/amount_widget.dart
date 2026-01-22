import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/utils/currency_formatter_helper.dart';
import 'package:spend_flow/features/transaction/add_transaction/add_transaction_viewmodel.dart';

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
  final AddTransactionViewmodel _viewModel = AddTransactionViewmodel();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        final symbol = _viewModel.currencySymbol;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 6.w),
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
              height: 90.h,
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
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    symbol,
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
                      inputFormatters: [CurrencyInputFormatter()],
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
      },
    );
  }
}
