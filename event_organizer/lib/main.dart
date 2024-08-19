import 'package:event_organizer/controllers/loginControllers.dart';
import 'package:event_organizer/view/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/splashScreen.dart';
import 'database/data.dart';

void main() {
  runApp(MyApp());
  addInitialEvents();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ivent',
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data == true) {
              return homePage();
            } else {
              return splashScreen();
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    final loginCtrl = Get.put(loginController());
    return await loginCtrl.isLoggedIn();
  }
}
