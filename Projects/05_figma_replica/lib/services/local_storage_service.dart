import 'package:shared_preferences/shared_preferences.dart';
import '../models/editable_profile.dart';
import 'dart:convert';
class LocalStorageService {

  static const String isLoggedInKey ='isLoggedIn';

  static const String firstNameKey ='firstName';

  static const String accessTokenKey ='accessToken';

  static const String emailKey = "email";

  static const String editedProfileKey = 'editedProfile';

  Future<void> saveLoginStatus(
    bool value,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setBool(
      isLoggedInKey,
      value,
    );
  }

  Future<bool> getLoginStatus()
  async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getBool(
          isLoggedInKey,
        ) ??
        false;
  }

  Future<void> saveFirstName(
    String firstName,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      firstNameKey,
      firstName,
    );
  }

  Future<String?> getFirstName()
  async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
      firstNameKey,
    );
  }

  Future<void> saveEmail(
    String email,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      emailKey,
      email,
    );
  }

  Future<String?> getEmail()
  async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
      emailKey,
    );
  }

  Future<void> saveAccessToken(
    String token,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      accessTokenKey,
      token,
    );
  }

  Future<String?> getAccessToken()
  async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
      accessTokenKey,
    );
  }

  Future<void> clearStorage()
  async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.clear();
  }

  Future<void> saveEditedProfile(
  EditableProfile profile,
) async {

  final prefs =
      await SharedPreferences
          .getInstance();

  await prefs.setString(
    editedProfileKey,
    jsonEncode(
      profile.toJson(),
    ),
  );
}

Future<EditableProfile?> getEditedProfile()
async {

  final prefs =
      await SharedPreferences
          .getInstance();

  final profileData =
      prefs.getString(
        editedProfileKey,
      );

  if (profileData == null) {
    return null;
  }

  return EditableProfile.fromJson(
    jsonDecode(profileData),
  );
}

Future<void> clearEditedProfile()
async {

  final prefs =
      await SharedPreferences
          .getInstance();

  await prefs.remove(
    editedProfileKey,
  );
}
}
