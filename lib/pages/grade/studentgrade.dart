import 'package:flutter/material.dart';
import 'package:mobile_be/pages/grade/grade_screen.dart';
import 'package:mobile_be/pages/grade/studentmodel.dart';

class StudentGrade extends StatelessWidget {
  final String lessonName;
  final String teacherName; // Add teacherName property

  StudentGrade({Key? key, required this.lessonName, required this.teacherName}) : super(key: key);

  final List<Student> students = [
    Student(
      name: 'Angela Yang',
      studentID: 'ST00001',
      subject: 'Science',
      assignmentScore: 80,
      midTermScore: 85,
      semesterScore: 90,
    ),
    Student(
      name: 'Angela Yang',
      studentID: 'ST00001',
      subject: 'Mathematics',
      assignmentScore: 80,
      midTermScore: 85,
      semesterScore: 90,
    ),
    Student(
      name: 'Cherrilyn',
      studentID: 'ST00003',
      subject: 'Science',
      assignmentScore: 80,
      midTermScore: 85,
      semesterScore: 90,
    ),
    Student(
      name: 'Benaro',
      studentID: 'ST00002',
      subject: 'Mathematics',
      assignmentScore: 75,
      midTermScore: 80,
      semesterScore: 88,
    ),
    Student(
      name: 'Benaro',
      studentID: 'ST00002',
      subject: 'Art',
      assignmentScore: 75,
      midTermScore: 80,
      semesterScore: 88,
    ),
    Student(
      name: 'Cherrilyn',
      studentID: 'ST00003',
      subject: 'Religion',
      assignmentScore: 78,
      midTermScore: 82,
      semesterScore: 85,
    ),
    Student(
      name: 'Davin Alvaro',
      studentID: 'ST00004',
      subject: 'Art',
      assignmentScore: 92,
      midTermScore: 89,
      semesterScore: 95,
    ),
    Student(
      name: 'Davin Alvaro',
      studentID: 'ST00004',
      subject: 'Religion',
      assignmentScore: 92,
      midTermScore: 89,
      semesterScore: 95,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredStudents = students.where((student) => student.subject == lessonName).toList();

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
              'Teacher: $teacherName',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: filteredStudents.isEmpty
                ? Center(child: Text('No students found for $lessonName.'))
                : ListView.builder(
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      final student = filteredStudents[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        elevation: 4,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            student.name,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ID: ${student.studentID}', style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GradeScreen(student: student),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
