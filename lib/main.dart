import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foldable/foldable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' hide Size;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/assets/languages/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/config/app_theme.dart';
import 'package:spend_flow/core/services/ads_service.dart';
import 'package:spend_flow/core/services/general_service/language_service.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/core/services/general_service/notification_service.dart';
import 'package:spend_flow/core/services/general_service/theme_service.dart';
import 'package:spend_flow/screen/premium/premium_viewmodel.dart';
import 'package:spend_flow/screen/setting/font/font_viewmodel.dart';
import 'package:spend_flow/firebase_options.dart';
import 'package:home_widget/home_widget.dart';
import 'package:spend_flow/core/services/widget_sync_service.dart';
import 'package:spend_flow/screen/voice_input/voice_input_view.dart';
import 'config/app_routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
    // await MobileAds.instance.initialize();
    AdsService().loadAllRewardedAds();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    dotenv.load(fileName: ".env"),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    MobileAds.instance.initialize(),
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
      _initHomeWidget();
    });
  }

  Future<void> _initHomeWidget() async {
    await WidgetSyncService().init();
    await WidgetSyncService().updateAllWidgets();

    HomeWidget.widgetClicked.listen((Uri? uri) {
      _handleWidgetUri(uri);
    });

    final initialUri = await HomeWidget.initiallyLaunchedFromHomeWidget();
    if (initialUri != null) {
      _handleWidgetUri(initialUri);
    }
  }

  void _handleWidgetUri(Uri? uri) {
    if (uri == null) return;
    if (uri.scheme == 'spendflow' &&
        (uri.host == 'voice_input' || uri.path.contains('voice_input'))) {
      navigatorKey.currentState?.push(
        CupertinoPageRoute(
          builder: (_) => const VoiceInputView(isFromWidget: true),
        ),
      );
    }
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

            final cupertinoLightTheme = AppCupertinoTheme.light.copyWith(
              textTheme: CupertinoTextThemeData(
                textStyle: AppCupertinoTheme.light.textTheme.textStyle.copyWith(
                  fontFamily: dynamicFont.fontFamily,
                ),
                navTitleTextStyle: AppCupertinoTheme
                    .light
                    .textTheme
                    .navTitleTextStyle
                    .copyWith(fontFamily: dynamicFont.fontFamily),
                navActionTextStyle: AppCupertinoTheme
                    .light
                    .textTheme
                    .navActionTextStyle
                    .copyWith(fontFamily: dynamicFont.fontFamily),
              ),
            );

            final cupertinoDarkTheme = AppCupertinoTheme.dark.copyWith(
              textTheme: CupertinoTextThemeData(
                textStyle: AppCupertinoTheme.dark.textTheme.textStyle.copyWith(
                  fontFamily: dynamicFont.fontFamily,
                ),
                navTitleTextStyle: AppCupertinoTheme
                    .dark
                    .textTheme
                    .navTitleTextStyle
                    .copyWith(fontFamily: dynamicFont.fontFamily),
                navActionTextStyle: AppCupertinoTheme
                    .dark
                    .textTheme
                    .navActionTextStyle
                    .copyWith(fontFamily: dynamicFont.fontFamily),
              ),
            );

            final materialLightTheme = ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
              brightness: Brightness.light,
              fontFamily: dynamicFont.fontFamily,
            );

            final materialDarkTheme = ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
              brightness: Brightness.dark,
              fontFamily: dynamicFont.fontFamily,
            );

            return FoldableProvider(
              child: AdaptiveApp(
                navigatorKey: navigatorKey,
                title: 'Spend Flow',
                themeMode: themeService.themeMode,
                cupertinoLightTheme: cupertinoLightTheme,
                cupertinoDarkTheme: cupertinoDarkTheme,
                materialLightTheme: materialLightTheme,
                materialDarkTheme: materialDarkTheme,
                cupertino: (context, platform) =>
                    const CupertinoAppData(debugShowCheckedModeBanner: false),
                material: (context, platform) =>
                    const MaterialAppData(debugShowCheckedModeBanner: false),
                locale: languageService.locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                initialRoute: AppRoutes.main,
                routes: AppRoutes.getRoutes(
                  onboardDone: widget.onboardDone,
                  createFirstWallet: widget.createFirstWallet,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
