import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/screen/setting/data_management/import/animated_dashed_painter.dart';
import 'package:spend_flow/screen/setting/data_management/import/import_viewmodel.dart';

class ImportView extends StatefulWidget {
  const ImportView({super.key});

  @override
  State<ImportView> createState() => _ImportViewState();
}

class _ImportViewState extends State<ImportView>
    with SingleTickerProviderStateMixin {
  final ImportViewModel _viewModel = ImportViewModel();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showFormatTemplate(BuildContext context, AppLocalizations l10n) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              await _viewModel.exportCsvTemplate();
              if (!context.mounted) return;
              Navigator.pop(context);
            },
            child: Text(l10n.download_sample_file('CSV')),
          ),
          // CupertinoActionSheetAction(
          //   onPressed: () async {
          //     await _viewModel.exportExcelTemplate(context);
          //     if (!context.mounted) return;
          //     Navigator.pop(context);
          //   },
          //   child: Text(l10n.download_sample_file('Excel')),
          // ),
          CupertinoActionSheetAction(
            onPressed: () async {
              await _viewModel.exportJsonTemplate();
              if (!context.mounted) return;
              Navigator.pop(context);
            },
            child: Text(l10n.download_sample_file('JSON')),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.close),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
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
              l10n.import_data,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: CupertinoTheme.of(context).textTheme.textStyle.color,
              ),
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _showFormatTemplate(context, l10n),
              child: Icon(
                CupertinoIcons.question_circle,
                color: AppColors.primaryColor,
                size: 22.sp,
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  _buildHeader(l10n),
                  SizedBox(height: 20.h),
                  _buildUploadArea(context),
                  SizedBox(height: 20.h),
                  _buildAcceptedFormats(l10n),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.recent_imports,
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                color: CupertinoColors.systemGrey,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 12.h),
                        Expanded(
                          child: ListenableBuilder(
                            listenable: _viewModel,
                            builder: (context, child) {
                              if (_viewModel.recentImports.isEmpty) {
                                return Center(
                                  child: Text(
                                    l10n.no_recent_imports,
                                    style: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .copyWith(
                                          color: CupertinoColors.systemGrey,
                                          fontSize: 14.sp,
                                        ),
                                  ),
                                );
                              }

                              return ListView.builder(
                                padding: EdgeInsets.only(bottom: 20.h),
                                itemCount: min(
                                  _viewModel.recentImports.length,
                                  4,
                                ),
                                itemBuilder: (context, index) {
                                  return _historyItem(
                                    _viewModel.recentImports[index],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildSecurityFooter(l10n),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
              fontSize: 28.sp,
              fontWeight: FontWeight.w800,
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
            children: [
              TextSpan(text: l10n.import_data_title),
              TextSpan(
                text: l10n.data,
                style: CupertinoTheme.of(
                  context,
                ).textTheme.textStyle.copyWith(color: AppColors.primaryColor),
              ),
              TextSpan(text: l10n.import_data_title_2),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          l10n.import_data_description,
          textAlign: TextAlign.center,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            color: CupertinoColors.systemGrey,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadArea(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CustomPaint(
      painter: AnimatedDashedPainter(
        animation: _controller,
        color: AppColors.primaryColor.withValues(alpha: 0.5),
        strokeWidth: 2,
        radius: 30.r,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: .03),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final yOffset = sin(_controller.value * 2 * pi) * 5;
                return Transform.translate(
                  offset: Offset(0, yOffset),
                  child: child,
                );
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Icon(
                    CupertinoIcons.folder_fill,
                    size: 70.sp,
                    color: AppColors.primaryColor.withValues(alpha: .9),
                  ),
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8B931),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      CupertinoIcons.star_fill,
                      size: 10.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              l10n.select_file_to_import,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: CupertinoTheme.of(context).textTheme.textStyle.color,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              l10n.tap_to_browse,
              textAlign: TextAlign.center,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                color: CupertinoColors.systemGrey,
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 25.h),
            CupertinoButton(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(30.r),
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
              onPressed: _viewModel.status == ImportStatus.loading
                  ? null
                  : () => _viewModel.pickAndImportFile(context, l10n),
              child: _viewModel.status == ImportStatus.loading
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: CupertinoTheme.of(context).primaryColor,
                      size: 10.w,
                    )
                  : Text(
                      l10n.select_file,
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcceptedFormats(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.accepted_formats,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            color: CupertinoColors.systemGrey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          spacing: 10.w,
          children: [
            _formatChip("CSV", CupertinoIcons.doc_text_fill, Colors.green),
            // _formatChip("Excel", CupertinoIcons.table_fill, Colors.blue),
            _formatChip(
              "JSON",
              CupertinoIcons.chevron_left_slash_chevron_right,
              Colors.orange,
            ),
          ],
        ),
      ],
    );
  }

  Widget _formatChip(String label, IconData icon, Color color) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18.sp),
            SizedBox(width: 6.w),
            Text(
              label,
              textAlign: TextAlign.center,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: CupertinoTheme.of(context).textTheme.textStyle.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _historyItem(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            item['format'].toString().toLowerCase() == 'csv'
                ? CupertinoIcons.doc_text_fill
                : item['format'].toString().toLowerCase() == 'excel'
                ? CupertinoIcons.table_fill
                : item['format'].toString().toLowerCase() == 'json'
                ? CupertinoIcons.chevron_left_slash_chevron_right
                : CupertinoIcons.doc,
            color: AppColors.primaryColor.withValues(alpha: 0.8),
            size: 26.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item['name'],
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        height: 1.2,
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color,
                      ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "${item['time']} • ${item['format']}",
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(
                        color: CupertinoColors.secondaryLabel.resolveFrom(
                          context,
                        ),
                        fontSize: 11.sp,
                        height: 1.1,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityFooter(AppLocalizations l10n) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.shield_fill,
                color: AppColors.primaryColor,
                size: 14.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                l10n.protected,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          l10n.protected_description,
          textAlign: TextAlign.center,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            color: CupertinoColors.systemGrey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
