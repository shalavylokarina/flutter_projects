import 'package:flutter/material.dart';
class ProfilePage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProfilePage({Key? key});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    final double avatarRadius = screenHeight * 0.08;
    final double userNameFontSize = screenWidth * 0.06;
    final double emailFontSize = screenWidth * 0.045;
    final double buttonPaddingVertical = screenHeight * 0.04;
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person,
                  size: avatarRadius * 0.8,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Text(
                'Shalavylo Karina',
                style: TextStyle(
                  fontSize: userNameFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'shalavylokarina@gmail.com',
                style: TextStyle(
                  fontSize: emailFontSize,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(vertical: buttonPaddingVertical),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  },
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}