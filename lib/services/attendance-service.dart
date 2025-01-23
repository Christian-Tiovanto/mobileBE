import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_be/main.dart';
import 'package:mobile_be/model/attendance-model.dart';
import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/model/studentmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceService {
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

  Future getAttendanceCount(
      String userId, String classId, String status) async {
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/attendance/student/$userId/class/$classId/tahun/2023/status/$status");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body)['data'];

      if (response.statusCode == 200) {
        return data;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getAttendanceCountStudent(String status) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final tokenExist = prefs.containsKey('token');
    if (!tokenExist) throw Exception('log in first');
    final url = Uri.parse(
        "http://$baseHost:$basePort/api/v1/attendance/my-attendance-count/status/$status");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      final data = jsonDecode(response.body)['data'];

      if (response.statusCode == 200) {
        return data;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getAttendanceByStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final tokenExist = prefs.containsKey('token');
    if (!tokenExist) throw Exception('log in first');
    final url =
        Uri.parse("http://$baseHost:$basePort/api/v1/attendance/my-attendance");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      final data = jsonDecode(response.body)['data'];

      if (response.statusCode == 200) {
        return List<Attendance>.from(
            data.map((attendance) => Attendance.fromJson(attendance)));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future createBulkAttendance(
      List<Map<String, dynamic>> attendanceBulkDto) async {
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/attendance/bulk");
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{'data': attendanceBulkDto}));

      final data = jsonDecode(response.body)['data'];

      if (response.statusCode == 201) {
        return true;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
