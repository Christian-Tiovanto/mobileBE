import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_be/main.dart';
import 'package:mobile_be/model/studentmodel.dart';

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
}
