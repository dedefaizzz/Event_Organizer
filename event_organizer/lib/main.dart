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
      home: splashScreen(),
    );
  }
}
