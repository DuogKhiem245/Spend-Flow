import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' hide Size;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_theme.dart';
import 'package:spend_flow/core/services/ads_service.dart';
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
final fontViewModel = FontViewModel();
late PremiumViewModel premiumViewModel;

Future<void> initATTAndAds() async {
  try {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  } catch (e) {
    debugPrint("🚨 Lỗi khi xin quyền ATT: $e");
  } finally {
    await MobileAds.instance.initialize();
    AdsService().loadAllRewardedAds();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    dotenv.load(fileName: ".env"),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
  ]);

  final storage = LocalStorageService();
  late SharedPreferences prefs;

  await Future.wait([
    storage.initializeData(),
    fontViewModel.init(),
    SharedPreferences.getInstance().then((value) => prefs = value),
  ]);

  final bool onboardDone = prefs.getBool('onboard_done') ?? false;
  final bool createFirstWallet = prefs.getBool('create_first_wallet') ?? false;

  User? user = FirebaseAuth.instance.currentUser;
  premiumViewModel = PremiumViewModel(user?.uid ?? "");

  if (user != null) {
    user
        .reload()
        .then((_) {
          final updatedUser = FirebaseAuth.instance.currentUser;
          if (updatedUser != null && !updatedUser.emailVerified) {
            FirebaseAuth.instance.signOut();
          }
        })
        .catchError((_) {
          FirebaseAuth.instance.signOut();
        });
  }

  NotificationService().init();

  String publicToken = dotenv.env['MAPBOX_PUBLIC_TOKEN'] ?? '';
  MapboxOptions.setAccessToken(publicToken);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MyApp(onboardDone: onboardDone, createFirstWallet: createFirstWallet),
    );
  });
}

class MyApp extends StatefulWidget {
  final bool onboardDone;
  final bool createFirstWallet;

  const MyApp({
    super.key,
    required this.onboardDone,
    required this.createFirstWallet,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initATTAndAds();
    });
  }

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
              supportedLocales: [const Locale('en'), const Locale('vi')],
              initialRoute: AppRoutes.main,
              routes: AppRoutes.getRoutes(
                onboardDone: widget.onboardDone,
                createFirstWallet: widget.createFirstWallet,
              ),
            );
          },
        );
      },
    );
  }
}
