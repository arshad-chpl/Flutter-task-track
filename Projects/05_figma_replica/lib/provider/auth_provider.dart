import 'package:flutter/material.dart';

import '../firebase/firebase_auth_service.dart';
import '../firebase/firestore_service.dart';

import '../models/firebase_user_model.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();

  final FirestoreService _firestoreService = FirestoreService();

  bool _loading = false;

  bool get loading => _loading;

  FirebaseUserModel? _user;

  FirebaseUserModel? get user => _user;

  Future<bool> signup({
  required String firstName,
  required String lastName,
  required String email,
  required String phone,
  required String password,
  required String dob,
}) async {
    try {
      _loading = true;

      notifyListeners();

      final credential = await _authService.signup(
        email: email,
        password: password,
      );

      final firebaseUser = FirebaseUserModel(
        uid: credential.user!.uid,
        firstName: firstName,
        lastName: lastName,
        dob: dob,
        email: email,
        phone: phone,
        createdAt: DateTime.now(),
      );

      await _firestoreService.createUser(firebaseUser);

      _user = firebaseUser;

      return true;
    } catch (e) {
      debugPrint("Signup Error : $e");

      return false;
    } finally {
      _loading = false;

      notifyListeners();
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      _loading = true;

      notifyListeners();

      final credential = await _authService.login(
        email: email,

        password: password,
      );

      final user = await _firestoreService.getUser(credential.user!.uid);

      _user = user;

      return true;
    } catch (e) {
      debugPrint("Login Error : $e");

      return false;
    } finally {
      _loading = false;

      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();

    _user = null;

    notifyListeners();
  }
}
