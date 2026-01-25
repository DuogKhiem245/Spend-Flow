import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/widgets/check_valid/check_valid_widget.dart';
import 'package:spend_flow/core/widgets/nav.dart';
import 'package:spend_flow/features/auth/view/login_view.dart';
import 'package:spend_flow/features/setting/currency/currency_view.dart';
import 'package:spend_flow/features/setting/setting_viewmodel.dart';
import 'package:spend_flow/features/wallet/wallet_viewmodel.dart';

class WalletView extends StatefulWidget {
  final bool firstWallet;
  const WalletView({super.key, this.firstWallet = true});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  final WalletViewModel _viewModel = WalletViewModel();
  final SettingViewModel _settingViewModel = SettingViewModel();

  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _settingViewModel.loadSettings();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onConfirm() async {
    final l10n = AppLocalizations.of(context)!;
    if (_nameController.text.trim().isEmpty) {
      CheckValidWidget.showIncompleteDetailsSheet(
        context: context,
        title: l10n.incomplete_details,
        description: l10n.please_fill_required_fields,
        missingFields: [l10n.wallet_name],
        buttonText: "OK",
      );
      return;
    }

    await _viewModel.createWallet(
      name: _nameController.text.trim(),
      currency: _settingViewModel.currentCurrencyCode,
    );

    if (widget.firstWallet) {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) => const BottomNavbar()),
          (route) => false,
        );
      }
      return;
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bool isDarkMode =
        CupertinoTheme.of(context).brightness == Brightness.dark;

    return ListenableBuilder(
      listenable: Listenable.merge([_viewModel, _settingViewModel]),
      builder: (context, child) {
        return CupertinoPageScaffold(
          backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
          navigationBar: CupertinoNavigationBar(
            padding: EdgeInsetsDirectional.zero,
            backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
            automaticallyImplyLeading: !widget.firstWallet,
            border: null,
            leading: widget.firstWallet
                ? null
                : CupertinoNavigationBarBackButton(
                    color: CupertinoTheme.of(context).primaryColor,
                    onPressed: _viewModel.isLoading
                        ? null
                        : () => Navigator.pop(context),
                  ),
            middle: Text(
              widget.firstWallet ? l10n.create_first_wallet : l10n.add_wallet,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 40.h,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryColor.withValues(
                                      alpha: 0.2,
                                    ),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24.r),
                                child: Image.asset(
                                  isDarkMode
                                      ? 'lib/assets/images/logoDark.png'
                                      : 'lib/assets/images/logoLight.png',
                                  width: 100.w,
                                  height: 100.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 16.h),

                          Center(
                            child: Text(
                              widget.firstWallet
                                  ? l10n.welcome_create_wallet
                                  : l10n.add_wallet_description,
                              textAlign: TextAlign.center,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                    fontSize: 14.sp,
                                    color: CupertinoColors.systemGrey,
                                  ),
                            ),
                          ),

                          SizedBox(height: 40.h),

                          Text(
                            l10n.enter_wallet_name,
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: CupertinoTheme.of(context)
                                      .textTheme
                                      .textStyle
                                      .color!
                                      .withValues(alpha: .8),
                                ),
                          ),

                          SizedBox(height: 8.h),
                          CupertinoTextField(
                            controller: _nameController,
                            placeholder: l10n.eg_my_wallet,
                            decoration: BoxDecoration(
                              color: CupertinoTheme.of(
                                context,
                              ).barBackgroundColor,
                              borderRadius: BorderRadius.circular(30.r),
                            ),

                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),

                            placeholderStyle: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontSize: 16.sp,
                                  color: CupertinoColors.placeholderText,
                                ),

                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontSize: 16.sp,
                                  color: CupertinoTheme.of(
                                    context,
                                  ).textTheme.textStyle.color,
                                ),
                          ),

                          SizedBox(height: 24.h),

                          if (widget.firstWallet) ...[
                            Text(
                              l10n.currency_unit,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .color!
                                        .withValues(alpha: .8),
                                  ),
                            ),
                            SizedBox(height: 8.h),
                            GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const CurrencyView(),
                                  ),
                                );
                                _settingViewModel.loadSettings();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 14.h,
                                ),
                                decoration: BoxDecoration(
                                  color: CupertinoTheme.of(
                                    context,
                                  ).barBackgroundColor,
                                  borderRadius: BorderRadius.circular(30.r),
                                ),

                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.money_dollar_circle_fill,
                                      color: AppColors.primaryColor,
                                      size: 24.sp,
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      l10n.currency,
                                      style: CupertinoTheme.of(context)
                                          .textTheme
                                          .textStyle
                                          .copyWith(
                                            fontSize: 16.sp,
                                            color: CupertinoTheme.of(
                                              context,
                                            ).textTheme.textStyle.color,
                                          ),
                                    ),

                                    const Spacer(),

                                    Text(
                                      _settingViewModel.currentCurrencyCode,
                                      style: CupertinoTheme.of(context)
                                          .textTheme
                                          .textStyle
                                          .copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: CupertinoColors.systemGrey,
                                          ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Icon(
                                      CupertinoIcons.chevron_right,
                                      size: 16.sp,
                                      color: CupertinoColors.systemGrey3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],

                          const Spacer(),
                          SizedBox(height: 20.h),

                          SizedBox(
                            width: double.infinity,
                            child: CupertinoButton(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(30.r),
                              onPressed: _viewModel.isLoading
                                  ? null
                                  : _onConfirm,
                              child: _viewModel.isLoading
                                  ? const CupertinoActivityIndicator(
                                      color: CupertinoColors.white,
                                    )
                                  : Text(
                                      l10n.create_wallet,
                                      style: CupertinoTheme.of(context)
                                          .textTheme
                                          .textStyle
                                          .copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                          ),
                                    ),
                            ),
                          ),
                          if (widget.firstWallet &&
                              FirebaseAuth.instance.currentUser == null) ...[
                            SizedBox(height: 10.h),
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    l10n.have_account,
                                    style: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .copyWith(
                                          fontSize: 14.sp,
                                          color: CupertinoTheme.of(context)
                                              .textTheme
                                              .textStyle
                                              .color!
                                              .withValues(alpha: 0.7),
                                        ),
                                  ),

                                  CupertinoButton(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.h,
                                      horizontal: 4.w,
                                    ),
                                    onPressed: _viewModel.isLoading
                                        ? null
                                        : () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    const LoginPage(
                                                      haveBack: true,
                                                    ),
                                              ),
                                            );
                                          },
                                    child: Text(
                                      l10n.login,
                                      style: CupertinoTheme.of(context)
                                          .textTheme
                                          .textStyle
                                          .copyWith(
                                            fontSize: 14.sp,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
