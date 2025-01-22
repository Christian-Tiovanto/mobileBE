import 'package:flutter/material.dart';
import 'package:mobile_be/pages/grade/lessongrade.dart';
import 'package:mobile_be/services/teacher-service.dart';

class ChooseClassPage extends StatefulWidget {
  const ChooseClassPage({super.key});

  @override
  State<ChooseClassPage> createState() => _ChooseClassPageState();
}

class _ChooseClassPageState extends State<ChooseClassPage> {
  Future<dynamic> getAllTeacherClass() {
    final results = TeacherService().getClass();
    print('results di get class teacher');
    print(results);
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
                  print("data['class_id']");
                  print(data['class_id']);
                  return Center(
                    child: Column(
                      children: [
                        data['homeroom_class'] != null
                            ? Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                elevation: 4,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  title: Text(
                                    data['homeroom_class'].id,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PickSubjectPage(
                                                    classId:
                                                        data['homeroom_class']
                                                            .id)));
                                  },
                                ),
                              )
                            : Text('You dont Teach any class'),
                      ],
                    ),
                  );
                }
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
