import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_theme.dart';
import 'package:spend_flow/core/services/language_service.dart';
import 'package:spend_flow/core/services/theme_service.dart';
import 'config/app_routes.dart';

final languageService = LanguageService();
final themeService = ThemeService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool onboardDone = prefs.getBool('onboard_done') ?? false;

  runApp(MyApp(onboardDone: onboardDone));
}

class MyApp extends StatelessWidget {
  final bool onboardDone;

  const MyApp({super.key, required this.onboardDone});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ListenableBuilder(
          listenable: Listenable.merge([themeService, languageService]),
          builder: (context, child) {
            return CupertinoApp(
            title: 'Spend Flow',
            debugShowCheckedModeBanner: false,
            theme: AppCupertinoTheme.light,
            builder: (context, child) {
            final brightness = MediaQuery.of(context).platformBrightness;
            return CupertinoTheme(
              data: AppCupertinoTheme.getTheme(brightness),
              child: child!,
            );
          },
          locale: LanguageService().locale, 
          localizationsDelegates: const [
            AppLocalizations.delegate, 
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'), 
            Locale('vi'), 
          ],
          initialRoute: onboardDone ? AppRoutes.login : AppRoutes.onboarding,
          routes: AppRoutes.getRoutes(),
        );
      },
    );
  });
}
}