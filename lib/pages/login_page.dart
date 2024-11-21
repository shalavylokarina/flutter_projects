import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lab2/repository/local_storage_repository.dart';

class LoginPage extends StatefulWidget {
  
  // ignore: use_key_in_widget_constructors
  const LoginPage({Key? key});
  @override
 
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _formAnimation;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final LocalStorageRepository _localStorageRepository = LocalStorageRepository();

  Future<bool> _loginUser() async {
    return await _localStorageRepository.loginUser(
      _emailController.text,
      _passwordController.text,
    );
  }
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    _logoAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.5)),
    );
    _formAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1)),
    );
     _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _controller.forward();

    _checkAutoLogin();

    Connectivity().checkConnectivity();
  }
  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
    void _checkAutoLogin() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetDialog();
      return;
    }

   await Future.delayed(const Duration(seconds: 3));
    final bool userDataExists = await _localStorageRepository.hasUserData();
    if (userDataExists) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Auto-Login'),
          content: const Text('Do you want to log in automatically?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    }
  }
void _showNoInternetDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('You are not connected to the internet. '
              'Please check your connection and try again.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
 
  void _login() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetDialog();
    } else {
      final bool loggedIn = await _loginUser();
      if (loggedIn) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) =>
              AlertDialog(
                title: const Text('Login Successful'),
                content: const Text('You have successfully logged in.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      } else {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) =>
              AlertDialog(
                title: const Text('Login Failed'),
                content: const Text(
                    'Invalid email or password. Please try again.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final double screenWidth = screenSize.width;
    final double logoHeight = screenWidth * 0.2;
    final double verticalSpacing = screenWidth * 0.05;
    final double buttonPadding = screenWidth * 0.1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _logoAnimation,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'assets/image.png',
                  height: logoHeight,
                ),
              ),
            ),
            
            FadeTransition(
              opacity: _formAnimation,
              child: TextFormField(
                 controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: verticalSpacing),
            
            FadeTransition(
              opacity: _formAnimation,
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: verticalSpacing),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: buttonPadding),
              child: ScaleTransition(
                scale: _formAnimation,
                child: ElevatedButton(
                 onPressed: _login,
                  child: const Text('Login'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            
            ScaleTransition(
              scale: _formAnimation,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registration');
                },
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}