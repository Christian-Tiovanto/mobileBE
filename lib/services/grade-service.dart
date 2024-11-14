import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_be/main.dart';
import 'package:mobile_be/model/grade-model.dart';
import 'package:mobile_be/pages/grade/lessongrade.dart';

class GradeService {
  Future getAllSubject() async {
    final url = Uri.parse('http://$baseHost:$basePort/api/v1/grade/subject');
    try {
      print('ini di grade service getAllSubject');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return List<Subject>.from(jsonDecode(response.body)['data']
            .map((value) => Subject.fromJson(value)));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getStudentGrade(
      String userId, String subject, String classroom) async {
    final url = Uri.parse(
        'http://$baseHost:$basePort/api/v1/grade/$userId/subject/$subject/class/$classroom/tahun/2023');
    try {
      print('ini di grade service getStudentGrade');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('jsonDecode(response.body) di gradestudent');
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        return Grade.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print('error di get student grade');
      print(e);
      throw Exception(e.toString());
    }
  }
}
