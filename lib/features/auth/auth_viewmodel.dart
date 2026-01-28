import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:spend_flow/core/services/auth_service.dart';
import 'package:spend_flow/features/auth/view/otp_view.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> registerWithEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    _setLoading(true);
    try {
      await _authService.registerWithEmail(email, password);
      if (!context.mounted) return;
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => OTPPage(email: email)),
      );
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    _setLoading(true);
    try {
      await _authService.verifyOtp(email, otp);
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> resendOtp(String email) async {
    _setLoading(true);
    try {
      await _authService.resendOtp(email);
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<UserCredential?> loginWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      return await _authService.loginWithCustomAuth(email, password);
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> sendForgotPasswordOtp(String email) async {
    _setLoading(true);
    try {
      await _authService.sendForgotPasswordOtp(email);
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
      final err = e.toString();
      if (err.contains('canceled') || err.contains('kSign')) {
        return null;
      }
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
}
