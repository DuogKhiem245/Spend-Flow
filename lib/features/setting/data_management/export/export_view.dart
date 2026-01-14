import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/features/setting/data_management/export/export_viewmodel.dart';

enum ExportFormat { csv, excel, json }

class ExportView extends StatefulWidget {
  const ExportView({super.key});

  @override
  State<ExportView> createState() => _ExportViewState();
}

class _ExportViewState extends State<ExportView> {
  final ExportViewModel _viewModel = ExportViewModel();

  ExportFormat _selectedFormat = ExportFormat.csv;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.only(end: 10.w),
        border: null,
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        leading: CupertinoNavigationBarBackButton(
          color: AppColors.primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          l10n.export_data,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: CupertinoTheme.of(context).textTheme.textStyle.color,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.select_format,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: CupertinoTheme.of(context)
                            .textTheme
                            .textStyle
                            .color
                      ),
                    ),
                    SizedBox(height: 16.h),

                    _buildFormatOption(
                      format: ExportFormat.csv,
                      title: l10n.csv_format,
                      subtitle: l10n.csv_description,
                      icon: CupertinoIcons.doc_text_fill,
                      iconColor: const Color(0xFF2196F3), 
                      context: context,
                    ),

                    SizedBox(height: 12.h),

                    _buildFormatOption(
                      format: ExportFormat.excel,
                      title: l10n.excel_format,
                      subtitle: l10n.excel_description,
                      icon: CupertinoIcons.table_fill,
                      iconColor: CupertinoColors.activeGreen, 
                      context: context,
                    ),
                    SizedBox(height: 12.h),

                    _buildFormatOption(
                      format: ExportFormat.json,
                      title: l10n.json_format,
                      subtitle: l10n.json_description,
                      icon: CupertinoIcons.chevron_left_slash_chevron_right, 
                      iconColor: Color.fromRGBO(232, 162, 59, 1),
                      context: context,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(20.w),
              child: ListenableBuilder(
                listenable: _viewModel,
                builder: (context, child) {
                  return SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      borderRadius: BorderRadius.circular(30.r),
                      onPressed: _viewModel.isLoading
                          ? null
                          : () => _handleExport(context),
                      child: _viewModel.isLoading
                          ? const CupertinoActivityIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              l10n.export_data,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleExport(BuildContext context) {
    switch (_selectedFormat) {
      case ExportFormat.csv:
        _viewModel.exportCsv(context);
        break;
      case ExportFormat.excel:
        _viewModel.exportExcel(context);
        break;
      case ExportFormat.json:
        _viewModel.exportJson(context);
        break;
    }
  }

  Widget _buildFormatOption({
    required ExportFormat format,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required BuildContext context,
  }) {
    final isSelected = _selectedFormat == format;
    final activeColor = iconColor;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFormat = format;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).barBackgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? activeColor : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withValues(alpha: .05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Icon(icon, color: iconColor, size: 24.sp),
            ),
            SizedBox(width: 16.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: CupertinoTheme.of(context)
                          .textTheme
                          .textStyle
                          .color,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: CupertinoTheme.of(context)
                          .textTheme
                          .textStyle
                          .color
                          ?.withValues(alpha: .7),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? activeColor : Colors.transparent,
                border: Border.all(
                  color: isSelected ? activeColor : CupertinoColors.systemGrey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                      CupertinoIcons.checkmark_alt,
                      size: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
