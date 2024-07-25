import 'package:event_organizer/colors/colors.dart';
import 'loginScreen.dart';
import 'package:flutter/material.dart';

class splashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<splashScreen> {
  final String _email = '';
  final String _password = '';

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 3000));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => loginScreen(
                email: _email,
                password: _password,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/icon_event_organizer.jpg',
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
