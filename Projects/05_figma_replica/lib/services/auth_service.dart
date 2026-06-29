import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/signup_request.dart';
import '../models/signup_response.dart';
import '../models/user_profile_response.dart';

import '../firebase/firebase_auth_service.dart';
import '../firebase/firestore_service.dart';
import '../models/firebase_user_model.dart';

import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  final FirestoreService _firestoreService = FirestoreService();

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final request = LoginRequest(username: username, password: password);

    final data = await _apiService.post('/auth/login', request.toJson());

    return LoginResponse.fromJson(data);
  }

  Future<UserProfileResponse> getProfile(String accessToken) async {
    final data = await _apiService.get(
      '/auth/me',

      headers: {'Authorization': 'Bearer $accessToken'},
    );

    return UserProfileResponse.fromJson(data);
  }

  Future<SignupResponse> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {
    final request = SignupRequest(
      firstName: firstName,

      lastName: lastName,

      email: email,

      phone: phone,

      password: password,
    );

    final data = await _apiService.post('/users/add', request.toJson());

    return SignupResponse.fromJson(data);
  }

  Future<FirebaseUserModel?> firebaseSignup({
    required String firstname,
    required String lastname,
    required String dob,

    required String email,

    required String phone,

    required String password,
  }) async {
    final credential = await _firebaseAuthService.signup(
      email: email,

      password: password,
    );

    final firebaseUser = FirebaseUserModel(
      uid: credential.user!.uid,

      firstName: firstname,
      lastName: lastname,
      dob: dob,
      email: email,

      phone: phone,

      createdAt: DateTime.now(),
    );

    await _firestoreService.createUser(firebaseUser);

    return firebaseUser;
  }

  Future<FirebaseUserModel?> firebaseLogin({
    required String email,

    required String password,
  }) async {
    final credential = await _firebaseAuthService.login(
      email: email,

      password: password,
    );

    final user = await _firestoreService.getUser(credential.user!.uid);

    return user;
  }

  Future<void> firebaseLogout() async {
    await _firebaseAuthService.logout();
  }
}
