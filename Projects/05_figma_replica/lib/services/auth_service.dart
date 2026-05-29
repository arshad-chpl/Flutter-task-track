import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/signup_request.dart';
import '../models/signup_response.dart';
import '../models/user_profile_response.dart';

import 'api_service.dart';

class AuthService {

  final ApiService _apiService =
      ApiService();

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {

    final request = LoginRequest(
      username: username,
      password: password,
    );

    final data =
        await _apiService.post(
      '/auth/login',
      request.toJson(),
    );

    //print('response: $data');

    return LoginResponse.fromJson(
      data,
    );
  }

  Future<UserProfileResponse> getProfile(
  String accessToken,
) async {

  final data = await _apiService.get(
    '/auth/me',
    headers: {
      'Authorization':
          'Bearer $accessToken',
    },
  );

  return UserProfileResponse.fromJson(
    data,
  );
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

    final data =
        await _apiService.post(
      '/users/add',
      request.toJson(),
    );

    return SignupResponse.fromJson(
      data,
    );
  }
}
