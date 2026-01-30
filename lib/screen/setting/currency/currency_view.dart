import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/data/currency_data.dart';
import 'package:spend_flow/screen/setting/setting_viewmodel.dart'; // <--- 1. Import ViewModel

class CurrencyView extends StatefulWidget {
  const CurrencyView({super.key});

  @override
  State<CurrencyView> createState() => _CurrencyViewState();
}

class _CurrencyViewState extends State<CurrencyView> {
  final _settingViewModel = SettingViewModel();

  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  final List<Map<String, String>> _popularList = CurrencyData().popularList;
  final List<Map<String, String>> _allList = CurrencyData().allList;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final isSearching = _searchText.isNotEmpty;

    final searchList = [..._popularList, ..._allList].where((c) {
      final query = _searchText.toLowerCase();
      return c['code']!.toLowerCase().contains(query) ||
          c['name']!.toLowerCase().contains(query);
    }).toList();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        leading: CupertinoNavigationBarBackButton(
          color: AppColors.primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          l10n.select_currency,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: CupertinoSearchTextField(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 12.w,
                vertical: 10.h,
              ),
              controller: _searchController,
              placeholderStyle: CupertinoTheme.of(context).textTheme.textStyle
                  .copyWith(color: CupertinoColors.systemGrey, fontSize: 16.sp),
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                color: CupertinoColors.black,
                fontSize: 16.sp,
              ),
              itemColor: CupertinoColors.systemGrey,
              placeholder: l10n.search_currency,
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
          ),

          _buildWarningNote(context, l10n),

          Expanded(
            child: ListView(
              children: [
                if (isSearching)
                  _buildGroup(searchList)
                else ...[
                  _buildSectionHeader(l10n.popular.toUpperCase()),
                  _buildGroup(_popularList),
                  SizedBox(height: 20.h),
                  _buildSectionHeader(l10n.all_currencies.toUpperCase()),
                  _buildGroup(_allList),
                ],
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningNote(BuildContext context, AppLocalizations l10n) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.warningColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.warningColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.exclamationmark_circle_fill,
            color: AppColors.warningColor,
            size: 20.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              l10n.currency_change_warning,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                height: 1.4,
                color: CupertinoTheme.of(context).textTheme.textStyle.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 8.h),
      child: Text(
        title,
        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
          color: CupertinoColors.systemGrey,
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildGroup(List<Map<String, String>> currencies) {
    if (currencies.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        children: List.generate(currencies.length, (index) {
          final item = currencies[index];
          final isLast = index == currencies.length - 1;
          return _buildItem(item, isLast: isLast);
        }),
      ),
    );
  }

  Widget _buildItem(Map<String, String> item, {bool isLast = false}) {
    final isSelected = _settingViewModel.currentCurrencyCode == item['code'];

    return GestureDetector(
      onTap: () async {
        await _settingViewModel.setCurrency(item['code']!);
        setState(() {});
        if (!mounted) return;
        Navigator.pop(context);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  Text(
                    item['flag']!,
                    style: CupertinoTheme.of(
                      context,
                    ).textTheme.textStyle.copyWith(fontSize: 28.sp),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: item['code']!,
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .copyWith(
                                      color: CupertinoTheme.of(
                                        context,
                                      ).textTheme.textStyle.color,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              TextSpan(
                                text: " (${item['symbol']})",
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .copyWith(
                                      color: CupertinoColors.systemGrey,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          item['name']!,
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                color: CupertinoColors.systemGrey,
                                fontSize: 14.sp,
                              ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      CupertinoIcons.checkmark,
                      color: const Color(0xFF3B82F6),
                      size: 20.sp,
                    ),
                ],
              ),
            ),
            if (!isLast)
              Divider(
                height: 1,
                color: AppColors.borderColor.withValues(alpha: 0.5),
              ),
          ],
        ),
      ),
    );
  }
}
