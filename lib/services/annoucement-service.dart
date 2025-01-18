import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_be/main.dart';
import 'package:mobile_be/model/assignment.dart';
import 'package:mobile_be/model/attendance-model.dart';
import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/model/studentmodel.dart';
import 'package:mobile_be/pages/announcement/ann_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AnnouncementService {
  // Future<List<Assignment>> getAllAssignmentByClassId(String classId) async {
  //   print('classId di assignment service');
  //   final url = Uri.parse(
  //       "http://$baseHost:$basePort/api/v1/assignment/class/$classId");
  //   try {
  //     print('ini di assignment service getAllAssignmentByClassId');
  //     final response = await http.get(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //     print(response.statusCode);
  //     print(jsonDecode(response.body));
  //     final data = jsonDecode(response.body)['data'];
  //     print('data di classroom service');
  //     print(data);
  //     print("bener kan ini");
  //     if (response.statusCode == 200) {
  //       return List<Assignment>.from(
  //           data.map((assignment) => Assignment.fromJson(assignment)));
  //     } else {
  //       throw jsonDecode(response.body)['message'];
  //     }
  //   } catch (e) {
  //     print('errorrrr');
  //     print(e);
  //     throw Exception(e.toString());
  //   }
  // }

  // Future<List<Submission>> getAllSubmissionByAssignmentId(
  //     String assignmentId) async {
  //   print('classId di assignment service');
  //   final url = Uri.parse(
  //       "http://$baseHost:$basePort/api/v1/submission/assignment/$assignmentId/all");
  //   try {
  //     print('ini di assignment service getAllSubmissionByAssignmentId');
  //     final response = await http.get(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //     print(response.statusCode);
  //     print(jsonDecode(response.body));
  //     final data = jsonDecode(response.body)['data'];
  //     print('data di assignmentService');
  //     print(data);
  //     print("bener kan ini");
  //     if (response.statusCode == 200) {
  //       return List<Submission>.from(
  //           data.map((submission) => Submission.fromJson(submission)));
  //     } else {
  //       throw jsonDecode(response.body)['message'];
  //     }
  //   } catch (e) {
  //     print('errorrrr');
  //     print(e);
  //     throw Exception(e.toString());
  //   }
  // }

  Future createAnnouncement(Announcement announcementDto, String? image) async {
    final url = Uri.parse("http://$baseHost:$basePort/api/v1/announcement");
    try {
      print('ini di announcementService createAnnouncement');
      print(url);
      final request = await http.MultipartRequest('POST', url);
      if (image != null) {
        final pic = await http.MultipartFile.fromPath('photo', image);
        request.files.add(pic);
      }
      print('response di createAnnouncement');
      request.fields.addAll({
        'date': '${announcementDto.date}',
        'title': announcementDto.title,
        'description': announcementDto.description,
      });
      final response = await request.send();
      if (response.statusCode == 201) {
        print('response.stream.bytesToString()');
        final body = jsonDecode(await response.stream.bytesToString());
        return body['data']['_id'];
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

  // Future getAssignmentAttachment(Announcement announcementDto) async {
  //   await requestStoragePermission();
  //   final url = Uri.parse(
  //       "http://$baseHost:$basePort/api/v1/assignment/${announcementDto.id}/file");
  //   try {
  //     print('ini di assignment service getAssignmentAttacahment');
  //     final response = await http.get(
  //       url,
  //     );
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       final directory = await getExternalStorageDirectory();
  //       final filePath =
  //           '/storage/emulated/0/Download/${announcementDto.attachedFiles}';

  //       final file = File(filePath);
  //       await file.writeAsBytes(response.bodyBytes);
  //       print('file Downloaded to $filePath');
  //     } else {
  //       throw 'ea';
  //     }
  //   } catch (e) {
  //     print('errorrrr');
  //     print(e);
  //     throw Exception(e.toString());
  //   }
  // }
}
