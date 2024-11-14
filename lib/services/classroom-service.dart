import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_be/main.dart';
import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/model/studentmodel.dart';

class ClassroomService {
  Future getAllClassroom() async {
    print('classId di student service');
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/classroom/all");
    try {
      print('ini di classroom service getAllClassroom');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.statusCode);
      print(jsonDecode(response.body));
      final data = jsonDecode(response.body)['data'];
      print('data di classroom service');
      print(data);
      print("bener kan ini");
      if (response.statusCode == 200) {
        return List<Classroom>.from(
            data.map((classr) => Classroom.fromJson(classr['_id'])));
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
