import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_be/pages/grade/lessongrade.dart';

class GradeService {
  Future getAllSubject() async {
    final url = Uri.parse('http://172.17.0.140:3006/api/v1/grade/subject');
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
}
