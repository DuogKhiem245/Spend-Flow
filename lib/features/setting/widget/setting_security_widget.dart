import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: Text(
            l10n.security,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color?.withValues(alpha: .6),
            ),
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
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const SecurityView(),
                  ),
                );
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
