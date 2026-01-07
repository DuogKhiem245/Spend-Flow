import 'package:flutter/cupertino.dart';
import 'package:spend_flow/core/widgets/nav.dart';
import 'package:spend_flow/features/auth/view/login_view.dart';
import 'package:spend_flow/features/onboarding/view/onboarding_view.dart';
import 'package:spend_flow/features/wallet/wallet_view.dart';

class AppRoutes {
  static const main = '/';
  static const onboarding = '/onboarding';
  static const wallet = '/wallet';

  // Auth screens
  static const login = '/login';
  static const registerStep1 = '/register-step-1';
  static const registerStep2 = '/register-step-2';
  static const forgotPassword = '/forgot-password';
  static const profile = '/profile';

  // Screen of main app
  static const home = '/home';
  static const reports = '/reports';
  static const budgets = '/budgets';
  static const settings = '/settings';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      onboarding: (context) => const OnboardingPage(),
      wallet: (context) => const WalletView(),
      main: (context) => const BottomNavbar(),
      login: (context) => const LoginPage(),
      // register: (context) => const RegisterPage(),
      // forgotPassword: (context) => const ForgotPasswordPage(),
      // profile: (context) => const ProfilePage(),
    };
  }
}
