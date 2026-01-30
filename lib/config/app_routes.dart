import 'package:flutter/cupertino.dart';
import 'package:spend_flow/core/navigation/root_check.dart';
import 'package:spend_flow/screen/auth/view/login_view.dart';
import 'package:spend_flow/screen/home/home_view.dart';
import 'package:spend_flow/screen/onboarding/view/onboarding_view.dart';
import 'package:spend_flow/screen/wallet/wallet_view.dart';

class AppRoutes {
  static const main = '/';
  static const onboarding = '/onboarding';
  static const wallet = '/wallet';
  static const home = '/home';
  static const login = '/login';

  static Map<String, WidgetBuilder> getRoutes({
    required bool onboardDone,
    required bool createFirstWallet,
  }) {
    return {
      main: (context) => RootChecker(
        onboardDone: onboardDone,
        createFirstWallet: createFirstWallet,
      ),
      onboarding: (context) => const OnboardingPage(),
      wallet: (context) => const WalletView(firstWallet: true),
      home: (context) => const HomePage(),
      login: (context) => const LoginPage(),
    };
  }
}
