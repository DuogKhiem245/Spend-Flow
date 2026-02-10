import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/main.dart';

class FontView extends StatefulWidget {
  const FontView({super.key});

  @override
  State<FontView> createState() => _FontViewState();
}

class _FontViewState extends State<FontView> {
  late String _selectedFont;

  final List<String> _allFonts = [
    'Lexend',
    'Plus Jakarta Sans',
    'Outfit',
    'Manrope',
    'Inter',
    'Be Vietnam Pro',

    'Bricolage Grotesque',
    'Syne',
    'Righteous',
    'Comfortaa',
    'Fraunces',

    'JetBrains Mono',
    'Space Grotesk',
    // 'Space Mono',
  ];

  @override
  void initState() {
    super.initState();
    _selectedFont = fontViewModel.currentFont;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoTheme.of(context).primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          l10n.font_selection,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
      ),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        itemCount: _allFonts.length,
        itemBuilder: (context, index) {
          return _buildFontItem(_allFonts[index], l10n);
        },
      ),
    );
  }

  Widget _buildFontItem(String fontName, AppLocalizations l10n) {
    final isSelected = _selectedFont == fontName;

    return GestureDetector(
      onTap: () async {
        setState(() {
          _selectedFont = fontName;
        });
        await fontViewModel.changeFont(fontName);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).barBackgroundColor,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 45.w,
              height: 45.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor.withValues(alpha: .1)
                    : CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color!.withValues(alpha: .15),
                shape: BoxShape.circle,
              ),
              child: Text(
                "Aa",
                style: GoogleFonts.getFont(
                  fontName,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? AppColors.primaryColor
                      : CupertinoTheme.of(context).textTheme.textStyle.color,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fontName,
                    style: GoogleFonts.getFont(
                      fontName,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    l10n.font_description,
                    style: GoogleFonts.getFont(
                      fontName,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color!.withValues(alpha: .6),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            _buildRadioButton(isSelected),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButton(bool isSelected) {
    return Container(
      margin: EdgeInsets.only(left: 5.w),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
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
      ),
    );
  }
}
