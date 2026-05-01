import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/services/ads_service.dart';
import 'package:spend_flow/core/utils/date_helper.dart';
import 'package:spend_flow/core/widgets/custom_option/custom_option_widget.dart';
import 'package:spend_flow/core/widgets/loading_overlay.dart';
import 'package:spend_flow/main.dart';
import 'package:spend_flow/screen/premium/premium_view.dart';
import 'package:spend_flow/screen/setting/profile/profile_viewmodel.dart';
import 'package:spend_flow/screen/setting/profile/widget/profile_avatar_view.dart';
import 'package:spend_flow/screen/setting/profile/widget/profile_info_item_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileViewModel _viewModel = ProfileViewModel();
  final AdsService _adsService = AdsService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  DateTime _selectedDob = DateTime(1900, 1, 1);

  final _premiumViewModel = premiumViewModel;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    await _viewModel.loadUserProfile();

    if (_viewModel.userModel != null && mounted) {
      final user = _viewModel.userModel!;
      setState(() {
        _nameController.text = user.displayName;
        _emailController.text = user.email;
        _phoneController.text = user.phoneNumber;
        if (user.dob != null) {
          _selectedDob = user.dob!;
        }
      });
    }
  }

  Future<void> _handleSave() async {
    final l10n = AppLocalizations.of(context)!;
    FocusScope.of(context).unfocus();

    try {
      await _viewModel.updateProfile(
        displayName: _nameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        dob: _selectedDob,
      );

      if (mounted) {
        _showDialog(
          l10n.success,
          l10n.profile_updated_success,
          context,
          onSuccess: () {
            Navigator.pop(context);
          },
        );
      }
    } catch (e) {
      if (mounted) {
        _showDialog(l10n.error, e.toString(), context);
      }
    }
  }

  Future<void> _handleAvatarEdit() async {
    if (!_premiumViewModel.isPremium) {
      _showLimitOptions();
      return;
    }

    await _viewModel.pickAvatar();
  }

  void _showDialog(
    String title,
    String content,
    BuildContext context, {
    VoidCallback? onSuccess,
  }) {
    final l10n = AppLocalizations.of(context)!;

    AdaptiveAlertDialog.show(
      context: context,
      title: title,
      message: content,
      icon: 'info.circle.fill',
      actions: [
        AlertAction(
          title: l10n.ok,
          style: AlertActionStyle.primary,
          onPressed: () {
            if (onSuccess != null) {
              onSuccess();
            }
          },
        ),
      ],
    );
  }

  void _showLimitOptions() {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      builder: (context) => Container(
        padding: EdgeInsets.fromLTRB(24.w, 4.h, 24.w, 24.h),
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 40.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Icon(
              CupertinoIcons.person_crop_circle_fill_badge_plus,
              size: 50.sp,
              color: CupertinoTheme.of(context).primaryColor,
            ),
            SizedBox(height: 12.h),
            Text(
              l10n.edit_avatar,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              l10n.require_premium_to_edit_avatar,
              textAlign: TextAlign.center,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 14.sp,
                color: CupertinoColors.systemGrey,
              ),
            ),
            SizedBox(height: 24.h),
            CustomOptionWidget(
              context: context,
              icon: CupertinoIcons.play_circle_fill,
              label: l10n.watch_ad_continue,
              color: CupertinoTheme.of(context).primaryColor,
              onTap: () => {_handleRewardAdFlow()},
            ),
            SizedBox(height: 12.h),
            CustomOptionWidget(
              context: context,
              icon: CupertinoIcons.star_fill,
              label: l10n.upgrade_premium,
              color: const Color(0xFF9C2CF3),
              isGradient: true,
              onTap: () {
                Navigator.pop(context, false);
                _showPremiumModal(context);
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void _showPremiumModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      builder: (context) => const PremiumView(),
    );
  }

  void _handleRewardAdFlow() {
    Navigator.pop(context, false);
    _adsService.showRewardedAd(
      onRewardEarned: () async {
        await _viewModel.pickAvatar();
      },
      onAdFailed: () {
        if (mounted) {
          _showAdErrorDialog(context);
        }
      },
    );
  }

  void _showAdErrorDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    AdaptiveAlertDialog.show(
      context: context,
      title: l10n.error,
      message: l10n.ads_loading,
      icon: 'antennas.bubble.left.fill',
      actions: [
        AlertAction(
          title: "OK",
          style: AlertActionStyle.primary,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return LoadingOverlay(
          isLoading: _viewModel.isLoading,
          child: PopScope(
            canPop: !_viewModel.isLoading,
            child: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                backgroundColor: CupertinoTheme.of(
                  context,
                ).scaffoldBackgroundColor,
                border: null,
                leading: _viewModel.isLoading
                    ? const SizedBox.shrink()
                    : CupertinoNavigationBarBackButton(
                        color: CupertinoTheme.of(context).primaryColor,
                        onPressed: () => Navigator.pop(context),
                      ),
                middle: Text(
                  l10n.edit_profile,
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 18.sp),
                ),
              ),
              child: SafeArea(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 20.h,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight - 40.h,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              children: [
                                ProfileAvatar(
                                  imageFile: _viewModel.selectedAvatarFile,
                                  photoUrl: _viewModel.userModel?.photoUrl,
                                  onEditTap: _handleAvatarEdit,
                                ),
                  
                                SizedBox(height: 30.h),
                  
                                ProfileInfoItem(
                                  label: l10n.full_name,
                                  controller: _nameController,
                                ),
                  
                                SizedBox(height: 20.h),
                  
                                ProfileInfoItem(
                                  label: l10n.email_address,
                                  controller: _emailController,
                                  isReadOnly: true,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: 20.h),
                  
                                ProfileInfoItem(
                                  label: l10n.phone_number,
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                ),
                                SizedBox(height: 20.h),
                  
                                ProfileInfoItem(
                                  label: l10n.day_of_birth,
                                  textValue: DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(_selectedDob),
                                  icon: CupertinoIcons.calendar,
                                  onTap: () {
                                    DateHelper.showDatePicker(
                                      context,
                                      initialDate: _selectedDob,
                                      onDateChanged: (newDate) {
                                        setState(() => _selectedDob = newDate);
                                      },
                                    );
                                  },
                                ),
                  
                                const Spacer(),
                  
                                SizedBox(height: 40.h),
                  
                                CupertinoButton(
                                  onPressed: _handleSave,
                                  minimumSize: Size(double.infinity, 50.h),
                                  borderRadius: BorderRadius.circular(30.r),
                                  color: AppColors.primaryColor,
                                  child: Text(
                                    l10n.save_changes,
                                    style: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .copyWith(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFFFFFFF),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
