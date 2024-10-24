import 'package:flutter/material.dart';
import 'package:lab2/repository/local_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ProfilePage({Key? key});
  
  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, String>> _userInfoFuture;

  @override
  void initState() {
    super.initState();
    _userInfoFuture = _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userInfoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final Map<String, String> userInfo = snapshot.data as Map<String, String>;
        final String username = userInfo['username'] ?? 'Username';
        final String email = userInfo['email'] ?? 'Email';

        return Scaffold(
          appBar: AppBar(title: const Text('User Profile')),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/edit_profile').then((_) {
                        setState(() {
                          _userInfoFuture = _getUserInfo();
                        });
                      });
                    },
                    child: const Text('Edit Profile'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      _logout();
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  final LocalStorageRepository _localStorageRepository = LocalStorageRepository();

  Future<Map<String, String>> _getUserInfo() async {
    final userInfo = await _localStorageRepository.getUserInfo();
    return userInfo;
  }

  Future<void> _logout() async {
    // ignore: unused_local_variable
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {  // Перевіряємо, чи віджет ще змонтовано
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }
}
