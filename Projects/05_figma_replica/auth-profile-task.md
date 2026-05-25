# Task: Create Profile Screen Using Profile API

## Task Summary

Your new task is to create a profile screen that fetches the logged-in user's details from the profile API.

Use the saved access token from local storage and call:

```text
GET https://dummyjson.com/auth/me
```

For this task, pass the `accessToken` in the request body as required by the project API contract. Then display the user data on the profile screen.

## Goal

Create a profile screen that:

- Reads the saved access token
- Reads the saved user name or username
- Calls the profile API
- Shows loading state while data is loading
- Displays user profile details
- Shows an error message if the API fails
- Redirects to login if token is missing or invalid

Also fix the current issue where the user name is not visible on the home screen after login.

## API To Use

Profile API:

```text
GET https://dummyjson.com/auth/me
```

Required request body:

```json
{
  "accessToken": "ACCESS_TOKEN"
}
```

Note: Passing a body with a `GET` request is unusual in many APIs. For this task, follow the API contract given for this project. If the API does not accept a body with `GET`, confirm whether the method should be `POST`.

## Files To Create

Create these files:

```text
lib/
  models/
    user_profile_response.dart
  screens/
    profile_screen.dart
```

Update these files:

```text
lib/
  services/
    api_service.dart
    auth_service.dart
    local_storage_service.dart
```

## Updated Folder Structure

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
    user_profile_response.dart
  screens/
    splash_screen.dart
    login_screen.dart
    signup_screen.dart
    home_screen.dart
    profile_screen.dart
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

## Step 1: Store Access Token After Login

Make sure the access token and user details from login response are saved in `LocalStorageService`.

`LocalStorageService` should have methods like:

```dart
Future<void> saveAccessToken(String token)
Future<String?> getAccessToken()
Future<String?> getFirstName()
Future<String?> getUsername()
Future<void> logout()
```

At minimum, save:

- Access token
- First name
- Last name
- Username
- Email

Do not store the password locally.

## Step 1.1: Fix User Name On Home Screen

Currently, after login, the user name is not visible on the home screen. Fix this before or while creating the profile screen.

Home screen should:

- Read saved first name, last name, or username from `LocalStorageService`
- Show a welcome message
- Not show empty user data after successful login

Example display text:

```text
Welcome, Emily Johnson
```

or:

```text
Welcome, emilys
```

If the user data is missing, show a fallback:

```text
Welcome
```

## Step 2: Add Profile Request Method In `ApiService`

Add a reusable method in `ApiService` for calling the profile API.

It should support:

- Endpoint
- Request body with `accessToken`
- JSON decoding
- Error handling

Short example:

```dart
Future<Map<String, dynamic>> getWithBody(
  String endpoint,
  Map<String, dynamic> body,
) async {
  // Call API with accessToken body, decode JSON, handle success/error.
}
```

Do not write the API call directly inside the profile screen.

## Step 3: Create `UserProfileResponse` Model

Create:

```text
lib/models/user_profile_response.dart
```

Include fields needed for the UI:

- `id`
- `firstName`
- `lastName`
- `username`
- `email`
- `gender`
- `image`

The model should have:

```dart
factory UserProfileResponse.fromJson(Map<String, dynamic> json)
```

## Step 4: Add Profile API Method In `AuthService`

Add a method like:

```dart
Future<UserProfileResponse> getProfile(String accessToken)
```

This method should:

- Call the profile API through `ApiService`
- Pass `accessToken` in request body
- Convert response into `UserProfileResponse`

Request body format:

```dart
{
  'accessToken': accessToken,
}
```

## Step 5: Create `ProfileScreen`

Create:

```text
lib/screens/profile_screen.dart
```

The screen should:

- Read access token from `LocalStorageService`
- Call `AuthService.getProfile`
- Show loading indicator while fetching data
- Show profile data after success
- Show error message if API fails
- Logout and redirect to login if token is missing or invalid

## Data To Display

Display:

- Profile image
- Full name
- Username
- Email
- Gender

On the home screen, display at least:

- Welcome message with name or username
- Email if available

Optional:

- User id
- Logout button

## Loading State

While API is loading, show:

```text
CircularProgressIndicator
```

## Error State

If API fails:

- Show error text or `SnackBar`
- If token is invalid, clear local storage
- Navigate back to login screen

## Navigation

After login success, user should go to profile screen or home screen.

Recommended for this task:

```text
LoginScreen -> ProfileScreen
```

If your app already has `HomeScreen`, then:

```text
LoginScreen -> HomeScreen -> ProfileScreen
```

## What Not To Do

- Do not call API directly from button `onPressed`.
- Do not put API URL inside profile screen.
- Do not store password locally.
- Do not ignore missing token case.
- Do not show profile screen with empty fake data if API fails.
- Do not put all code in `main.dart`.

## Expected Behavior

### Success

- User logs in successfully.
- Access token is saved.
- User name and email are saved.
- Home screen shows the user name or username.
- Profile screen opens.
- App calls `/auth/me`.
- Profile details are displayed.

### Missing Token

- App cannot find saved token.
- User is logged out.
- User is redirected to login screen.

### API Failure

- App shows an error message.
- If needed, user is redirected to login screen.

## Submission Checklist

- Access token saved after login
- User name or username saved after login
- Home screen shows user name or username after login
- Access token read from local storage
- Profile request method added in `ApiService`
- Access token passed in API request body
- `UserProfileResponse` model created
- `AuthService.getProfile` method created
- `ProfileScreen` created
- `/auth/me` API called with saved access token
- Loading state added
- Error state added
- Missing token handled
- Profile image displayed
- Name, username, email, and gender displayed
- API code kept out of UI screen
- `flutter analyze` passes
- `flutter test` passes

## Review Focus

This task will be reviewed for:

- Correct use of saved access token
- Correct profile API call with access token in body
- Clean service layer usage
- Proper response model usage
- Loading and error state handling
- Clean UI and file separation
