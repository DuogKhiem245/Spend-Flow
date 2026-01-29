import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:spend_flow/core/services/general_service/language_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFunctions _functions = FirebaseFunctions.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final LanguageService _languageService = LanguageService();

  User? get currentUser => _auth.currentUser;
  Stream<User?> get userChanges => _auth.userChanges();

  String _getLanguageCode() {
    return _languageService.currentLanguageCode;
  }

  Future<void> registerWithEmail(String email, String password) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('registerUser');
      final result = await callable.call({
        'email': email,
        'password': password,
        'lang': _getLanguageCode(),
      });

      if (result.data['success'] != true) {
        throw result.data['message'];
      }
    } on FirebaseFunctionsException catch (e) {
      throw e.message ?? "Đăng ký thất bại";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable(
        'verifyOtpRegister',
      );
      final result = await callable.call({
        'email': email,
        'otp': otp,
        'lang': _getLanguageCode(),
      });

      if (result.data['success'] != true) {
        throw result.data['message'];
      }
    } on FirebaseFunctionsException catch (e) {
      throw e.message ?? "Lỗi xác thực OTP";
    }
  }

  Future<void> resendOtp(String email) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable(
        'resendOtpRegister',
      );
      final result = await callable.call({
        'email': email,
        'lang': _getLanguageCode(),
      });

      if (result.data['success'] != true) {
        throw result.data['message'];
      }
    } on FirebaseFunctionsException catch (e) {
      throw e.message ?? "Lỗi gửi lại mã";
    }
  }

  Future<void> sendForgotPasswordOtp(String email) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('forgotPassword');
      final result = await callable.call({
        'email': email,
        'lang': _getLanguageCode(),
      });

      if (result.data['success'] != true) {
        throw result.data['message'];
      }
    } on FirebaseFunctionsException {
      rethrow;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserCredential> loginWithCustomAuth(
    String email,
    String password,
  ) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('loginUser');
      final result = await callable.call({
        'email': email,
        'password': password,
        'lang': _getLanguageCode(),
      });

      final String customToken = result.data['customToken'];
      UserCredential userCredential = await _auth.signInWithCustomToken(
        customToken,
      );

      return userCredential;
    } on FirebaseFunctionsException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(
    String email,
    String otp,
    String newPassword,
  ) async {
    try {
      final HttpsCallable callable = _functions.httpsCallable('resetPassword');
      final result = await callable.call({
        'email': email,
        'otp': otp,
        'newPassword': newPassword,
        'lang': _getLanguageCode(),
      });

      if (result.data['success'] != true) {
        throw result.data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      debugPrint("Error signing in with Google: $e");
      throw e.toString();
    }
  }

  Future<UserCredential?> signInWithApple() async {
    try {
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );

      final OAuthCredential credential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      debugPrint("Error signing in with Apple: $e");
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
