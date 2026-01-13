import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/config/app_icons.dart';
import 'package:spend_flow/core/widgets/verify_passcode/verify_passcode_sheet.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/features/home/home_viewmodel.dart';
import 'package:spend_flow/features/transaction/view_transaction/transaction_detail_view.dart';

class RecentTransaction extends StatefulWidget {
  final List<TransactionModel> transactions;

  const RecentTransaction({super.key, required this.transactions});

  @override
  State<RecentTransaction> createState() => _RecentTransactionState();
}

class _RecentTransactionState extends State<RecentTransaction> {
  final HomeViewModel _viewModel = HomeViewModel();

  Future<void> _handleUnlock() async {
    bool success = false;

    if (_viewModel.isFaceIdAvailable) {
      success = await _viewModel.authenticateBiometric();
    }

    if (!success && mounted && _viewModel.isLocked) {
      _showUnlockModal(context);
    }
  }

  void _showUnlockModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VerifyPasscodeSheet(
        onVerify: (code) => _viewModel.verifyPasscode(code),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _viewModel.initData();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final symbol = _viewModel.currencySymbol;

    if (widget.transactions.isEmpty) {
      return const SizedBox();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 20.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.recent_transactions,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              _viewModel.hasSecurity ?
              ListenableBuilder(
                listenable: _viewModel,
                builder: (context, _) {
                  return Icon(
                    _viewModel.isLocked
                        ? CupertinoIcons.lock_fill
                        : CupertinoIcons.lock_open_fill,
                    size: 18.sp,
                    color: CupertinoColors.systemGrey,
                  );
                },
              ) : SizedBox.shrink(),
            ],
          ),
          SizedBox(height: 20.h),

          ListenableBuilder(
            listenable: _viewModel,
            builder: (context, child) {
              return Stack(
                children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: _viewModel.isLocked ? 5.0 : 0.0,
                      sigmaY: _viewModel.isLocked ? 5.0 : 0.0,
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.transactions.length,
                      itemBuilder: (context, index) {
                        final item = widget.transactions[index];
                        return _buildTransactionItem(item, context, symbol);
                      },
                    ),
                  ),

                  if (_viewModel.isLocked)
                    Positioned.fill(
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: CupertinoButton(
                          onPressed: _handleUnlock,
                          color: CupertinoTheme.of(
                            context,
                          ).barBackgroundColor.withValues(alpha: .8),
                          borderRadius: BorderRadius.circular(50.r),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(CupertinoIcons.eye_slash_fill, size: 20.sp),
                              SizedBox(width: 8.w),
                              Text(
                                "Chạm để hiện",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(TransactionModel item, BuildContext context, String symbol) {
    final isExpense = item.isIncome == false;
    final File? imageFile = _viewModel.getRealImageFile(item.category.iconKey);
    final color = isExpense ? AppColors.errorColor : AppColors.secondaryColor;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => TransactionDetailView(transaction: item),
          ),
        ),
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: item.category.color.withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: imageFile != null 
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: Image.file(
                            imageFile, 
                            width: 24.w,
                            height: 24.w,
                            fit: BoxFit
                                .cover, 
                          ),
                        )
                      : Icon(
                          AppIcons.getIcon(item.category.iconKey),
                          size: 24.w,
                          color: item.category.color,
                        ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item.category.name,
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 14.sp,
                            color: CupertinoColors.systemGrey,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isExpense
                      ? "-$symbol ${_viewModel.formatCurrency(item.amount)}"
                      : "+$symbol ${_viewModel.formatCurrency(item.amount)}",
                  style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  DateFormat('dd/MM/yyyy').format(item.date),
                  style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                    fontSize: 12.sp,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
