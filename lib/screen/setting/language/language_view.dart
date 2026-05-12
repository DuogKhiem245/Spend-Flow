import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/data/language_data.dart';
import 'package:spend_flow/core/services/general_service/language_service.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  late String _selectedLanguageCode;

  final LanguageService _languageService = LanguageService();
  final List<Map<String, String>> _allLanguages = LanguageData.allLanguages;

  @override
  void initState() {
    super.initState();
    _selectedLanguageCode = _languageService.locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // final suggestedLangs = _allLanguages
    //     .where((l) => ['en', 'vi'].contains(l['code']))
    //     .toList();
    final otherLangs = _allLanguages.toList();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoTheme.of(context).primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          l10n.select_language,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // _buildSectionHeader(l10n.suggested.toUpperCase()),
                    // SizedBox(height: 8.h),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: CupertinoTheme.of(context).barBackgroundColor,
                    //     borderRadius: BorderRadius.circular(30.r),
                    //   ),
                    //   child: Column(
                    //     children: List.generate(suggestedLangs.length, (index) {
                    //       final lang = suggestedLangs[index];
                    //       return _buildLanguageItem(
                    //         lang,
                    //         isLast: index == suggestedLangs.length - 1,
                    //       );
                    //     }),
                    //   ),
                    // ),

                    // SizedBox(height: 24.h),

                    _buildSectionHeader(l10n.all_languages.toUpperCase()),
                    SizedBox(height: 8.h),
                    Container(
                      decoration: BoxDecoration(
                        color: CupertinoTheme.of(context).barBackgroundColor,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Column(
                        children: List.generate(otherLangs.length, (index) {
                          final lang = otherLangs[index];
                          return _buildLanguageItem(
                            lang,
                            isLast: index == otherLangs.length - 1,
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Text(
        title,
        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }

  Widget _buildLanguageItem(Map<String, String> lang, {bool isLast = false}) {
    final isSelected = _selectedLanguageCode == lang['code'];

    return GestureDetector(
      onTap: () async {
        setState(() {
          _selectedLanguageCode = lang['code']!;
        });
        await _languageService.changeLanguage(lang['code']!);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Text(
                  lang['flag']!,
                  style: CupertinoTheme.of(
                    context,
                  ).textTheme.textStyle.copyWith(fontSize: 24.sp),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lang['nativeName']!,
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: CupertinoTheme.of(
                                context,
                              ).textTheme.textStyle.color,
                            ),
                      ),
                      // if (lang['name'] != lang['nativeName']) ...[
                      //   SizedBox(height: 2.h),
                      //   Text(
                      //     lang['name']!,
                      //     style: CupertinoTheme.of(context).textTheme.textStyle
                      //         .copyWith(
                      //           fontSize: 14.sp,
                      //           color: CupertinoColors.systemGrey,
                      //         ),
                      //   ),
                      // ],
                    ],
                  ),
                ),

                _buildRadioButton(isSelected),
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
    );
  }

  Widget _buildRadioButton(bool isSelected) {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
        border: Border.all(
          color: isSelected
              ? AppColors.primaryColor
              : CupertinoColors.systemGrey4,
          width: 2,
        ),
      ),
      child: isSelected
          ? Icon(Icons.check, size: 16.sp, color: Colors.white)
          : null,
    );
  }
}
