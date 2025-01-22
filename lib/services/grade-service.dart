import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_be/main.dart';
import 'package:mobile_be/model/grade-model.dart';
import 'package:mobile_be/pages/grade/lessongrade.dart';
import 'package:mobile_be/utils/decode-jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future getAllGradeByClassNPopulate(String classId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final tokenExist = prefs.containsKey('token');
    if (!tokenExist) throw Exception('log in first');
    final url = Uri.parse(
        'http://$baseHost:$basePort/api/v1/grade/class/$classId/teacher-teach');
    try {
      print('ini di grade service getAllGradeByClassNPopulate');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      final Map<String, dynamic> tes = {'a': 1};
      print('jsonDecode(response.body) di getAllGradeByClassNPopulate');
      print(jsonDecode(response.body)['data']);
      print(tes);
      List<dynamic> data = jsonDecode(response.body)['data'];
      if (response.statusCode == 200) {
        if (data is List) {
          if (data.every((element) => element is Map<String, dynamic>)) ;
        }
        return data;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print('error di get student grade');
      print(e);
      throw Exception(e.toString());
    }
  }

  Future updateGradeScoreBulk(List<dynamic> updateGradeScoreBulkDto) async {
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/grade/score/bulk");
    try {
      print('ini di attendance service updateGradeScoreBulk');
      print(updateGradeScoreBulkDto);
      final response = await http.patch(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{'data': updateGradeScoreBulkDto}));
      print(response.statusCode);
      print(jsonDecode(response.body));
      final data = jsonDecode(response.body)['data'];
      print('data di attendance service');
      print(data);
      print("bener kan ini");
      if (response.statusCode == 200) {
        return true;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print('errorrrr');
      print(e);
      throw e.toString();
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

  Future getStudentNItsGradeLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final tokenExist = prefs.containsKey('token');
    if (!tokenExist) throw Exception('log in first');
    final url = Uri.parse('http://$baseHost:$basePort/api/v1/grade/my-grade');
    try {
      print('ini di grade service getStudentGrade');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
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

  Future createEmptyGradeBulk(String class_id, String teacherId) async {
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/grade/bulk");
    try {
      print('ini di classroom service createEmptyGradeBulk');
      print(class_id);
      print(teacherId);
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
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

  Future createEmptyGrade(String class_id, String userId) async {
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/grade");
    try {
      print('ini di classroom service createEmptyGradeBulk');
      print(class_id);
      print(userId);
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "tahun_ajaran": "2023",
            "class_id": class_id,
            'user_id': userId
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

  Future createSubject(String subjectName) async {
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/subject");
    try {
      print('ini di subject service createsubject');
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{'_id': subjectName}));
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
