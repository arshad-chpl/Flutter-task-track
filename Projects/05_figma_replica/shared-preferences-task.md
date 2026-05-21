# Task: Store Login State And User Data With Shared Preferences

## Task Summary

You have integrated the mock login/signup API flow. The next task is to store basic user data locally after login and use that stored data to manage the logged-in state.

Use `shared_preferences` to save:

- Logged-in state
- User name
- Username
- Email
- Access token

Then show this stored data on a new home screen.

## Package To Use

Add this package in `pubspec.yaml`:

```yaml
dependencies:
  shared_preferences: 2.5.5
```

Then run:

```sh
flutter pub get
```

## Goal

After successful login:

1. Save login state in local storage.
2. Save user data in local storage.
3. Navigate user to the home screen.
4. Show stored user data on the home screen.
5. Keep the user logged in even after app restart.
6. Add logout functionality that clears stored data.

## Files To Create

Create these files:

```text
lib/
  screens/
    home_screen.dart
    splash_screen.dart
  services/
    local_storage_service.dart
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
    splash_screen.dart
    login_screen.dart
    signup_screen.dart
    home_screen.dart
  services/
    api_service.dart
    auth_service.dart
    local_storage_service.dart
  widgets/
    auth_header.dart
    auth_text_field.dart
    primary_button.dart
    social_login_button.dart
```

## File 1: `lib/services/local_storage_service.dart`

This file should handle all `shared_preferences` logic.

Do not use `SharedPreferences` directly inside screens.

Example:

```dart
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _firstNameKey = 'firstName';

  Future<void> saveLoginData({
    required String firstName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_firstNameKey, firstName);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
```

## File 2: `lib/screens/splash_screen.dart`

The splash screen should decide where the user should go when the app opens.

If user is already logged in, go to home screen.

If user is not logged in, go to login screen.

Example:

```dart
Future<void> _checkLoginState() async {
  final isLoggedIn = await _localStorageService.isLoggedIn();

  if (!mounted) return;

  if (isLoggedIn) {
    // Navigate to HomeScreen.
  } else {
    // Navigate to LoginScreen.
  }
}
```

## File 3: `lib/screens/home_screen.dart`

The home screen should show stored user data.

Example:

```dart
Future<void> _loadUserData() async {
  final firstName = await _localStorageService.getFirstName();
  final email = await _localStorageService.getEmail();

  // Store values in state and show them on the screen.
}

Future<void> _logout() async {
  await _localStorageService.logout();

  // Navigate back to LoginScreen.
}
```

## Login Screen Changes

After successful login API response:

1. Save data using `LocalStorageService`.
2. Navigate to `HomeScreen`.

Example:

```dart
final LocalStorageService _localStorageService = LocalStorageService();
```

Inside login success:

```dart
await _localStorageService.saveLoginData(
  firstName: response.firstName,
  // Save other required user fields here.
);

// Navigate to HomeScreen.
```

## Main File Changes

Update `main.dart` so the app starts from `SplashScreen`.

Example:

```dart
MaterialApp(
  debugShowCheckedModeBanner: false,
  home: const SplashScreen(),
)
```

## Expected Behavior

### First App Open

- User sees login screen.
- User logs in with valid credentials.
- App saves login state and user data.
- App navigates to home screen.

### After App Restart

- App opens splash screen.
- Splash screen checks local storage.
- If user is logged in, app opens home screen directly.

### Logout

- User taps logout.
- Stored data is cleared.
- User is redirected to login screen.
- After restart, app opens login screen again.

## What Not To Store

For this learning task, storing the mock access token is fine.

But in real production apps:

- Do not store sensitive tokens in plain shared preferences.
- Use secure storage for real authentication tokens.
- Do not store raw passwords locally.

Never store the password in `shared_preferences`.

## Submission Checklist

- `shared_preferences: 2.5.5` added
- `LocalStorageService` created
- Login state saved after successful login
- User data saved after successful login
- `SplashScreen` created
- `HomeScreen` created
- App opens home screen if already logged in
- App opens login screen if not logged in
- Home screen shows stored user data
- Logout clears stored data
- Password is not stored locally
- `flutter analyze` passes
- `flutter test` passes

## Review Focus

This task will be reviewed for:

- Correct use of `shared_preferences`
- No local storage code inside UI widgets except through service calls
- Correct login persistence
- Correct logout behavior
- Clean file structure
- Good handling of async code and `mounted`
