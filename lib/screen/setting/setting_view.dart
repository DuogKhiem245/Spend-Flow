import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/auth_service.dart';
import 'package:spend_flow/core/services/sync_service/sync_service.dart';
import 'package:spend_flow/core/widgets/loading_overlay.dart';
import 'package:spend_flow/screen/setting/notification/notification_viewmodel.dart';
import 'package:spend_flow/screen/setting/setting_viewmodel.dart';
import 'package:spend_flow/screen/setting/widget/account_widget.dart';
import 'package:spend_flow/screen/setting/widget/setting_data_widget.dart';
import 'package:spend_flow/screen/setting/widget/setting_general_widget.dart';
import 'package:spend_flow/screen/setting/widget/setting_info_widget.dart';
import 'package:spend_flow/screen/setting/widget/setting_security_widget.dart';
import 'package:spend_flow/screen/setting/widget/upgrade_premium_widget.dart';
import 'package:spend_flow/main.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with WidgetsBindingObserver {
  final _premiumViewModel = premiumViewModel;
  bool _isDeleting = false;

  final authService = AuthService();
  String _lastSyncText = "";

  @override
  void initState() {
    super.initState();
    _loadLastSyncTime();
    SettingViewModel().initLocationState(context);
    NotificationViewModel().init(context);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      SettingViewModel().initLocationState(context);
      NotificationViewModel().init(context);
    }
  }

  Future<void> _loadLastSyncTime() async {
    final lastTime = await SyncService().getLastSyncTime();

    if (!mounted) return;

    setState(() {
      if (lastTime != null) {
        final formatter = DateFormat('HH:mm dd/MM/yyyy');
        _lastSyncText = formatter.format(lastTime);
      } else {
        _lastSyncText = AppLocalizations.of(context)!.never_synced;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final maxWidth = MediaQuery.of(context).size.width;

    debugPrint("Building SettingPage with maxWidth: $maxWidth");

    return CupertinoPageScaffold(
      child: LoadingOverlay(
        isLoading: _isDeleting,
        child: StreamBuilder<User?>(
          stream: authService.userChanges,
          builder: (context, snapshot) {
            final user = snapshot.data;
            final bool isLoading =
                snapshot.connectionState == ConnectionState.waiting;
            final bool isLoggedIn = !isLoading && user != null;

            return Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10.h,
                left: 16.w,
                right: 16.w,
                bottom: 10.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AccountWidget(currentUser: user, isLoading: isLoading),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Column(
                        children: [
                          ListenableBuilder(
                            listenable: _premiumViewModel,
                            builder: (context, child) {
                              return AnimatedSize(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder:
                                      (
                                        Widget child,
                                        Animation<double> animation,
                                      ) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: SizeTransition(
                                            sizeFactor: animation,
                                            axisAlignment: -1.0,
                                            child: child,
                                          ),
                                        );
                                      },
                                  child: _premiumViewModel.isPremium
                                      ? const SizedBox.shrink()
                                      : KeyedSubtree(
                                          key: const ValueKey('upgrade_widget'),
                                          child: Column(
                                            children: [
                                              const UpgradePremiumWidget(),
                                              SizedBox(height: 20.h),
                                            ],
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),

                          const SettingGeneralWidget(),
                          SizedBox(height: 10.h),

                          const SettingSecurityWidget(),
                          SizedBox(height: 10.h),

                          SettingDataWidget(
                            lastSyncText: _lastSyncText,
                            onSyncSuccess: _loadLastSyncTime,
                          ),
                          SizedBox(height: 10.h),

                          const SettingInfoWidget(),

                          isLoggedIn
                              ? Column(
                                  children: [
                                    CupertinoButton(
                                      onPressed: () =>
                                          _showLogoutDialog(context),
                                      borderRadius: BorderRadius.circular(30.r),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8.h,
                                      ),
                                      minimumSize: Size(double.infinity, 54.h),
                                      color: CupertinoTheme.of(
                                        context,
                                      ).barBackgroundColor,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            CupertinoIcons.square_arrow_right,
                                            color: CupertinoColors.systemRed,
                                            size: 20.r,
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            l10n.logout,
                                            style: CupertinoTheme.of(context)
                                                .textTheme
                                                .textStyle
                                                .copyWith(
                                                  color:
                                                      CupertinoColors.systemRed,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20.h),

                                    CupertinoButton(
                                      onPressed: () =>
                                          _showDeleteAccountDialog(context),
                                      borderRadius: BorderRadius.circular(30.r),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8.h,
                                      ),
                                      minimumSize: Size(double.infinity, 54.h),
                                      color: CupertinoColors.systemRed
                                          .withValues(alpha: 0.1),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            CupertinoIcons.trash,
                                            color: CupertinoColors.systemRed,
                                            size: 20.r,
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            l10n.delete_account,
                                            style: CupertinoTheme.of(context)
                                                .textTheme
                                                .textStyle
                                                .copyWith(
                                                  color:
                                                      CupertinoColors.systemRed,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (maxWidth < 450)
                                      SizedBox(height: 120.h)
                                    else
                                      SizedBox(height: 180.h),
                                  ],
                                )
                              : SizedBox(height: 80.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    AdaptiveAlertDialog.show(
      context: context,
      title: l10n.logout,
      message: l10n.are_you_sure_logout,
      icon: 'rectangle.portrait.and.arrow.right.fill',
      actions: [
        AlertAction(
          title: l10n.cancel,
          style: AlertActionStyle.cancel,
          onPressed: () => {},
        ),
        AlertAction(
          title: l10n.logout,
          style: AlertActionStyle.destructive,
          onPressed: () async {
            await authService.signOut();
            await premiumViewModel.handleLogout();
          },
        ),
      ],
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    AdaptiveAlertDialog.show(
      context: context,
      title: l10n.delete_account,
      message: l10n.delete_account_confirmation,
      icon: 'trash.fill',
      actions: [
        AlertAction(
          title: l10n.cancel,
          style: AlertActionStyle.cancel,
          onPressed: () => {},
        ),
        AlertAction(
          title: l10n.delete_account,
          style: AlertActionStyle.destructive,
          onPressed: () async {
            setState(() => _isDeleting = true);
            try {
              await authService.deleteAccount(l10n);
              await premiumViewModel.handleLogout();
            } catch (e) {
              if (!context.mounted) return;
              AdaptiveAlertDialog.show(
                context: context,
                title: l10n.error,
                message: e.toString(),
                icon: 'exclamationmark.triangle.fill',
                actions: [
                  AlertAction(
                    title: "OK",
                    style: AlertActionStyle.primary,
                    onPressed: () {},
                  ),
                ],
              );
            } finally {
              if (mounted) {
                setState(() => _isDeleting = false);
              }
            }
          },
        ),
      ],
    );
  }
}
