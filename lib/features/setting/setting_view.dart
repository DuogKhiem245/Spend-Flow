import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/auth_service.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/services/sync_service/sync_service.dart';
import 'package:spend_flow/features/setting/notification/notification_viewmodel.dart';
import 'package:spend_flow/features/setting/setting_viewmodel.dart';
import 'package:spend_flow/features/setting/widget/account_widget.dart';
import 'package:spend_flow/features/setting/widget/setting_data_widget.dart';
import 'package:spend_flow/features/setting/widget/setting_general_widget.dart';
import 'package:spend_flow/features/setting/widget/setting_security_widget.dart';
import 'package:spend_flow/features/setting/widget/upgrade_premium_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with WidgetsBindingObserver {
  final authService = AuthService();
  String _lastSyncText = "";

  @override
  void initState() {
    super.initState();
    _loadLastSyncTime();
    SettingViewModel().initLocationState();
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
      SettingViewModel().initLocationState();
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

    return CupertinoPageScaffold(
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
                        FutureBuilder<bool>(
                          future: LocalStorageService().getPremiumStatus(),
                          builder: (context, snapshot) {
                            final isPremium = snapshot.data ?? false;
          
                            if (isPremium) {
                              return const SizedBox.shrink();
                            }
          
                            return Column(
                              children: [
                                const UpgradePremiumWidget(),
                                SizedBox(height: 20.h),
                              ],
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
                        SizedBox(height: 40.h),
          
                        isLoggedIn
                            ? CupertinoButton(
                                onPressed: () => _showLogoutDialog(context),
                                borderRadius: BorderRadius.circular(30.r),
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                ),
                                minimumSize: Size(double.infinity, 60.h),
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
                                      style: TextStyle(
                                        color: CupertinoColors.systemRed,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                        SizedBox(height: 80.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.are_you_sure_logout),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(l10n.cancel),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text(l10n.logout),
            onPressed: () async {
              Navigator.pop(ctx);
              await authService.signOut();
            },
          ),
        ],
      ),
    );
  }
}
