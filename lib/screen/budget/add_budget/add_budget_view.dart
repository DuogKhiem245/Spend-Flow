import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/core/services/ads_service.dart';
import 'package:spend_flow/core/widgets/check_valid/check_valid_widget.dart';
import 'package:spend_flow/screen/transaction/add_transaction/widgets/amount_widget.dart';
import 'package:spend_flow/screen/transaction/add_transaction/widgets/note_widget.dart';
import 'package:spend_flow/screen/transaction/add_transaction/widgets/suggest_category_widget.dart';
import 'package:spend_flow/screen/budget/add_budget/add_budget_viewmodel.dart';
import 'package:spend_flow/core/model/budget_model.dart';
import 'package:spend_flow/screen/wallet/wallet_view.dart';
import 'package:spend_flow/screen/wallet/wallet_viewmodel.dart';
import 'package:spend_flow/main.dart';

class AddBudgetView extends StatefulWidget {
  final BudgetModel? budgetToEdit;
  final bool isFromAI;

  const AddBudgetView({super.key, this.budgetToEdit, this.isFromAI = false});

  @override
  State<AddBudgetView> createState() => _AddBudgetViewState();
}

class _AddBudgetViewState extends State<AddBudgetView> {
  final AddBudgetViewModel _viewModel = AddBudgetViewModel();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  CategoryModel? _selectedCategory;

  final AdsService _adsService = AdsService();
  final _premiumViewModel = premiumViewModel;

  @override
  void initState() {
    super.initState();

    _checkPremiumAndLoadAd();

    if (widget.budgetToEdit != null) {
      final item = widget.budgetToEdit!;
      _amountController.text = item.total.toStringAsFixed(0);
      _selectedCategory = item.category;
      _selectedDate = item.date;
      _noteController.text = item.note;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _checkPremiumAndLoadAd() async {
    if (!_premiumViewModel.isPremium) {
      _adsService.loadInterstitialAd();
    }
  }

  void _showNoWalletAlert(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    AdaptiveAlertDialog.show(
      context: context,
      title: l10n.no_wallets_yet,
      message: l10n.please_create_wallet_first,
      icon: 'creditcard.and.123',
      actions: [
        AlertAction(
          title: l10n.cancel,
          style: AlertActionStyle.cancel,
          onPressed: () => {},
        ),
        AlertAction(
          title: l10n.create_now,
          style: AlertActionStyle.primary,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const WalletView(firstWallet: false),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final baseColor = CupertinoTheme.of(context).textTheme.textStyle.color;
    final String pageTitle = widget.budgetToEdit != null
        ? l10n.edit_budget
        : l10n.add_budget;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.only(end: 10.w),
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoTheme.of(context).primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          pageTitle,
          style: CupertinoTheme.of(context).textTheme.textStyle
              .copyWith(fontWeight: FontWeight.w600, fontSize: 20.sp),
        ),
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h),

                      AmountWidget(
                        amountController: _amountController,
                        baseColor: baseColor,
                      ),

                      SizedBox(height: 20.h),

                      SuggestCategoryWidget(
                        selectedCategory: _selectedCategory,
                        baseColor: baseColor,
                        transactionDate: _selectedDate,
                        isMonthPicker: true,
                        setMinDate: true,
                        onCategoryChanged: (CategoryModel category) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        onDateChanged: (DateTime newDate) {
                          setState(() {
                            _selectedDate = newDate;
                          });
                        },
                      ),

                      SizedBox(height: 20.h),

                      NoteWidget(
                        baseColor: baseColor,
                        controller: _noteController,
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    onPressed: () async {
                      List<String> missingFields = [];

                      if (_amountController.text.trim().isEmpty ||
                          _amountController.text == "0") {
                        missingFields.add(l10n.amount);
                      }
                      if (_selectedCategory == null) {
                        missingFields.add(l10n.category);
                      }
                      if (missingFields.isNotEmpty) {
                        CheckValidWidget.showIncompleteDetailsSheet(
                          context: context,
                          title: l10n.incomplete_details,
                          description: l10n.please_fill_required_fields,
                          missingFields: missingFields,
                          buttonText: "OK",
                        );
                        return;
                      }

                      final hasWallet = await WalletViewModel()
                          .checkUserHasWallet();

                      if (!hasWallet) {
                        if (!context.mounted) return;
                        _showNoWalletAlert(context);
                        return;
                      }
                      if (!mounted) return;

                      await _viewModel.saveBudget(
                        idToUpdate: widget.budgetToEdit?.id,
                        amount: _amountController.text,
                        category: _selectedCategory!,
                        date: _selectedDate,
                        note: _noteController.text,
                      );

                      if (!context.mounted) return;
                      if (_premiumViewModel.isPremium) {
                        Navigator.pop(context, true);
                        return;
                      } else {
                        await _adsService.showInterstitialWithFrequency(
                          isPremium: _premiumViewModel.isPremium,
                          onAdClosed: () {
                            Navigator.pop(context, true);
                          },
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(30.r),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Text(
                      l10n.save,
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
