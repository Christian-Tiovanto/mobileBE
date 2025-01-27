import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_be/main.dart';
import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/model/teachermodel.dart';
import 'package:mobile_be/pages/grade/lessongrade.dart';
import 'package:mobile_be/utils/decode-jwt.dart';
import 'package:mobile_be/widget/awesome-dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherService {
  Future login(String email, String password, String for_type) async {
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/teacher/login");
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

  Future getClass() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final tokenExist = prefs.containsKey('token');
    if (!tokenExist) throw Exception('log in first');

    final teacher_id = decodeJwtPayload(token!)['id'];
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/teacher/$teacher_id/class-teach");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body)['data'];

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
      throw Exception(e.toString());
    }
  }

  Future getAllTeacher() async {
    final prefs = await SharedPreferences.getInstance();
    final url =
        Uri.parse("http://$baseHost:$basePort/api/v1/teacher/all/teacher");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body)['data'];

      if (response.statusCode == 200) {
        return List<Teacher>.from(
            data.map((teacher) => Teacher.fromJson(teacher)));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getTeacherById(String teacherId) async {
    final prefs = await SharedPreferences.getInstance();
    final url =
        Uri.parse("http://$baseHost:$basePort/api/v1/teacher/$teacherId");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body)['data'];

      if (response.statusCode == 200) {
        return Teacher.fromJson(data);
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future updateTeacheTeachNClass(String teacherUid, List<dynamic> classroom,
      String? subject, dynamic homeroomClassroom) async {
    final prefs = await SharedPreferences.getInstance();
    final url =
        Uri.parse("http://$baseHost:$basePort/api/v1/teacher/$teacherUid");
    try {
      final response = await http.patch(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "subject_teach": subject,
            "class_id": classroom,
            'homeroom_class': homeroomClassroom
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

  Future registerTeacher(String name, String email, String password,
      String teacherId, String phoneNumber) async {
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/teacher/signup");
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
            "enrollment_date": '2024-01-01'
          }));

      if (response.statusCode == 201) {
        return true;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future updateTeacherPhoto(String teacherId, File image) async {
    final url =
        Uri.parse("http://$baseHost:$basePort/api/v1/teacher/$teacherId/photo");
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
