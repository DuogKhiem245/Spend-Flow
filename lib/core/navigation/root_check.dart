import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:spend_flow/core/widgets/nav.dart';
import 'package:spend_flow/features/onboarding/view/onboarding_view.dart';
import 'package:spend_flow/features/wallet/wallet_view.dart';

class RootChecker extends StatelessWidget {
  final bool onboardDone;
  final bool createFirstWallet;

  const RootChecker({
    super.key,
    required this.onboardDone,
    required this.createFirstWallet,
  });

  @override
  Widget build(BuildContext context) {
    if (!onboardDone) {
      return const OnboardingPage();
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.emailVerified) {
      return createFirstWallet
          ? const BottomNavbar()
          : const WalletView(firstWallet: true);
    }

    return createFirstWallet
        ? const BottomNavbar()
        : const WalletView(firstWallet: true);
  }
}
