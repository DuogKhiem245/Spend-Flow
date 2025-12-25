import 'package:cupertino_native/components/segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/widgets/loading_overlay.dart';
import 'package:spend_flow/features/transaction/add_transaction/add_transaction_viewmodel.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/features/transaction/add_transaction/widgets/amount_widget.dart';
import 'package:spend_flow/features/transaction/add_transaction/widgets/name_stransaction_widget.dart';
import 'package:spend_flow/features/transaction/add_transaction/widgets/note_widget.dart';
import 'package:spend_flow/features/transaction/add_transaction/widgets/suggest_category_widget.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final AddTransactionViewmodel _viewModel = AddTransactionViewmodel();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime? _transactionDate;
  CategoryModel? _selectedCategory;
  int _index = 0;

  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    _nameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    if (_index != index) {
      setState(() {
        _index = index;
        _clearData();
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
          style: CupertinoTheme.of(context).textTheme.navTitleTextStyle
              .copyWith(fontWeight: FontWeight.w600, fontSize: 20.sp),
        ),
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      ),
      child: LoadingOverlay(
        isLoading: _isLoading,
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            children: [
              CNSegmentedControl(
                labels: [l10n.expenses, l10n.income],
                height: 50.h,
                selectedIndex: _index,
                onValueChanged: _isLoading
                    ? (i) {}
                    : (i) => setState(() => _onTabChanged(i)),
                color: CupertinoTheme.of(context).primaryColor,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
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
                          NoteWidget(
                            baseColor: baseColor,
                            controller: _noteController,
                          ),
                          SizedBox(height: 30.h),
                          SizedBox(
                            width: double.infinity,
                            child: CupertinoButton.filled(
                              onPressed: _isLoading
                                  ? null
                                  : () async {
                                      // Bật loading
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      try {
                                        if (_index == 0) {
                                          await _viewModel
                                              .addExpenseTransaction(
                                                _amountController.text,
                                                _nameController.text,
                                                _selectedCategory,
                                                _transactionDate,
                                                _noteController.text,
                                              );
                                        } else {
                                          await _viewModel.addIncomeTransaction(
                                            _amountController.text,
                                            _nameController.text,
                                            _selectedCategory,
                                            _transactionDate,
                                            _noteController.text,
                                          );
                                        }

                                        if (!context.mounted) return;
                                        Navigator.pop(context);
                                      } catch (e) {
                                        debugPrint("Error add transaction: $e");
                                      } finally {
                                        if (mounted) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }
                                      }
                                    },
                              borderRadius: BorderRadius.circular(30.r),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: Text(
                                _index == 0
                                    ? l10n.add_expense
                                    : l10n.add_income,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
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
