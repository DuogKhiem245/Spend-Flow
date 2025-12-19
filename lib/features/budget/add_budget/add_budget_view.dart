import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/features/add_stransaction/model/category_model.dart';
import 'package:spend_flow/features/add_stransaction/widgets/amount_widget.dart';
import 'package:spend_flow/features/add_stransaction/widgets/suggest_category_widget.dart';
import 'package:spend_flow/features/budget/add_budget/add_budget_viewmodel.dart';
import 'package:spend_flow/features/budget/budget_model.dart';

class AddBudgetView extends StatefulWidget {
  final BudgetModel? budgetToEdit;
  
  const AddBudgetView({super.key, this.budgetToEdit});

  @override
  State<AddBudgetView> createState() => _AddBudgetViewState();
}

class _AddBudgetViewState extends State<AddBudgetView> {
  final AddBudgetViewModel _viewModel = AddBudgetViewModel();

  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();

    if (widget.budgetToEdit != null) {
      final item = widget.budgetToEdit!;
      _amountController.text = item.total.toStringAsFixed(0);
      _selectedCategory = item.category;
      _selectedDate = item.date;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
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
          style: CupertinoTheme.of(context).textTheme.navTitleTextStyle
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
                      if (_selectedCategory == null ||
                          _amountController.text.isEmpty) {
                        return;
                      }

                      await _viewModel.saveBudget(
                        idToUpdate: widget.budgetToEdit?.id,
                        amount: _amountController.text,
                        category: _selectedCategory!,
                        date: _selectedDate, 
                      );

                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(30.r),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Text(
                      l10n.save,
                      style: TextStyle(
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
