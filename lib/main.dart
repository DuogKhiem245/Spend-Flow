import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' hide Size;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_theme.dart';
import 'package:spend_flow/core/services/general_service/language_service.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/core/services/general_service/notification_service.dart';
import 'package:spend_flow/core/services/general_service/theme_service.dart';
import 'package:spend_flow/screen/premium/premium_viewmodel.dart';
import 'package:spend_flow/screen/setting/font/font_viewmodel.dart';
import 'package:spend_flow/firebase_options.dart';
import 'config/app_routes.dart';

final languageService = LanguageService();
final themeService = ThemeService();
final premiumViewModel = PremiumViewModel();
final fontViewModel = FontViewModel();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.instance.initialize();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final storage = LocalStorageService();
  await storage.initializeData();

  await fontViewModel.init();

  final prefs = await SharedPreferences.getInstance();
  final bool onboardDone = prefs.getBool('onboard_done') ?? false;
  final bool createFirstWallet = prefs.getBool('create_first_wallet') ?? false;

  User? user = FirebaseAuth.instance.currentUser;
  try {
    await user?.reload();
    user = FirebaseAuth.instance.currentUser;

    if (user != null && user.emailVerified) {
    } else {
      await FirebaseAuth.instance.signOut();
    }
  } catch (e) {
    await FirebaseAuth.instance.signOut();
  }

  await NotificationService().init();

  await dotenv.load(fileName: ".env");

  String publicToken = dotenv.env['MAPBOX_PUBLIC_TOKEN'] ?? '';

  MapboxOptions.setAccessToken(publicToken);

  runApp(MyApp(onboardDone: onboardDone, createFirstWallet: createFirstWallet));
}

class MyApp extends StatelessWidget {
  final bool onboardDone;
  final bool createFirstWallet;

  const MyApp({
    super.key,
    required this.onboardDone,
    required this.createFirstWallet,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ListenableBuilder(
          listenable: Listenable.merge([
            themeService,
            languageService,
            premiumViewModel,
            fontViewModel,
          ]),
          builder: (context, child) {
            final TextStyle dynamicFont = GoogleFonts.getFont(
              fontViewModel.currentFont,
            );

            return CupertinoApp(
              title: 'Spend Flow',
              debugShowCheckedModeBanner: false,
              theme: AppCupertinoTheme.light,
              builder: (context, child) {
                bool isDark;
                switch (themeService.themeMode) {
                  case ThemeMode.dark:
                    isDark = true;
                    break;
                  case ThemeMode.light:
                    isDark = false;
                    break;
                  case ThemeMode.system:
                    isDark =
                        MediaQuery.of(context).platformBrightness ==
                        Brightness.dark;
                    break;
                }

                return TweenAnimationBuilder<double>(
                  tween: Tween<double>(end: isDark ? 1.0 : 0.0),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, t, _) {
                    final baseTheme = t < 0.5
                        ? AppCupertinoTheme.light
                        : AppCupertinoTheme.dark;

                    final finalTheme = baseTheme.copyWith(
                      textTheme: CupertinoTextThemeData(
                        textStyle: baseTheme.textTheme.textStyle.copyWith(
                          fontFamily: dynamicFont.fontFamily,
                        ),
                        navTitleTextStyle: baseTheme.textTheme.navTitleTextStyle
                            .copyWith(fontFamily: dynamicFont.fontFamily),
                        navActionTextStyle: baseTheme
                            .textTheme
                            .navActionTextStyle
                            .copyWith(fontFamily: dynamicFont.fontFamily),
                      ),
                    );

                    return CupertinoTheme(data: finalTheme, child: child!);
                  },
                );
              },
              locale: languageService.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [Locale('en'), Locale('vi')],
              initialRoute: AppRoutes.main,
              routes: AppRoutes.getRoutes(
                onboardDone: onboardDone,
                createFirstWallet: createFirstWallet,
              ),
            );
          },
        );
      },
    );
  }
}
