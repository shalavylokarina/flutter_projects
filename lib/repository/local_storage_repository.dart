import 'package:shared_preferences/shared_preferences.dart';
class LocalStorageRepository {
  static const String _usernameKey = 'username';
  static const String _emailKey = 'email';
  static const String _passwordKey = 'password';
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
  Future<Map<String, String>> getRegistrationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String username = prefs.getString(_usernameKey) ?? '';
    final String email = prefs.getString(_emailKey) ?? '';
    final String password = prefs.getString(_passwordKey) ?? '';
    return {'username': username, 'email': email, 'password': password};
  }
  Future<bool> loginUser(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedEmail = prefs.getString('email');
    final String? storedPassword = prefs.getString('password');
    return email == storedEmail && password == storedPassword;
  }
  Future<Map<String, String>> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String username = prefs.getString('username') ?? 'Username';
    final String email = prefs.getString('email') ?? 'Email';
    return {'username': username, 'email': email};
  }
}