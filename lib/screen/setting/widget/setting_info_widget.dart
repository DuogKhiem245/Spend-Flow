import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/screen/setting/contact/contact_view.dart';
import 'package:spend_flow/screen/setting/markdown/markdown_doc_screen.dart';
import 'package:spend_flow/screen/setting/widget/setting_item_widget.dart';

class SettingInfoWidget extends StatefulWidget {
  const SettingInfoWidget({super.key});

  @override
  State<SettingInfoWidget> createState() => _SettingInfoWidgetState();
}

class _SettingInfoWidgetState extends State<SettingInfoWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: Text(
            l10n.information_and_support,
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
          title: l10n.contact_support,
          icon: CupertinoIcons.headphones,
          iconBgColor: const Color(0xFF007AFF),
          trailing: Icon(
            CupertinoIcons.chevron_right,
            size: 18.sp,
            color: CupertinoColors.systemGrey3,
          ),
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const ContactView(),
            ),
          )
        ),

        SettingItem(
          title: l10n.terms_of_service,
          icon: CupertinoIcons.doc_text_fill,
          iconBgColor: const Color.fromARGB(255, 0, 124, 140),
          trailing: Icon(
            CupertinoIcons.chevron_right,
            size: 18.sp,
            color: CupertinoColors.systemGrey3,
          ),
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => MarkdownDocScreen(
                title: l10n.terms_of_service,
                filename: 'terms.md',
              ),
            ),
          ),
        ),

        SettingItem(
          title: l10n.privacy_policy,
          icon: CupertinoIcons.lock_shield_fill,
          iconBgColor: const Color(0xFF34C759),
          trailing: Icon(
            CupertinoIcons.chevron_right,
            size: 18.sp,
            color: CupertinoColors.systemGrey3,
          ),
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => MarkdownDocScreen(
                title: l10n.privacy_policy,
                filename: 'policy.md',
              ),
            ),
          ),
        ),

        SizedBox(height: 30.h),
      ],
    );
  }
}
