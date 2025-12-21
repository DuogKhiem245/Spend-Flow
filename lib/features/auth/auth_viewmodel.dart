import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:spend_flow/core/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<User?> loginWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      final credential = await _authService.signInWithEmail(
        email: email,
        password: password,
      );

      return credential?.user;
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<UserCredential?> loginWithSocial(
    Future<UserCredential?> Function() method,
  ) async {
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
