import 'package:flutter/material.dart';
import 'package:mobile_be/pages/grade/grade_screen.dart';
import 'package:mobile_be/pages/grade/studentgrade.dart';
import 'package:mobile_be/pages/grade/studentmodel.dart';
import 'package:mobile_be/services/grade-service.dart';

class Subject {
  final String name;

  Subject({required this.name});
  factory Subject.fromJson(String name) {
    return Subject(name: name);
  }
}

class PickSubjectPage extends StatefulWidget {
  const PickSubjectPage({super.key});

  @override
  State<PickSubjectPage> createState() => PickSubjectStatePage();
}

class PickSubjectStatePage extends State<PickSubjectPage> {
  List<Subject> SubjectList = [];
  void getAllSubject() async {
    try {
      final results = await GradeService().getAllSubject();
      print('results di grade');
      print(results);
      setState(() {
        SubjectList = results;
      });
    } catch (error) {
      print('error di PickSubjectStatePage');
      print(error);
    }
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
      body: ListView.builder(
        itemCount: SubjectList.length,
        itemBuilder: (context, index) {
          final lesson = SubjectList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                lesson.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentGrade(
                      lessonName: lesson.name,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
    ;
  }
}
