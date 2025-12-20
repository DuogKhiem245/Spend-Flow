import 'package:cupertino_native/components/switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/features/setting/security/passcode/create_or_update_view.dart';
import 'package:spend_flow/features/setting/security/security_viewmodel.dart';

class SecurityView extends StatefulWidget {
  const SecurityView({super.key});

  @override
  State<SecurityView> createState() => _SecurityViewState();
}

class _SecurityViewState extends State<SecurityView> {
  late final SecurityViewModel _viewModel;

  bool _isInteracting = false;

  @override
  void initState() {
    super.initState();
    _viewModel = SecurityViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        if (_viewModel.isLoading) {
          return const CupertinoPageScaffold(
            child: Center(child: CupertinoActivityIndicator()),
          );
        }

        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            border: null,
            padding: EdgeInsetsDirectional.only(start: 10.w),
            leading: CupertinoNavigationBarBackButton(
              color: CupertinoTheme.of(context).primaryColor,
              onPressed: () => Navigator.pop(context),
            ),
            middle: Text(
              '${l10n.passcode} & ${_viewModel.isFaceId() ? l10n.face : l10n.fingerprint}',
              style: TextStyle(
                color: CupertinoTheme.of(context).textTheme.textStyle.color,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(l10n.passcode.toUpperCase()),
                  SizedBox(height: 10.h),

                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: CupertinoTheme.of(context).barBackgroundColor,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.boxShadow,
                          blurRadius: 10.r,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                _buildIconBox(
                                  CupertinoIcons.lock_fill,
                                  const Color(0xFF6366F1),
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  l10n.passcode.toUpperCase(),
                                  style: TextStyle(
                                    color: CupertinoTheme.of(
                                      context,
                                    ).textTheme.textStyle.color,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            CNSwitch(
                              value: _viewModel.isPasscodeEnabled,
                              onChanged: (bool newValue) async {
                                if (_isInteracting) return;

                                setState(() => _isInteracting = true);

                                await _showPasscodeModal(
                                  context,
                                  isChangeMode: false,
                                  isRemoveMode: !newValue,
                                );

                                if (mounted) {
                                  setState(() => _isInteracting = false);
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          l10n.pass_code_description,
                          style: TextStyle(
                            color: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.color?.withValues(alpha: 0.7),
                            fontSize: 13.sp,
                            height: 1.4,
                          ),
                        ),

                        if (_viewModel.isPasscodeEnabled) ...[
                          SizedBox(height: 16.h),
                          _buildInnerButton(
                            label: l10n.change_passcode,
                            icon: CupertinoIcons.padlock,
                            onTap: () async {
                              await _showPasscodeModal(
                                context,
                                isChangeMode: true,
                                isRemoveMode: false,
                              );
                              setState(() {});
                            },
                          ),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  _buildSectionHeader(
                    l10n.biometric_authentication.toUpperCase(),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: CupertinoTheme.of(context).barBackgroundColor,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.boxShadow,
                          blurRadius: 10.r,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                _buildIconBox(
                                  _viewModel.isFaceId()
                                      ? CupertinoIcons.smiley
                                      : Icons.fingerprint,
                                  const Color(0xFFEF4444),
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  _viewModel.isFaceId()
                                      ? l10n.face
                                      : l10n.fingerprint,
                                  style: TextStyle(
                                    color: CupertinoTheme.of(
                                      context,
                                    ).textTheme.textStyle.color,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            CNSwitch(
                              value: _viewModel.isBiometricEnabled,
                              onChanged: (bool value) async {
                                final errorMsg = await _viewModel.toggleBiometric(
                                  value,
                                );

                                debugPrint("Error Msg: $errorMsg");

                                if (errorMsg != null && context.mounted) {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (ctx) => CupertinoAlertDialog(
                                      title: Text(l10n.error),
                                      content: Text(errorMsg),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: Text(l10n.ok),
                                          onPressed: () => Navigator.pop(ctx),
                                        ),
                                      ],
                                    ),
                                  );
                                  setState(() {});
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          _viewModel.isFaceId()
                              ? l10n.face_id_description
                              : l10n.touch_id_description,
                          style: TextStyle(
                            color: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.color?.withValues(alpha: 0.7),
                            fontSize: 13.sp,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Text(
        title,
        style: TextStyle(
          color: const Color(0xFF9CA3AF),
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildIconBox(IconData icon, Color color) {
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Icon(icon, color: Colors.white, size: 20.sp),
    );
  }

  Widget _buildInnerButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: CupertinoColors.white, size: 16.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> _showPasscodeModal(
    BuildContext context, {
    required bool isChangeMode,
    required bool isRemoveMode,
  }) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 5.h,
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey3,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  child: CreateOrUpdateView(
                    isChangeMode: isChangeMode,
                    isRemoveMode: isRemoveMode,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (result == true) {

      await _viewModel.reload();

      await Future.delayed(const Duration(milliseconds: 300));

      if (!context.mounted) return;

      _showSuccessDialog(context, isChangeMode, isRemoveMode);
    }
  }

  void _showSuccessDialog(
    BuildContext context,
    bool isChangeMode,
    bool isRemoveMode,
  ) {
    String message;
    final l10n = AppLocalizations.of(context)!;
    if (isRemoveMode) {
      message = l10n.passcode_turn_off_success;
    } else if (isChangeMode) {
      message = l10n.passcode_update_success;
    } else {
      message = l10n.passcode_create_success;
    }

    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(l10n.notifications),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text(l10n.ok),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }
}
