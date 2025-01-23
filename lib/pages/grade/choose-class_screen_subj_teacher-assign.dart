import 'package:flutter/material.dart';
import 'package:mobile_be/pages/Assignment/Assignment/assignment_list.dart';
import 'package:mobile_be/pages/grade/grade_screen-subj-teacher.dart';
import 'package:mobile_be/pages/grade/lessongrade.dart';
import 'package:mobile_be/services/teacher-service.dart';

class ChooseClassSubjTeacherAssignmentPage extends StatefulWidget {
  ChooseClassSubjTeacherAssignmentPage({super.key});

  @override
  State<ChooseClassSubjTeacherAssignmentPage> createState() =>
      _ChooseClassSubjTeacherAssignmentPageState();
}

class _ChooseClassSubjTeacherAssignmentPageState
    extends State<ChooseClassSubjTeacherAssignmentPage> {
  Future<dynamic> getAllTeacherClass() {
    final results = TeacherService().getClass();

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Class List'),
          backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        ),
        body: FutureBuilder(
            future: getAllTeacherClass(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error} has occured'),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data as Map<String, dynamic>;

                  return Center(
                    child: Column(
                      children: [
                        data['class_id'].length != 0
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: data['class_id'].length,
                                  itemBuilder: (context, index) {
                                    final classroom = data['class_id'][index];
                                    return Card(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      elevation: 4,
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        title: Text(
                                          classroom.id,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing:
                                            const Icon(Icons.arrow_forward_ios),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AssignmentList(
                                                        classroomId:
                                                            classroom.id,
                                                      )));
                                        },
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Text('you are not a homeroom teacher'),
                      ],
                    ),
                  );
                }
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
