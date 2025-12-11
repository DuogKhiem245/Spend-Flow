import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/features/setting/security/security_view.dart';

class SettingSecurityWidget extends StatefulWidget {
  const SettingSecurityWidget({super.key});

  @override
  State<SettingSecurityWidget> createState() => _SettingSecurityWidgetState();
}

class _SettingSecurityWidgetState extends State<SettingSecurityWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.security,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: CupertinoTheme.of(
              context,
            ).textTheme.textStyle.color?.withValues(alpha: .7),
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).barBackgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const SecurityView()),
              ),
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(113, 113, 122, 1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          CupertinoIcons.lock,
                          size: 22.r,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Passcode & Face ID",
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 22.r,
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                ],
              ),
            ),
          ),
          
        ),
      ],
    );
  }
}
