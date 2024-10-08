import 'dart:convert';

import 'package:event_organizer/utils/apiEndpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class registerControllers extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          apiEndpoint.baseUrl + apiEndpoint.authEndpoint.registerEmail);
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.headers['content-type']!.contains('application/json')) {
        final json = jsonDecode(response.body);
        if (response.statusCode == 200) {
          if (json['code'] == 0) {
            var token = json['data']['Token'];
            print(token);
            final SharedPreferences? prefs = await _prefs;
            await prefs?.setString('token', token);
            emailController.clear();
            passwordController.clear();
          } else {
            throw json["Message"] ?? "Unknown Error Occurred";
          }
        } else {
          throw json["Message"] ?? "Unknown Error Occurred";
        }
      } else {
        throw "Unexpected server response";
      }
    } catch (e) {
      Get.back();
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [Text(e.toString())],
          );
        },
      );
    }
  }
}
