import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_be/main.dart';
import 'package:mobile_be/model/studentmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentService {
  Future getStudentByClassId(String classId) async {
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/student/class/$classId/all");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body)['data'];

      if (response.statusCode == 200) {
        return List<Student>.from(
            data.map((student) => Student.fromJson(student)));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getStudentByUserId(String userId) async {
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/student/$userId");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body)['data'];

      if (response.statusCode == 200) {
        return Student.fromJson(data);
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getAllStudent() async {
    final prefs = await SharedPreferences.getInstance();
    final url =
        Uri.parse("http://$baseHost:$basePort/api/v1/student/all/student");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body)['data'];
      if (response.statusCode == 200) {
        return List<Student>.from(
            data.map((student) => Student.fromJson(student)));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future updateStudentClassById(String studentUid, String classroom) async {
    final prefs = await SharedPreferences.getInstance();
    final url =
        Uri.parse("http://$baseHost:$basePort/api/v1/student/$studentUid");
    try {
      final response = await http.patch(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{"class_id": classroom}));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future registerStudent(String name, String email, String password,
      String teacherId, String phoneNumber) async {
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/student/signup");
    try {
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

      if (response.statusCode == 200) {
        return true;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future login(String email, String password, String for_type) async {
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/student/login");
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "type": "email",
            "email": email,
            "password": password,
            'for_type': for_type
          }));

      if (response.statusCode == 200) {
        await prefs.setString("token", jsonDecode(response.body)['token']);

        return true;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future updateStudentPhoto(String studentId, File image) async {
    final url =
        Uri.parse("http://$baseHost:$basePort/api/v1/student/$studentId/photo");
    try {
      final request = await http.MultipartRequest('PATCH', url);
      final pic = await http.MultipartFile.fromPath('photo', image.path);

      request.files.add(pic);
      final response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('error update image');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
