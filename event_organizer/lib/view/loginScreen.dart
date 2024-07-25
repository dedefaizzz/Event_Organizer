import 'package:event_organizer/auth/errorHandler.dart';
import 'package:event_organizer/controllers/loginControllers.dart';
import 'package:event_organizer/view/homePage.dart';
import 'package:event_organizer/view/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors/colors.dart';

class loginScreen extends StatefulWidget {
  final String email;
  final String password;

  loginScreen({required this.email, required this.password});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<loginScreen> {
  final loginController _logControllers = Get.put(loginController());

  void _signIn() {
    final email = _logControllers.emailController.text;
    final password = _logControllers.passwordController.text;

    String? errorHandler = ErrorHandler.validateLogin(
        email, password, widget.email, widget.password);

    if (errorHandler != null) {
      setState(() {
        errorHandler;
      });
      return;
    }

    _logControllers.loginWithEmail().then((value) {
      _showSuccessDialog('Silahkan Masuk Ke Aplikasi');
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _signUp() {
    Get.off(() => registerScreen());
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Successful'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.off(() => homePage());
              },
              child: Text('Ok'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _logControllers.emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      hintText: 'Enter your email',
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _logControllers.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none, // Remove the border
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      hintText: 'Enter your password',
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _signIn,
                        child: Text('Sign In'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _signUp,
                        child: const Text('Sign Up'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
