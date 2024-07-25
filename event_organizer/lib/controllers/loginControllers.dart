import 'dart:convert';

import 'package:event_organizer/utils/apiEndpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class loginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url =
          Uri.parse(apiEndpoint.baseUrl + apiEndpoint.authEndpoint.loginEmail);
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        try {
          final json = jsonDecode(response.body);
          if (json['code'] == 0) {
            var token = json['data']['Token'];
            final SharedPreferences? prefs = await _prefs;
            await prefs?.setString('token', token);

            emailController.clear();
            passwordController.clear();
          } else if (json['code'] == 1) {
            throw jsonDecode(response.body)['message'];
          }
        } catch (e) {
          throw 'Invalid JSON response';
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? "unknown Error Occured";
      }
    } catch (error) {
      Get.back();
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [Text(error.toString())],
          );
        },
      );
    }
  }
}
