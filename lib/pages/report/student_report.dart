import 'package:flutter/material.dart';
import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/model/studentmodel.dart';
import 'package:mobile_be/model/teachermodel.dart';
import 'package:mobile_be/pages/report/grade_report.dart';
import 'package:mobile_be/services/student-service.dart';
import 'package:mobile_be/services/teacher-service.dart';
import 'package:mobile_be/utils/decode-jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentReport extends StatefulWidget {
  const StudentReport({super.key});

  @override
  State<StudentReport> createState() => _StudentReportState();
}

class _StudentReportState extends State<StudentReport> {
  List<Student> students = [
    Student(
      id: '1',
      user_id: '1',
      class_id: Classroom(id: '6A'),
      name: 'Angela Yang',
    ),
  ];
  Map<String, dynamic>? _jwtPayload;

  Future<dynamic> getAllStudent() async {
    final _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString('token');
    if (token == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }
    _jwtPayload = decodeJwtPayload(token);
    final Teacher teacher =
        await TeacherService().getTeacherById(_jwtPayload!['id']);

    final results =
        await StudentService().getStudentByClassId(teacher.homeroom_class!.id);

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Student Report'),
          backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        ),
        body: FutureBuilder(
            future: getAllStudent(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error} has occured'),
                  );
                } else if (snapshot.hasData) {
                  students = snapshot.data;
                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            student.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('ID: ${student.user_id}'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    GradeReport(student: student),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
