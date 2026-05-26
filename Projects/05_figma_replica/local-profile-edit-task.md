# Task: Local Profile Edit With Saved Overrides

## Task Summary

The profile screen currently gets user data from the mock API. Since this is a mock API, updating profile data on the server will not permanently change the API response.

So this task should not pretend that the mock API really updates the user profile.

Instead, allow the user to edit profile data locally and store those edited values using `shared_preferences`.

## Goal

Allow the user to edit profile details locally and keep those edited values visible even after:

- API profile data reloads
- App refresh
- App restart

## Main Concept

The profile screen should combine two sources of data:

```text
API profile data + locally edited profile data
```

Local edited data should get priority over API data.

Example:

```text
API firstName: Emily
Local firstName: Bansi
Displayed firstName: Bansi
```

If no local edited value exists, show the API value.

## Files To Create

Create these files:

```text
lib/
  models/
    editable_profile.dart
  screens/
    edit_profile_screen.dart
```

Update these files:

```text
lib/
  screens/
    profile_screen.dart
  services/
    local_storage_service.dart
```

## Suggested Folder Structure

```text
lib/
  models/
    editable_profile.dart
    user_profile_response.dart
  screens/
    profile_screen.dart
    edit_profile_screen.dart
  services/
    local_storage_service.dart
```

## Step 1: Create `EditableProfile` Model

Create:

```text
lib/models/editable_profile.dart
```

This model should represent locally edited profile data.

Fields:

- `firstName`
- `lastName`
- `email`
- `phone`

The model should include:

```dart
toJson()
fromJson()
```

This will make it easier to save and read edited data from `shared_preferences`.

## Step 2: Update `LocalStorageService`

Add methods to handle edited profile data.

Suggested method names:

```dart
saveEditedProfile(...)
getEditedProfile()
clearEditedProfile()
```

Responsibilities:

- Save edited profile data locally
- Read edited profile data locally
- Clear edited profile data when user resets to API data

Keep all `shared_preferences` logic inside `LocalStorageService`.

Do not use `SharedPreferences` directly inside screens.

## Step 3: Update `ProfileScreen`

Profile screen should:

- Fetch profile data from API
- Read edited profile data from local storage
- Merge API data and local edited data
- Display merged data

Merge rule:

```text
If local edited value exists, show local value.
Otherwise, show API value.
```

Example:

```text
API email: emily@example.com
Local email: bansi@example.com
Displayed email: bansi@example.com
```

Also add:

- Edit Profile button
- Reset to API Data button

## Step 4: Create `EditProfileScreen`

Create:

```text
lib/screens/edit_profile_screen.dart
```

The edit screen should:

- Open from `ProfileScreen`
- Receive the currently displayed profile data
- Pre-fill fields with current profile data
- Allow editing selected fields
- Validate fields before saving
- Save edited data locally
- Return to profile screen after save

Editable fields:

- First name
- Last name
- Email
- Phone

## Step 5: Add Validations

Add validation for:

- First name is required
- Last name is required
- Email is required
- Email format should be valid
- Phone number is required
- Phone number should have valid length

Do not save invalid data.

## Step 6: Add Reset To API Data

Add a reset option on `ProfileScreen`.

When user taps `Reset to API Data`:

- Clear edited profile data from local storage
- Reload profile display
- Show API data again

This is important because the app should give the user a way to remove local overrides.

## Expected Behavior

### First Profile Load

- Profile data loads from API.
- No local edits exist.
- App displays API data.

### After Editing Profile

- User opens edit profile screen.
- User changes first name, last name, email, or phone.
- User saves.
- Edited data is stored locally.
- Profile screen shows edited data.

### After App Restart

- Profile API data loads again.
- Local edited data is also loaded.
- Profile screen still shows edited data.

### After API Reload Or Refresh

- API data may reload.
- Local edited data should still get priority.
- User should not lose local edits.

### After Reset

- User taps `Reset to API Data`.
- Local edited profile data is cleared.
- Profile screen shows original API data again.

## What Not To Do

- Do not call fake update API for this task.
- Do not assume mock API permanently saves edited data.
- Do not store password locally.
- Do not put `shared_preferences` code inside UI screens.
- Do not overwrite local edited data when API reloads.
- Do not put all logic in `main.dart`.

## Submission Checklist

- `EditableProfile` model created
- `EditProfileScreen` created
- Profile screen has Edit Profile button
- Profile screen has Reset to API Data option
- Edit form is pre-filled with current displayed data
- Validations added
- Edited data saved in `shared_preferences`
- Profile screen merges API data with local edited data
- Local edited data gets priority
- Edited data remains after app restart
- Reset clears local edited profile data
- Password is not stored locally
- `flutter analyze` passes
- `flutter test` passes

## Review Focus

This task will be reviewed for:

- Correct local override behavior
- Clean merge logic
- Proper use of `shared_preferences`
- Good code separation
- Clear edit profile UX
- Correct reset behavior
- Existing profile API flow still working
