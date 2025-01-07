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

  Future getStudentNItsGrade(String userId, String classroom) async {
    final url = Uri.parse(
        'http://$baseHost:$basePort/api/v1/grade/$userId/class/$classroom/tahun/2023');
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
      final data = jsonDecode(response.body)['data'];
      if (response.statusCode == 200) {
        return List<Grade>.from(data.map((grade) => Grade.fromJson(grade)));
        // Grade.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print('error di get studentNItsgrade');
      print(e);
      throw Exception(e.toString());
    }
  }

  Future createEmptyGradeBulk(
      String subject, String class_id, String teacherId) async {
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/grade/bulk");
    try {
      print('ini di classroom service createEmptyGradeBulk');
      print(subject);
      print(class_id);
      print(teacherId);
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'subject': subject,
            "tahun_ajaran": "2023",
            "class_id": class_id,
            'teacher_id': teacherId
          }));
      print(response.statusCode);
      print(jsonDecode(response.body));
      final data = jsonDecode(response.body)['data'];
      print('data di classroom service');
      print(data);
      print("bener kan ini");
      if (response.statusCode == 201) {
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
