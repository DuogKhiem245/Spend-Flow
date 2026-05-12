import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/services/ads_service.dart';
import 'package:spend_flow/core/widgets/check_valid/check_valid_widget.dart';
import 'package:spend_flow/core/widgets/loading_overlay.dart';
import 'package:spend_flow/screen/transaction/add_transaction/add_transaction_viewmodel.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/screen/transaction/add_transaction/widgets/amount_widget.dart';
import 'package:spend_flow/screen/transaction/add_transaction/widgets/my_map_widget.dart';
import 'package:spend_flow/screen/transaction/add_transaction/widgets/name_stransaction_widget.dart';
import 'package:spend_flow/screen/transaction/add_transaction/widgets/note_widget.dart';
import 'package:spend_flow/screen/transaction/add_transaction/widgets/suggest_category_widget.dart';
import 'package:spend_flow/screen/wallet/wallet_view.dart';
import 'package:spend_flow/screen/wallet/wallet_viewmodel.dart';
import 'package:spend_flow/main.dart';

class AddTransactionPage extends StatefulWidget {
  final TransactionModel? transactionData;
  final bool isFromAI;
  const AddTransactionPage({
    super.key,
    this.transactionData,
    this.isFromAI = false,
  });

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final AddTransactionViewmodel _viewModel = AddTransactionViewmodel();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final AdsService _adsService = AdsService();
  final _premiumViewModel = premiumViewModel;

  DateTime? _transactionDate;
  CategoryModel? _selectedCategory;
  int _index = 0;

  bool _isLoading = false;
  bool _hasWallet = false;

  @override
  void initState() {
    super.initState();
    _checkPremiumAndLoadAd();

    if (widget.transactionData != null) {
      final t = widget.transactionData!;
      _amountController.text = t.amount.toString();
      _nameController.text = t.title;
      _noteController.text = t.note;
      _selectedCategory = t.category;
      _transactionDate = t.date;

      _index = t.isIncome ? 1 : 0;

      if (t.location.latitude != null && t.location.longitude != null) {
        final position = Position(t.location.longitude!, t.location.latitude!);

        _viewModel.updateLocation(position, t.location.address ?? '');
      } else {
        _viewModel.getCurrentLocation();
      }
    } else {
      _viewModel.getCurrentLocation();
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _nameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _checkPremiumAndLoadAd() async {
    if (!_premiumViewModel.isPremium) {
      _adsService.loadInterstitialAd();
    }
  }

  void _onTabChanged(int index) {
    if (_index != index) {
      setState(() {
        _index = index;
        _clearData();
        HapticFeedback.lightImpact();
      });
    }
  }

  void _clearData() {
    _amountController.clear();
    _nameController.clear();
    _noteController.clear();
    _transactionDate = null;
    _selectedCategory = null;
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
          onPressed: () => Navigator.pop(context),
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

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.only(end: 10.w),
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoTheme.of(context).primaryColor,
          onPressed: _isLoading ? null : () => Navigator.pop(context),
        ),
        middle: Text(
          l10n.add_transaction,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      ),
      child: LoadingOverlay(
        isLoading: _isLoading,
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Stack(
            children: [
              Column(
                children: [
                  AdaptiveSegmentedControl(
                    labels: [l10n.expenses, l10n.income],
                    selectedIndex: _index,
                    height: 50.h,
                    color: CupertinoTheme.of(context).primaryColor,
                    onValueChanged: _isLoading
                        ? (i) {}
                        : (i) => setState(() => _onTabChanged(i)),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom +
                                  20.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 25.h),
                                AmountWidget(
                                  amountController: _amountController,
                                  baseColor: baseColor,
                                ),
                                SizedBox(height: 20.h),
                                NameTransactionWidget(
                                  nameController: _nameController,
                                  baseColor: baseColor,
                                ),
                                SizedBox(height: 20.h),
                                SuggestCategoryWidget(
                                  selectedCategory: _selectedCategory,
                                  baseColor: baseColor,
                                  transactionDate: _transactionDate,
                                  onCategoryChanged: (CategoryModel category) {
                                    setState(() {
                                      _selectedCategory = category;
                                    });
                                  },
                                  onDateChanged: (DateTime newDate) {
                                    setState(() {
                                      _transactionDate = newDate;
                                    });
                                  },
                                ),
                                SizedBox(height: 20.h),
                                MyMapWidget(viewModel: _viewModel),
                                SizedBox(height: 20.h),
                                NoteWidget(
                                  baseColor: baseColor,
                                  controller: _noteController,
                                ),
                                SizedBox(height: 100.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: CupertinoButton.filled(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                List<String> missingFields = [];

                                if (_amountController.text.trim().isEmpty ||
                                    _amountController.text == "0") {
                                  missingFields.add(l10n.amount);
                                }
                                if (_nameController.text.trim().isEmpty) {
                                  missingFields.add(l10n.name);
                                }
                                if (_selectedCategory == null) {
                                  missingFields.add(l10n.category);
                                }
                                if (missingFields.isNotEmpty) {
                                  CheckValidWidget.showIncompleteDetailsSheet(
                                    context: context,
                                    title: l10n.incomplete_details,
                                    description:
                                        l10n.please_fill_required_fields,
                                    missingFields: missingFields,
                                    buttonText: "OK",
                                  );
                                  return;
                                }

                                if (widget.isFromAI) {
                                  String rawAmount = _amountController.text
                                      .replaceAll(RegExp(r'[^0-9]'), '');

                                  double finalAmount =
                                      double.tryParse(rawAmount) ?? 0;
                                  final updatedTransaction = widget
                                      .transactionData
                                      ?.copyWith(
                                        amount: finalAmount,
                                        title: _nameController.text.trim(),
                                        category: _selectedCategory,
                                        date: _transactionDate,
                                        note: _noteController.text.trim(),
                                        isIncome: _index == 1,
                                        location: _viewModel
                                            .getLocationFromState(),
                                      );

                                  if (!context.mounted) return;
                                  Navigator.pop(context, updatedTransaction);
                                  return;
                                }

                                setState(() => _isLoading = true);

                                _hasWallet = await WalletViewModel()
                                    .checkUserHasWallet();
                                if (!_hasWallet) {
                                  setState(() => _isLoading = false);
                                  if (!context.mounted) return;
                                  _showNoWalletAlert(context);
                                  return;
                                }

                                try {
                                  if (_index == 0) {
                                    await _viewModel.addExpenseTransaction(
                                      _amountController.text,
                                      _nameController.text,
                                      _selectedCategory,
                                      _transactionDate,
                                      _noteController.text,
                                      _viewModel.getLocationFromState(),
                                    );
                                  } else {
                                    await _viewModel.addIncomeTransaction(
                                      _amountController.text,
                                      _nameController.text,
                                      _selectedCategory,
                                      _transactionDate,
                                      _noteController.text,
                                      _viewModel.getLocationFromState(),
                                    );
                                  }

                                  if (!context.mounted) return;

                                  if (_premiumViewModel.isPremium) {
                                    Navigator.pop(context, true);
                                    return;
                                  } else {
                                    await _adsService
                                        .showInterstitialWithFrequency(
                                          isPremium:
                                              _premiumViewModel.isPremium,
                                          onAdClosed: () {
                                            Navigator.pop(context, true);
                                          },
                                        );
                                  }
                                } catch (e) {
                                  debugPrint("Error add transaction: $e");
                                } finally {
                                  if (mounted) {
                                    setState(() => _isLoading = false);
                                  }
                                }
                              },
                        borderRadius: BorderRadius.circular(30.r),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Text(
                          _index == 0 ? l10n.add_expense : l10n.add_income,
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
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
