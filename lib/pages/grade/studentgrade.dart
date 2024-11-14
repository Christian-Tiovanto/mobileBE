import 'package:flutter/material.dart';
import 'package:mobile_be/pages/grade/grade_screen.dart';
import 'package:mobile_be/model/studentmodel.dart';
import 'package:mobile_be/services/student-service.dart';

class StudentGrade extends StatefulWidget {
  String lessonName;
  String class_id;
  StudentGrade({super.key, required this.lessonName, required this.class_id});

  @override
  State<StudentGrade> createState() => _StudentGradeState();
}

class _StudentGradeState extends State<StudentGrade> {
  final String teacherName = 'ini ntar fetch API'; // Add teacherName property

  Future<dynamic> getAllStudentByClassId() {
    final results = StudentService().getStudentByClassId('6A');
    print('results di grade');
    print(results);
    return results;
  }

  @override
  Widget build(BuildContext context) {
    final String lessonName = widget.lessonName;
    print('lessonName di studentgrade');
    print(lessonName);
    return Scaffold(
      appBar: AppBar(
        title: Text('$lessonName Grades'),
        backgroundColor: const Color.fromARGB(255, 231, 125, 11),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder(
              future: getAllStudentByClassId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error} has occured'),
                    );
                  } else if (snapshot.hasData) {
                    print('data di studentgrade');
                    final data = snapshot.data as List<Student>;
                    print(data);
                    print(lessonName);

                    return Expanded(
                      child: data.isEmpty
                          ? Center(
                              child: Text('No students found for $lessonName.'))
                          : ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final student = data[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  elevation: 4,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(16),
                                    title: Text(
                                      student.name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('ID: ${student.user_id}',
                                            style:
                                                const TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GradeScreen(
                                            student_uid: student.id,
                                            class_id: widget.class_id,
                                            lessonName: lessonName,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                    );
                  }
                }
                return Center(child: CircularProgressIndicator());
              }),
        ],
      ),
    );
  }
}
