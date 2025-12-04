import 'package:flutter/cupertino.dart';
import 'app_colors.dart';

class AppCupertinoTheme {
  static const light = CupertinoThemeData(
    brightness: Brightness.light,

    primaryColor: AppColors.lightButton,
    scaffoldBackgroundColor: AppColors.lightBackground,
    barBackgroundColor: AppColors.lightCard,

    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(color: AppColors.lightText),
      primaryColor: AppColors.lightText, 
    ),
  );

  static const dark = CupertinoThemeData(
    brightness: Brightness.dark,

    primaryColor: AppColors.darkButton,
    scaffoldBackgroundColor: AppColors.darkBackground,
    barBackgroundColor: AppColors.darkCard,

    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(color: AppColors.darkText),
      primaryColor: AppColors.darkText,
    ),
  );

  static CupertinoThemeData getTheme(Brightness brightness) {
    return brightness == Brightness.dark ? dark : light;
  }
}
