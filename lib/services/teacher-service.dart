import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_be/widget/awesome-dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherService {
  Future login(String name, String password, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse("http://172.17.0.140:3006/api/v1/teacher/login");
    try {
      print('ini di teacher service');
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{"user_id": name, "password": password}));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        prefs.setString("token", jsonDecode(response.body)['token']);
        print("eaaaa");
        return true;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print('errorrrr');
      print(e);
      throw Exception(e.toString());
    }
  }
}
