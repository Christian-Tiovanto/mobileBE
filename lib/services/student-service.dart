import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_be/main.dart';
import 'package:mobile_be/model/studentmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentService {
  Future getStudentByClassId(String classId) async {
    print('classId di student service');
    print(classId);
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/student/class/$classId/all");
    try {
      print('ini di student service getstudentbyclassid');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.statusCode);
      print(jsonDecode(response.body));
      final data = jsonDecode(response.body)['data'];
      print('data di studentservice');
      print(data);
      if (response.statusCode == 200) {
        return List<Student>.from(
            data.map((student) => Student.fromJson(student)));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print('errorrrr');
      print(e);
      throw Exception(e.toString());
    }
  }

  Future getAllStudent() async {
    final prefs = await SharedPreferences.getInstance();
    final url =
        Uri.parse("http://$baseHost:$basePort/api/v1/student/all/student");
    try {
      print('ini di teacher service');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('jsonDecode(response.body) di getClass');
      print(response.statusCode);
      print(jsonDecode(response.body));
      final data = jsonDecode(response.body)['data'];
      if (response.statusCode == 200) {
        return List<Student>.from(
            data.map((student) => Student.fromJson(student)));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print('errorrrr di getallStudent');
      print(e);
      throw Exception(e.toString());
    }
  }

  Future updateStudentClassById(String studentUid, String classroom) async {
    final prefs = await SharedPreferences.getInstance();
    final url =
        Uri.parse("http://$baseHost:$basePort/api/v1/student/$studentUid");
    try {
      print('ini di teacher service');
      print(url);
      print(classroom);
      final response = await http.patch(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{"class_id": classroom}));
      print('response di teacher update');
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
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

  Future registerStudent(String name, String email, String password,
      String teacherId, String phoneNumber) async {
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/student/signup");
    try {
      print('ini di student service register');
      print(url);
      print(phoneNumber);
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "name": name,
            "email": email,
            "password": password,
            "user_id": teacherId,
            "phone_number": "$phoneNumber",
            "tahun_ajaran": '2023'
          }));
      print('response di teacher register');
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print('errorrrr di register student');
      print(e);
      throw Exception(e.toString());
    }
  }
}
