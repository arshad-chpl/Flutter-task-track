# Task: Integrate Mock Login And Signup API

## Task Summary

You have done a good job building the login and signup UI, adding validations, improving keyboard behavior, and creating reusable widgets.

The next task is to connect the forms with a mock authentication API. This will help you learn how real apps send form data to an API, handle loading states, show success/error messages, and keep API code separate from UI code.

## API To Use

Use **DummyJSON**.

Official docs:

- Auth docs: https://dummyjson.com/docs/auth
- Users docs: https://dummyjson.com/docs/users

## Important Note

This is a mock API. It is useful for learning and testing, but it does not permanently create real users.

The signup API only simulates user creation and returns a fake created user response.

## Package To Add

Add the `http` package in `pubspec.yaml`:

```yaml
dependencies:
  http: ^1.2.2
```

Then run:

```sh
flutter pub get
```

## API Endpoints

### Login API

```text
POST https://dummyjson.com/auth/login
```

Use these test credentials:

```json
{
  "username": "emilys",
  "password": "emilyspass"
}
```

Expected success response includes:

- User id
- Username
- Email
- First name
- Last name
- Image
- Access token
- Refresh token

### Signup API

```text
POST https://dummyjson.com/users/add
```

This simulates adding a new user.

Example request:

```json
{
  "firstName": "Rahul",
  "lastName": "Sharma",
  "email": "rahulsharma@gmail.com",
  "phone": "+91 9876543210",
  "password": "123456"
}
```

## Files To Create

Create these files:

```text
lib/
  services/
    api_service.dart
    auth_service.dart
  models/
    login_request.dart
    login_response.dart
    signup_request.dart
    signup_response.dart
```

Updated structure should look like:

```text
lib/
  main.dart
  constants/
    app_assets.dart
    app_colors.dart
    app_sizes.dart
  models/
    login_request.dart
    login_response.dart
    signup_request.dart
    signup_response.dart
  screens/
    login_screen.dart
    signup_screen.dart
  services/
    api_service.dart
    auth_service.dart
  widgets/
    auth_header.dart
    auth_text_field.dart
    primary_button.dart
    social_login_button.dart
```

## File 1: `lib/services/api_service.dart`

This file should contain common API logic.

The purpose of `ApiService` is to avoid repeating `http.post`, headers, JSON encoding, and JSON decoding in every service file.

This is a good practice, but keep it simple for now. Do not add advanced concepts like interceptors, token refresh, secure storage, or complex architecture in this task.

Example:

```dart
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    }

    throw Exception(data['message'] ?? 'Something went wrong');
  }
}
```

## File 2: `lib/services/auth_service.dart`

This file should contain all API calls.

Do not write API code directly inside `login_screen.dart` or `signup_screen.dart`.

`AuthService` should use `ApiService` instead of directly calling `http.post`.

Example:

```dart
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/signup_request.dart';
import '../models/signup_response.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final request = LoginRequest(
      username: username,
      password: password,
    );

    final data = await _apiService.post(
      '/auth/login',
      request.toJson(),
    );

    return LoginResponse.fromJson(data);
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

    final data = await _apiService.post(
      '/users/add',
      request.toJson(),
    );

    return SignupResponse.fromJson(data);
  }
}
```

## Why Use Both `ApiService` And `AuthService`?

Use `ApiService` for common HTTP work:

- Base URL
- Headers
- JSON encoding
- JSON decoding
- Basic status code checking

Use `AuthService` for authentication-specific work:

- Login API call
- Signup API call
- Converting form values into request models
- Converting API response into models

This keeps the UI clean. The screens should only call methods like:

```dart
await _authService.login(
  username: username,
  password: password,
);
```

The screen should not know the full API URL or how JSON is encoded.

## File 3: `lib/models/login_request.dart`

This model should represent login API request data.

Use request models so you do not pass loose maps everywhere.

Example:

```dart
class LoginRequest {
  final String username;
  final String password;

  const LoginRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
```

## File 4: `lib/models/login_response.dart`

This model should represent login API response.

Example:

```dart
class LoginResponse {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String accessToken;
  final String refreshToken;

  const LoginResponse({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
```

## File 5: `lib/models/signup_request.dart`

This model should represent signup API request data.

Example:

```dart
class SignupRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;

  const SignupRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }
}
```

## File 6: `lib/models/signup_response.dart`

This model should represent signup API response.

Example:

```dart
class SignupResponse {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  const SignupResponse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}
```

## Login Screen Changes

Update `login_screen.dart`.

### Add State

Add:

```dart
final AuthService _authService = AuthService();
bool _isLoading = false;
```

### Login Function

Create a function:

```dart
Future<void> _login() async {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    final response = await _authService.login(
      username: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Welcome ${response.firstName}'),
      ),
    );
  } catch (error) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.toString()),
      ),
    );
  } finally {
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
```

### Important Login Note

DummyJSON login uses `username`, not email.

For this task, either:

- Change login field label from `Email` to `Username`
- Or tell the user to enter username in the email field

Recommended: change the field to `Username`.

Use:

```text
username: emilys
password: emilyspass
```

## Signup Screen Changes

Update `signup_screen.dart`.

### Add State

Add:

```dart
final AuthService _authService = AuthService();
bool _isLoading = false;
```

### Signup Function

Create a function:

```dart
Future<void> _signup() async {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    final response = await _authService.signup(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User created: ${response.firstName}'),
      ),
    );
  } catch (error) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.toString()),
      ),
    );
  } finally {
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
```

## Button Loading State

Update `PrimaryButton` so it supports loading.

Example:

```dart
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(text),
      ),
    );
  }
}
```

Use it like:

```dart
PrimaryButton(
  text: 'Log In',
  isLoading: _isLoading,
  onPressed: _login,
)
```

## Error Handling Requirements

Handle these cases:

- Invalid form input
- Wrong username/password
- No internet connection
- API returns error
- Button should not be clickable while loading

Show error messages using `SnackBar`.

## Expected Behavior

### Login Success

When user enters:

```text
username: emilys
password: emilyspass
```

and taps `Log In`:

- Button shows loading indicator
- API is called
- Success `SnackBar` appears
- User data is received from API

### Login Failure

When user enters wrong credentials:

- Button shows loading indicator
- API is called
- Error `SnackBar` appears
- Button becomes active again

### Signup Success

When user enters valid signup details:

- Button shows loading indicator
- API is called
- Success `SnackBar` appears
- Created user response is received

## What Not To Do

- Do not call API directly inside button `onPressed`.
- Do not put API URLs inside widgets.
- Do not ignore validation before API call.
- Do not leave button clickable during API call.
- Do not put all code in `main.dart`.
- Do not store real passwords or tokens in plain text for production apps.

## Submission Checklist

- `http` package added
- `ApiService` created
- `AuthService` created
- `LoginRequest` model created
- `LoginResponse` model created
- `SignupRequest` model created
- `SignupResponse` model created
- Login API integrated
- Signup API integrated
- Loading state added
- Success `SnackBar` added
- Error `SnackBar` added
- Button disabled while loading
- Validation runs before API call
- Common API logic is inside `ApiService`
- API code is separate from UI
- Login uses correct DummyJSON credentials
- `flutter analyze` passes
- `flutter test` passes

## Review Focus

This task will be reviewed for:

- Correct API integration
- Clean service layer
- Proper request model usage
- Proper model usage
- Correct loading state handling
- Good error handling
- No API logic mixed directly into UI widgets
- Existing validations still working
