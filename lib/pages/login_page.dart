import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  
  // ignore: use_key_in_widget_constructors
  const LoginPage({Key? key});
  @override
 
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _formAnimation;
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
    _controller.forward();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
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
            // Email field
            FadeTransition(
              opacity: _formAnimation,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: verticalSpacing),
            // Password field
            FadeTransition(
              opacity: _formAnimation,
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: verticalSpacing),
            // Login button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: buttonPadding),
              child: ScaleTransition(
                scale: _formAnimation,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('Login'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Registration button
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