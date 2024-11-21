import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository {
  static const String _usernameKey = 'username';
  static const String _emailKey = 'email';
  static const String _passwordKey = 'password';
  static const String _profileImageKey = 'profileImage';


  // Збереження шляху до зображення профілю
  Future<void> saveProfileImagePath(String path) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileImageKey, path);
  }

  // Отримання шляху до зображення профілю
  Future<String?> getProfileImagePath() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileImageKey);
  }

  // Перевірка наявності даних користувача
  Future<bool> hasUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString(_emailKey);
    final String? password = prefs.getString(_passwordKey);
    return email != null && password != null;
  }

  // Збереження даних реєстрації
  Future<void> saveRegistrationData(
      String username,
      String email,
      String password,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
  }

  // Отримання даних реєстрації
  Future<Map<String, String>> getRegistrationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String username = prefs.getString(_usernameKey) ?? '';
    final String email = prefs.getString(_emailKey) ?? '';
    final String password = prefs.getString(_passwordKey) ?? '';
    return {'username': username, 'email': email, 'password': password};
  }

  // Вхід користувача
  Future<bool> loginUser(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedEmail = prefs.getString(_emailKey);
    final String? storedPassword = prefs.getString(_passwordKey);
    return email == storedEmail && password == storedPassword;
  }

  // Отримання інформації про користувача
  Future<Map<String, String>> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String username = prefs.getString(_usernameKey) ?? 'Username';
    final String email = prefs.getString(_emailKey) ?? 'Email';
    return {'username': username, 'email': email};
  }
}

