import 'package:flutter/material.dart';
class RegistrationPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RegistrationPage({Key? key});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final double screenWidth = screenSize.width;
    final double verticalSpacing = screenWidth * 0.05;
    final double buttonPadding = screenWidth * 0.1;
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: verticalSpacing),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: verticalSpacing),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: verticalSpacing),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: buttonPadding),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
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