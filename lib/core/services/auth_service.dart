import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/general_service/language_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFunctions _functions = FirebaseFunctions.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final LanguageService _languageService = LanguageService();
  static bool isInitialize = false;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get userChanges => _auth.userChanges();

  static Future<void> initSignIn() async {
    if (!isInitialize) {
      await _googleSignIn.initialize(
        serverClientId:
            '586343572662-mgcmtajb7p6cak11ml8p88ig63j7f537.apps.googleusercontent.com',
      );
    }
    isInitialize = true;
  }

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
      initSignIn();

      final GoogleSignInAccount googleSignInAccount = await _googleSignIn
          .authenticate(scopeHint: ['email', 'profile']);

      final GoogleSignInAuthentication googleAuth =
          googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      await signOut();
      debugPrint("Error signing in with Google: $e");
      throw e.toString();
    }
  }

  Future<UserCredential?> signInWithApple() async {
    try {
      final appleProvider = AppleAuthProvider();

      appleProvider.addScope('email');
      appleProvider.addScope('name');

      return await _auth.signInWithProvider(appleProvider);
    } catch (e) {
      debugPrint("Error signing in with Apple: $e");
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<void> deleteAccount(AppLocalizations l10n) async {
    final user = currentUser;
    if (user != null) {
      try {
        final baseUrl = dotenv.env['CONTACT_URL_API'] ?? '';
        final url = Uri.parse(baseUrl);

        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'salutation': "",
            'name': "User ${user.uid}",
            'email': user.email ?? "",
            'subject': "Yêu cầu xoá tài khoản",
            'content':
                "Người dùng với email ${user.email} và UID ${user.uid} yêu cầu xoá tài khoản.",
          }),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          bool isAppleSignIn = user.providerData.any(
            (provider) => provider.providerId == 'apple.com',
          );

          if (isAppleSignIn) {
            final appleProvider = AppleAuthProvider();
            appleProvider.addScope('email');
            appleProvider.addScope('name');

            final UserCredential credential = await user
                .reauthenticateWithProvider(appleProvider);

            final authCode = credential.additionalUserInfo?.authorizationCode;
            if (authCode != null) {
              await _auth.revokeTokenWithAuthorizationCode(authCode);
            }
          }

          await user.delete();
          await _googleSignIn.signOut();
        } else {
          debugPrint(
            "Failed to send account deletion request. Status code: ${response.statusCode}, Response body: ${response.body}",
          );
          throw l10n.failed_to_send_deletion_request;
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          throw l10n.requires_recent_login_description;
        }
        throw e.message ?? l10n.delete_account_failed;
      } catch (e) {
        throw e.toString();
      }
    }
  }
}
