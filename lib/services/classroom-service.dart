import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_be/main.dart';
import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/model/studentmodel.dart';

class ClassroomService {
  Future getAllClassroom() async {
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/classroom/all");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body)['data'];

      if (response.statusCode == 200) {
        return List<Classroom>.from(
            data.map((classr) => Classroom.fromJson(classr['_id'])));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future createClassroom(String classroomName) async {
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/classroom");
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{'_id': classroomName}));

      final data = jsonDecode(response.body)['data'];

      if (response.statusCode == 201) {
        return true;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
