import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/utils/decode-jwt.dart';
import 'package:mobile_be/widget/awesome-dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherService {
  Future login(String email, String password, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse("http://172.17.0.140:3006/api/v1/teacher/login");
    try {
      print('ini di teacher service');
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "type": "email",
            "email": email,
            "password": password
          }));
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

  Future getClass() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final tokenExist = prefs.containsKey('token');
    if (!tokenExist) throw Exception('log in first');
    print('decodeJwtPayload(token!)');
    final teacher_id = decodeJwtPayload(token!)['id'];
    final url = Uri.parse(
        "http://172.17.0.140:3006/api/v1/teacher/$teacher_id/class-teach");
    try {
      print('ini di teacher service');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.statusCode);
      print(jsonDecode(response.body));
      final data = jsonDecode(response.body)['data'];
      print('jsonDecode(response.body) di getClass');
      print(data['class_id']);
      if (response.statusCode == 200) {
        return {
          'class_id': data['class_id'].length != 0
              ? List<Classroom>.from(data['class_id']
                  .map((classroom) => Classroom.fromJson(classroom['_id'])))
              : [],
          'homeroom_class': data['homeroom_class'] != null
              ? Classroom.fromJson(data['homeroom_class']['_id'])
              : null
        };
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
