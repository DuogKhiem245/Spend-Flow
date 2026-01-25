import 'package:cupertino_native/components/switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/features/premium/premium_view.dart';
import 'package:spend_flow/features/setting/security/security_view.dart';
import 'package:spend_flow/features/setting/setting_viewmodel.dart';
import 'package:spend_flow/features/setting/widget/setting_item_widget.dart';

class SettingSecurityWidget extends StatefulWidget {
  const SettingSecurityWidget({super.key});

  @override
  State<SettingSecurityWidget> createState() => _SettingSecurityWidgetState();
}

class _SettingSecurityWidgetState extends State<SettingSecurityWidget> {
  final SettingViewModel _viewModel = SettingViewModel();

  void _showPremiumModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      builder: (context) => const PremiumView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: Text(
            l10n.privacy_and_security,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color?.withValues(alpha: .6),
            ),
          ),
        ),

        SettingItem(
          title: l10n.location,
          icon: CupertinoIcons.location_north_fill,
          iconBgColor: const Color.fromARGB(255, 255, 78, 78),
          trailing: ListenableBuilder(
            listenable: _viewModel,
            builder: (context, child) {
              return CNSwitch(
                value: _viewModel.isLocationEnabled,
                onChanged: (v) => _viewModel.toggleLocation(v, context),
              );
            },
          ),
        ),

        FutureBuilder<String>(
          future: _viewModel.checkBiometricSupport(l10n),
          builder: (context, snapshot) {
            final String bioType = snapshot.data ?? "";
            final String title = bioType.isEmpty
                ? "Passcode"
                : "Passcode & $bioType";

            return SettingItem(
              title: title,
              icon: CupertinoIcons.lock_fill,
              iconBgColor: const Color(0xFF71717A),
              onTap: () async {
                final bool isPremium = await LocalStorageService()
                    .getPremiumStatus();
                if (!context.mounted) return;
                if (isPremium) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const SecurityView(),
                    ),
                  );
                } else {
                  _showPremiumModal(context);
                }
              },
              trailing: Icon(
                CupertinoIcons.chevron_right,
                size: 18.sp,
                color: CupertinoColors.systemGrey3,
              ),
            );
          },
        ),
      ],
    );
  }
}
