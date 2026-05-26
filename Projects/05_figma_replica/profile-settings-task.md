# Task: Profile Settings And Account Preferences

## Task Summary

After completing local profile editing, the next task is to add a settings screen where the user can manage app preferences.

This task should use `shared_preferences` because these settings are local app preferences, not server data.

## Goal

Create a settings screen where the user can update and save app preferences locally.

The settings should remain saved after:

- App refresh
- App restart
- Navigating away and coming back

## Preferences To Add

Add these preferences:

- Dark mode toggle
- Notifications toggle
- Remember me toggle
- Language dropdown

Language options:

- English
- Hindi
- Gujarati

## Files To Create

Create these files:

```text
lib/
  models/
    app_preferences.dart
  screens/
    settings_screen.dart
  services/
    preferences_service.dart
```

Update these files:

```text
lib/
  screens/
    profile_screen.dart
  main.dart
```

## Suggested Folder Structure

```text
lib/
  models/
    app_preferences.dart
  screens/
    profile_screen.dart
    settings_screen.dart
  services/
    preferences_service.dart
```

## Step 1: Create `AppPreferences` Model

Create:

```text
lib/models/app_preferences.dart
```

Fields:

- `isDarkMode`
- `notificationsEnabled`
- `rememberMe`
- `language`

The model should include:

```dart
toJson()
fromJson()
```

Use this model to keep preferences structured instead of reading many loose values in the UI.

## Step 2: Create `PreferencesService`

Create:

```text
lib/services/preferences_service.dart
```

This service should handle all `shared_preferences` logic for app settings.

Suggested method names:

```dart
savePreferences(...)
getPreferences()
clearPreferences()
```

Do not use `SharedPreferences` directly inside `SettingsScreen`.

## Step 3: Create `SettingsScreen`

Create:

```text
lib/screens/settings_screen.dart
```

The settings screen should show:

- Dark mode switch
- Notifications switch
- Remember me switch
- Language dropdown
- Logout button

When the user changes a setting:

- Update UI state
- Save the value locally
- Keep the value after app restart

## Step 4: Open Settings From Profile Screen

Add a settings button on `ProfileScreen`.

The button can be:

- AppBar settings icon
- Settings list item
- Button near logout/profile actions

When tapped, navigate to `SettingsScreen`.

## Step 5: Apply Dark Mode

When dark mode is enabled:

- App should use dark theme
- Setting should remain saved after restart

Keep this simple.

Expected behavior:

```text
Dark mode ON  -> app uses dark theme
Dark mode OFF -> app uses light theme
```

If applying app-wide theme is difficult, first complete saving and reading the value, then apply the theme.

## Step 6: Remember Me Behavior

The app may already save login state.

For this task:

- If Remember me is ON, keep user logged in after restart
- If Remember me is OFF, clear login state when app is reopened or when user logs out

Keep the behavior simple and clearly documented in code comments if needed.

## Step 7: Notifications Toggle

This is only a local setting for now.

Do not integrate real push notifications.

Expected behavior:

- User can turn notifications ON/OFF
- Setting is saved locally
- Setting remains after restart

## Step 8: Language Dropdown

Add dropdown options:

- English
- Hindi
- Gujarati

Expected behavior:

- User selects a language
- Selected language is saved locally
- Selected language remains after restart

Do not implement full app translation in this task.

Only store and display the selected language.

## Expected Behavior

### First Open

- Settings screen loads default preferences.
- Suggested defaults:
  - Dark mode: OFF
  - Notifications: ON
  - Remember me: ON
  - Language: English

### After Updating Settings

- User changes one or more settings.
- Changes are saved locally.
- Navigating away and coming back should show the updated values.

### After App Restart

- Saved preferences should load again.
- Dark mode should be applied if enabled.
- Selected language should still be visible.

## What Not To Do

- Do not use API for these settings.
- Do not store preferences directly inside UI widgets.
- Do not implement real push notifications.
- Do not implement full multi-language translation.
- Do not mix profile edit data with app preferences.
- Do not put all logic in `main.dart`.

## Submission Checklist

- `AppPreferences` model created
- `PreferencesService` created
- `SettingsScreen` created
- Settings screen accessible from profile screen
- Dark mode toggle added
- Notifications toggle added
- Remember me toggle added
- Language dropdown added
- Preferences saved using `shared_preferences`
- Preferences loaded after app restart
- Dark mode applied or prepared cleanly
- Logout button available from settings
- No API used for app preferences
- `flutter analyze` passes
- `flutter test` passes

## Review Focus

This task will be reviewed for:

- Correct use of `shared_preferences`
- Clean settings service
- App preference model usage
- Persistent settings behavior
- Simple and clear settings UI
- No unnecessary API usage
- Existing login/profile flow still working
