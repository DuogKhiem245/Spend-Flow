import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spend_flow/core/model/user_model.dart';
import 'package:spend_flow/core/services/auth_service.dart';
import 'package:spend_flow/core/services/data_service/firestore_service.dart';
import 'package:spend_flow/core/services/data_service/storage_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();
  final ImagePicker _picker = ImagePicker();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  File? _selectedAvatarFile;
  File? get selectedAvatarFile => _selectedAvatarFile;

  User? getCurrentUser() {
    return _authService.currentUser;
  }

  Future<void> loadUserProfile() async {
    final userAuth = _authService.currentUser;
    if (userAuth != null) {
      _isLoading = true;
      notifyListeners();

      try {
        final userDoc = await _firestoreService.getUser(userAuth.uid);
        if (userDoc != null) {
          _userModel = userDoc;
        } else {
          _userModel = UserModel(
            uid: userAuth.uid,
            email: userAuth.email ?? '',
            displayName: userAuth.displayName ?? '',
            phoneNumber: userAuth.phoneNumber ?? '',
            dob: null,
          );
        }
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> pickAvatar() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (image != null) {
        _selectedAvatarFile = File(image.path);
        notifyListeners(); 
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<void> updateProfile({
    required String displayName,
    required String phoneNumber,
    required DateTime dob,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final userAuth = _authService.currentUser;
      if (userAuth != null) {
        String? finalPhotoUrl = _userModel?.photoUrl; 

        if (_selectedAvatarFile != null) {
          finalPhotoUrl = await _storageService.uploadAvatar(
            file: _selectedAvatarFile!,
            uid: userAuth.uid,
          );

          await userAuth.updatePhotoURL(finalPhotoUrl);
        }

        if (userAuth.displayName != displayName) {
          await userAuth.updateDisplayName(displayName);
          await userAuth.reload();
        }

        final updatedUser = UserModel(
          uid: userAuth.uid,
          email: userAuth.email ?? '',
          displayName: displayName,
          phoneNumber: phoneNumber,
          dob: dob,
          photoUrl: finalPhotoUrl, 
        );

        await _firestoreService.saveUser(updatedUser);

        _userModel = updatedUser;
        _selectedAvatarFile = null;
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
