import 'package:event_organizer/colors/colors.dart';
import 'loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
      backgroundColor: AppColors.secondColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Lottie.asset(
                  'assets/animation_splash_screen.json',
                  width: 150,
                  height: 150,
                  repeat: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
