import 'package:flutter/material.dart';
import 'package:flutter_lab2/pages/home_page.dart';
import 'package:flutter_lab2/pages/login_page.dart';
import 'package:flutter_lab2/pages/profile_page.dart';
import 'package:flutter_lab2/pages/registration_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}

