import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/model/user_model.dart';
import 'package:spend_flow/core/services/auth_service.dart';
import 'package:spend_flow/core/services/data_service/firestore_service.dart';
import 'package:spend_flow/main.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  final _premiumViewModel = premiumViewModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String cleanErrorMessage(dynamic e) {
    if (e is FirebaseFunctionsException) {
      return e.message ?? e.code;
    }
    return e.toString();
  }

  Future<void> registerWithEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    FocusScope.of(context).unfocus();
    if (_isLoading) return;
    _setLoading(true);
    try {
      await _authService.registerWithEmail(email, password);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> verifyOtp(BuildContext context, String email, String otp) async {
    FocusScope.of(context).unfocus();
    if (_isLoading) return;
    _setLoading(true);
    try {
      await _authService.verifyOtp(email, otp);
      if (!context.mounted) return;
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> resendOtp(String email, BuildContext context) async {
    FocusScope.of(context).unfocus();
    _setLoading(true);
    if (!context.mounted) return;
    final l10n = AppLocalizations.of(context)!;
    try {
      await _authService.resendOtp(email);
      if (!context.mounted) return;
      AdaptiveAlertDialog.show(
        context: context,
        title: "${l10n.resend} OTP",
        message: l10n.otp_resent,
        icon: 'antennas.bubble.left.fill',
        actions: [
          AlertAction(
            title: "OK",
            style: AlertActionStyle.primary,
            onPressed: () {},
          ),
        ],
      );
    } catch (e) {
      AdaptiveAlertDialog.show(
        context: context,
        title: l10n.error,
        message: cleanErrorMessage(e),
        icon: 'exclamationmark.triangle.fill',
        actions: [
          AlertAction(
            title: "OK",
            style: AlertActionStyle.primary,
            onPressed: () {},
          ),
        ],
      );
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<UserCredential?> loginWithEmail(
    String email,
    String password,
    BuildContext context,
  ) async {
    FocusScope.of(context).unfocus();
    _setLoading(true);
    try {
      UserCredential userCredential = await _authService.loginWithCustomAuth(
        email,
        password,
      );
      if (userCredential.user != null) {
        final updatedUser = UserModel(
          uid: _authService.currentUser!.uid,
          email: email,
          displayName: _authService.currentUser!.displayName ?? "",
        );

        await _firestoreService.saveUser(updatedUser);
      }

      await _premiumViewModel.handleLogin(_authService.currentUser!.uid);

      return userCredential;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> sendForgotPasswordOtp(String email, BuildContext context) async {
    FocusScope.of(context).unfocus();
    _setLoading(true);
    try {
      await _authService.sendForgotPasswordOtp(email);
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> resendForgotPasswordOtp(
    String email,
    BuildContext context,
  ) async {
    FocusScope.of(context).unfocus();
    _setLoading(true);
    final l10n = AppLocalizations.of(context)!;
    try {
      await _authService.sendForgotPasswordOtp(email);
      if (!context.mounted) return;
      AdaptiveAlertDialog.show(
        context: context,
        title: "${l10n.resend} OTP",
        message: l10n.otp_resent,
        icon: 'antennas.bubble.left.fill',
        actions: [
          AlertAction(
            title: "OK",
            style: AlertActionStyle.primary,
            onPressed: () {},
          ),
        ],
      );
    } catch (e) {
      AdaptiveAlertDialog.show(
        context: context,
        title: l10n.error,
        message: cleanErrorMessage(e),
        icon: 'exclamationmark.triangle.fill',
        actions: [
          AlertAction(
            title: "OK",
            style: AlertActionStyle.primary,
            onPressed: () {},
          ),
        ],
      );
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> resetPassword(
    String email,
    String otp,
    String newPassword,
    BuildContext context,
  ) async {
    FocusScope.of(context).unfocus();
    _setLoading(true);
    try {
      await _authService.resetPassword(email, otp, newPassword);
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<UserCredential?> loginWithSocial(
    Future<UserCredential?> Function() method,
  ) async {
    _setLoading(true);
    try {
      return await method();
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<UserCredential?> signInWithGoogle() =>
      loginWithSocial(() => _authService.signInWithGoogle());

  Future<UserCredential?> signInWithApple() =>
      loginWithSocial(() => _authService.signInWithApple());

  Future<void> signOut() async {
    await _authService.signOut();
  }

  // Future<void> updateSignInMethod(
  //   String method,
  // ) async {
  //   final userId = _authService.currentUser?.uid;
  //   if (userId == null) {
  //     return;
  //   }
  //   try {
  //     await FirebaseFirestore.instance.collection('info_users').doc(userId).set({
  //       'lastSignInMethod': method,
  //       'lastLogin': FieldValue.serverTimestamp(),
  //     }, SetOptions(merge: true));
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
