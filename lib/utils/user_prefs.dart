import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static const String _keyName =
      'user_name';

  static const String _keyEmail =
      'user_email';

  static const String _keyBio =
      'user_bio';

  static const String _keyHobi =
      'user_hobi';

  static const String _keyFoto =
      'user_foto';

  static const String _keyCurrentEmail = 
      'current_email';

  static Future<void> saveCurrentEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCurrentEmail, email);
  }

  static Future<String> getCurrentEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCurrentEmail) ?? "";
  } 

  static Future<void> saveProfile({
    required String nama,
    required String email,
    required String bio,
    required String hobi,
    String? foto,
  }) async {
    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      _keyName,
      nama,
    );

    await prefs.setString(
      _keyEmail,
      email,
    );

    await prefs.setString(
      _keyBio,
      bio,
    );

    await prefs.setString(
      _keyHobi,
      hobi,
    );

    if (foto != null) {
      await prefs.setString(
        _keyFoto,
        foto,
      );
    }
  }

  static Future<Map<String, String>>
      getProfile() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    return {
      "nama":
          prefs.getString(_keyName) ??
              "",

      "email":
          prefs.getString(_keyEmail) ??
              "",

      "bio":
          prefs.getString(_keyBio) ??
              "",

      "hobi":
          prefs.getString(_keyHobi) ??
              "",

      "foto":
          prefs.getString(_keyFoto) ??
              "",
    };
  }

  static Future<String> getName() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(_keyName) ??
        '';
  }
}