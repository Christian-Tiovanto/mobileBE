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
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/assignment/class/$classId");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body)['data'];

      if (response.statusCode == 200) {
        return List<Assignment>.from(
            data.map((assignment) => Assignment.fromJson(assignment)));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Assignment>> getAllStudentAssignment() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final tokenExist = prefs.containsKey('token');
    if (!tokenExist) throw Exception('log in first');

    final studentId = decodeJwtPayload(token!)['id'];
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/submission/student/$studentId");

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body)['data'];

      if (response.statusCode == 200) {
        return List<Assignment>.from(
            data.map((assignment) => Assignment.fromJson(assignment)));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Submission>> getAllSubmissionByAssignmentId(
      String assignmentId) async {
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/submission/assignment/$assignmentId/all");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body)['data'];

      if (response.statusCode == 200) {
        return List<Submission>.from(
            data.map((submission) => Submission.fromJson(submission)));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future createAssignment(Assignment assignmentDto, String? image) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final tokenExist = prefs.containsKey('token');
    if (!tokenExist) throw Exception('log in first');
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/assignment");
    try {
      final request = await http.MultipartRequest('POST', url);
      request.headers.addAll({
        'Authorization': 'Bearer $token', // Set the token here
        'Content-Type': 'multipart/form-data',
      });
      if (image != null) {
        final pic = await http.MultipartFile.fromPath('photo', image);
        request.files.add(pic);
      }

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
      throw Exception(e.toString());
    }
  }

  Future submitSubmission(String assignmentId, String? image) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final tokenExist = prefs.containsKey('token');
    if (!tokenExist) throw Exception('log in first');

    final studentId = decodeJwtPayload(token!)['id'];
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/submission/submit/assignment/$assignmentId/student/$studentId");
    try {
      final request = await http.MultipartRequest('PATCH', url);
      if (image != null) {
        final pic = await http.MultipartFile.fromPath('photo', image);
        request.files.add(pic);
      }

      final response = await request.send();
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('error update image');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future updateSubmissionScore(Submission submissionDto, int score) async {
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/submission/${submissionDto.submission_id}/score");
    try {
      final response = await http.patch(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{'score': score}));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('error update image');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
    } else {}
  }

  Future getAssignmentAttachment(Assignment assignmentDto) async {
    await requestStoragePermission();
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/assignment/${assignmentDto.assignment_id}/file");
    try {
      final response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        final directory = await getExternalStorageDirectory();
        final filePath =
            '/storage/emulated/0/Download/${assignmentDto.attachedFiles}';

        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
      } else {
        throw 'ea';
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
