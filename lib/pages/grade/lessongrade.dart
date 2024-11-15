import 'package:flutter/material.dart';
import 'package:mobile_be/pages/grade/grade_screen.dart';
import 'package:mobile_be/pages/grade/studentgrade.dart';
import 'package:mobile_be/model/studentmodel.dart';
import 'package:mobile_be/services/grade-service.dart';

class Subject {
  final String name;

  Subject({required this.name});
  factory Subject.fromJson(String name) {
    return Subject(name: name);
  }
}

class PickSubjectPage extends StatefulWidget {
  String classId;
  PickSubjectPage({super.key, required this.classId});

  @override
  State<PickSubjectPage> createState() => PickSubjectStatePage();
}

class PickSubjectStatePage extends State<PickSubjectPage> {
  List<Subject> SubjectList = [];
  Future<dynamic> getAllSubject() {
    final results = GradeService().getAllSubject();
    print('results di grade');
    print(results);
    return results;
  }

  @override
  void initState() {
    super.initState();
    getAllSubject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Student Grades'),
          backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        ),
        body: FutureBuilder(
            future: getAllSubject(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error} has occured'),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data as List<dynamic>;
                  print('data di picksubject');
                  print(data);
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final lesson = data[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        elevation: 4,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            lesson.name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentGrade(
                                  lessonName: lesson.name,
                                  class_id: widget.classId,
                                ),
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
            })

        // ListView.builder(
        //   itemCount: SubjectList.length,
        //   itemBuilder: (context, index) {
        //     final lesson = SubjectList[index];
        //     return Card(
        //       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        //       elevation: 4,
        //       child: ListTile(
        //         contentPadding: const EdgeInsets.all(16),
        //         title: Text(
        //           lesson.name,
        //           style:
        //               const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //         ),
        //         trailing: const Icon(Icons.arrow_forward_ios),
        //         onTap: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => StudentGrade(
        //                 lessonName: lesson.name,
        //               ),
        //             ),
        //           );
        //         },
        //       ),
        //     );
        //   },
        // ),
        );
    ;
  }
}
