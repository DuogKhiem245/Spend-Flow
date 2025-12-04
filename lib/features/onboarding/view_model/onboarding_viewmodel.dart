import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/features/auth/view/login_view.dart';
import '../model/onboarding_model.dart';

class OnboardingViewModel {
  final PageController pageController = PageController();
  int currentPage = 0;

  List<OnboardingModel> getPages(AppLocalizations l10n) {
    return [
      OnboardingModel(
        image: "lib/assets/images/onboard-1.png",
        title: l10n.onboard_step1_title,
        desc: l10n.onboard_step1_message,
      ),
      OnboardingModel(
        image: "lib/assets/images/onboard-2.png",
        title: l10n.onboard_step2_title,
        desc: l10n.onboard_step2_message,
      ),
      OnboardingModel(
        image: "lib/assets/images/onboard-3.png",
        title: l10n.onboard_step3_title,
        desc: l10n.onboard_step3_message,
      ),
    ];
  }

  void onPageChanged(int index) {
    currentPage = index;
  }

  Future<void> next(BuildContext context, int totalPages) async {
    if (currentPage < totalPages - 1) {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      await _finishOnboarding(context);
    }
  }

  Future<void> skip(BuildContext context) async {
    await _finishOnboarding(context);
  }

  Future<void> _finishOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboard_done', true);

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  void dispose() {
    pageController.dispose();
  }
}
