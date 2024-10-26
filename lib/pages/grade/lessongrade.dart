import 'package:flutter/material.dart';
import 'package:mobile_be/pages/grade/grade_screen.dart'; 
import 'package:mobile_be/pages/grade/studentgrade.dart';
import 'package:mobile_be/pages/grade/studentmodel.dart';

class Lesson {
  final String name;
  final String teacher;

  Lesson({required this.name, required this.teacher});
}

class LessonGrade extends StatelessWidget {
  final List<Lesson> lessons = [
    Lesson(name: 'Mathematics', teacher: 'Mr. Smith'),
    Lesson(name: 'Science', teacher: 'Mrs. Johnson'),
    Lesson(name: 'Religion', teacher: 'Ms. Davis'),
    Lesson(name: 'Art', teacher: 'Mr. Brown'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Grades'),
        backgroundColor: const Color.fromARGB(255, 231, 125, 11),
      ),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                lesson.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentGrade(
                      lessonName: lesson.name,
                      teacherName: lesson.teacher,
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
