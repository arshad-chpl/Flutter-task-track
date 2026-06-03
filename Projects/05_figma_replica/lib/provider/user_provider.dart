import 'package:flutter/material.dart';

import '../models/editable_profile.dart';
import '../models/user_profile_response.dart';

import '../services/auth_service.dart';
import '../services/local_storage_service.dart';

class UserProvider extends ChangeNotifier {
  final LocalStorageService _storageService = LocalStorageService();

  final AuthService _authService = AuthService();

  UserProfileResponse? user;

  String username = '';

  String email = '';

  bool isLoading = false;

  bool isEditing = false;

  String errorMessage = '';

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  Future<void> loadUserData() async {
    try {
      isLoading = true;

      notifyListeners();

      final editedProfile = await _storageService.getEditedProfile();

      if (editedProfile != null) {
        username = editedProfile.firstName;
        email = editedProfile.email;
        // print("$username");
        // print("$email");
      } else {
        username = await _storageService.getFirstName() ?? '';
        email = await _storageService.getEmail() ?? '';
        // print("$username");
        // print("$email");
      }
    } catch (e) {
      errorMessage = 'Failed to load user data';
    }

    isLoading = false;

    notifyListeners();
  }

  Future<void> loadProfile() async {
    try {
      isLoading = true;

      notifyListeners();

      final token = await _storageService.getAccessToken();

      if (token == null || token.isEmpty) {
        errorMessage = 'No Token Found';

        isLoading = false;

        notifyListeners();

        return;
      }

      final response = await _authService.getProfile(token);

      final localProfile = await _storageService.getEditedProfile();

      user = response;

      firstNameController.text = localProfile?.firstName ?? response.firstName;
      lastNameController.text = localProfile?.lastName ?? response.lastName;
      userNameController.text = localProfile?.userName ?? response.username;
      emailController.text = localProfile?.email ?? response.email;
      phoneController.text = localProfile?.phone ?? response.phone;
      username = firstNameController.text;
      email = emailController.text;

      errorMessage = '';
    } catch (e) {
      errorMessage = 'Failed to load profile';
    }

    isLoading = false;

    notifyListeners();
  }

  void toggleEdit() {
    isEditing = !isEditing;

    notifyListeners();
  }

  Future<void> saveProfile() async {
    final updatedProfile = EditableProfile(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      userName: userNameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
    );

    await _storageService.saveEditedProfile(updatedProfile);

    username = firstNameController.text.trim();

    email = emailController.text.trim();

    notifyListeners();
  }

  Future<void> resetProfile() async {
    await _storageService.clearEditedProfile();

    await loadProfile();
  }

  Future<void> logout(BuildContext context) async {
    await _storageService.clearStorage();

    if (!context.mounted) return;

    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    firstNameController.dispose();

    lastNameController.dispose();

    userNameController.dispose();

    emailController.dispose();

    phoneController.dispose();

    super.dispose();
  }
}
