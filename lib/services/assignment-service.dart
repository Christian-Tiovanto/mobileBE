import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_be/main.dart';
import 'package:mobile_be/model/assignment.dart';
import 'package:mobile_be/model/attendance-model.dart';
import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/model/studentmodel.dart';
import 'package:mobile_be/utils/decode-jwt.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignmentService {
  Future<List<Assignment>> getAllAssignmentByClassId(String classId) async {
    print('classId di assignment service');
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/assignment/class/$classId");
    try {
      print('ini di assignment service getAllAssignmentByClassId');
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
        return List<Assignment>.from(
            data.map((assignment) => Assignment.fromJson(assignment)));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print('errorrrr');
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<List<Assignment>> getAllStudentAssignment() async {
    print('getAllStudentAssignment');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final tokenExist = prefs.containsKey('token');
    if (!tokenExist) throw Exception('log in first');
    print('decodeJwtPayload(token!)');
    final studentId = decodeJwtPayload(token!)['id'];
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/assignment/student/$studentId");
    try {
      print('ini di assignment service getAllStudentAssignment');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.statusCode);
      print(jsonDecode(response.body));
      final data = jsonDecode(response.body)['data'];
      print("bener kan ini");
      print(data);
      if (response.statusCode == 200) {
        return List<Assignment>.from(
            data.map((assignment) => Assignment.fromJson(assignment)));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print('errorrrr');
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<List<Submission>> getAllSubmissionByAssignmentId(
      String assignmentId) async {
    print('classId di assignment service');
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/submission/assignment/$assignmentId/all");
    try {
      print('ini di assignment service getAllSubmissionByAssignmentId');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.statusCode);
      print(jsonDecode(response.body));
      final data = jsonDecode(response.body)['data'];
      print('data di assignmentService');
      print(data);
      print("bener kan ini");
      if (response.statusCode == 200) {
        return List<Submission>.from(
            data.map((submission) => Submission.fromJson(submission)));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print('errorrrr');
      print(e);
      throw Exception(e.toString());
    }
  }

  Future createAssignment(Assignment assignmentDto, String? image) async {
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/assignment");
    try {
      print('ini di assignmentService createAssignment');
      print(url);
      final request = await http.MultipartRequest('POST', url);
      if (image != null) {
        final pic = await http.MultipartFile.fromPath('photo', image);
        request.files.add(pic);
      }
      print('response di createAssignment');
      request.fields.addAll({
        'due_date': '${assignmentDto.dueDate}',
        'class_id': '${assignmentDto.class_id}',
        'title': assignmentDto.title,
        'description': assignmentDto.description,
        'tahun_ajaran': '2023'
      });
      final response = await request.send();
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('error update image');
      }
    } catch (e) {
      print('errorrrr di createAssignment');
      print(e);
      throw Exception(e.toString());
    }
  }

  Future submitSubmission(String assignmentId, String? image) async {
    print('submitSubmission');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final tokenExist = prefs.containsKey('token');
    if (!tokenExist) throw Exception('log in first');
    print('decodeJwtPayload(token!)');
    final studentId = decodeJwtPayload(token!)['id'];
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/submission/submit/assignment/$assignmentId/student/$studentId");
    try {
      print('ini di assignmentService submitSubmission');
      print(url);
      final request = await http.MultipartRequest('PATCH', url);
      if (image != null) {
        print('masok ke dalam image gak seh');
        final pic = await http.MultipartFile.fromPath('photo', image);
        request.files.add(pic);
      }
      print('response di submitSubmission');
      final response = await request.send();
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('error update image');
      }
    } catch (e) {
      print('errorrrr di submitSubmission');
      print(e);
      throw Exception(e.toString());
    }
  }

  Future updateSubmissionScore(Submission submissionDto, int score) async {
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/submission/${submissionDto.submission_id}/score");
    try {
      print('ini di assignmentService updateSubmissionScore');
      final response = await http.patch(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{'score': score}));
      print(response.statusCode);
      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('error update image');
      }
    } catch (e) {
      print('errorrrr di createAssignment');
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<void> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      print('Storage permission granted');
    } else {
      print('Storage permission denied');
    }
  }

  Future getAssignmentAttachment(Assignment assignmentDto) async {
    await requestStoragePermission();
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/assignment/${assignmentDto.assignment_id}/file");
    try {
      print('ini di assignment service getAssignmentAttacahment');
      final response = await http.get(
        url,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final directory = await getExternalStorageDirectory();
        final filePath =
            '/storage/emulated/0/Download/${assignmentDto.attachedFiles}';

        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        print('file Downloaded to $filePath');
      } else {
        throw 'ea';
      }
    } catch (e) {
      print('errorrrr');
      print(e);
      throw Exception(e.toString());
    }
  }
}
