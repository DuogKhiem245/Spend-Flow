import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';

class PasswordStrength extends StatelessWidget {
  final String password;

  const PasswordStrength({super.key, required this.password});

  static Map<String, dynamic> analyzePassword(String pass) {
    int score = 0;

    if (pass.isEmpty) {
      return {
        'score': 0,
        'hasMinLength': false,
        'hasDigit': false,
        'hasSpecial': false,
      };
    }

    score += 1;

    bool hasMinLength = pass.length >= 8;
    if (hasMinLength) score += 1;

    bool hasDigit = RegExp(r'[0-9]').hasMatch(pass);
    if (hasDigit) score += 1;

    bool hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pass);
    if (hasSpecial) score += 1;

    if (score > 4) score = 4;

    return {
      'score': score,
      'hasMinLength': hasMinLength,
      'hasDigit': hasDigit,
      'hasSpecial': hasSpecial,
    };
  }

  static bool isValid(String pass) {
    final result = analyzePassword(pass);
    return (result['score'] as int) >= 3;
  }

  @override
  Widget build(BuildContext context) {
    final checkResult = analyzePassword(password);
    final int score = checkResult['score'] as int;

    final bool hasMinLength = checkResult['hasMinLength'] as bool;
    final bool hasDigit = checkResult['hasDigit'] as bool;
    final bool hasSpecial = checkResult['hasSpecial'] as bool;

    final Color statusColor = _getColor(score);
    final String label = _getLabel(context, score);

    final String description = _getDescription(
      context,
      score,
      hasMinLength,
      hasDigit,
      hasSpecial,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: List.generate(4, (index) {
                  final bool isActive = index < score;
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: index == 3 ? 0 : 8.w),
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: isActive
                            ? statusColor
                            : CupertinoColors.systemGrey5,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              label,
              textAlign: TextAlign.center,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                color: statusColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Text(
          description,
          textAlign: TextAlign.center,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            color: statusColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Color _getColor(int score) {
    switch (score) {
      case 0:
        return CupertinoColors.systemGrey;
      case 1:
        return CupertinoColors.systemRed;
      case 2:
        return CupertinoColors.systemOrange;
      case 3:
        return CupertinoColors.systemBlue;
      case 4:
        return CupertinoColors.systemGreen;
      default:
        return CupertinoColors.systemGrey;
    }
  }

  String _getLabel(BuildContext context, int score) {
    final l10n = AppLocalizations.of(context)!;
    switch (score) {
      case 1:
        return l10n.label_weak;
      case 2:
        return l10n.label_fair;
      case 3:
        return l10n.label_good;
      case 4:
        return l10n.label_strong;
      default:
        return "";
    }
  }

  String _getDescription(
    BuildContext context,
    int score,
    bool hasMinLength,
    bool hasDigit,
    bool hasSpecial,
  ) {
    final l10n = AppLocalizations.of(context)!;

    if (score == 0) return l10n.low_pass;

    if (score == 4) return l10n.strong_pass;

    if (!hasMinLength) {
      if (hasDigit && hasSpecial) {
        return l10n.good_pass_special;
      }
      return l10n.low_pass;
    }

    if (!hasDigit) {
      return l10n.good_pass_num;
    }

    if (!hasSpecial) {
      return l10n.good_pass_char;
    }

    if (score == 1) {
      return l10n.weak_pass;
    }

    return l10n.fair_pass;
  }
}
