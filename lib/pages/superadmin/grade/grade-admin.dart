import 'package:flutter/material.dart';
import 'package:mobile_be/pages/grade/lessongrade.dart';
import 'package:mobile_be/services/classroom-service.dart';
import 'package:mobile_be/services/grade-service.dart';
import 'package:mobile_be/services/teacher-service.dart';
import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/model/teachermodel.dart';

class GradeAdminPage extends StatefulWidget {
  @override
  _GradeAdminPageState createState() => _GradeAdminPageState();
}

class _GradeAdminPageState extends State<GradeAdminPage> {
  String? selectedSubject;
  String? selectedClassroom;
  String? selectedTeacher;

  // API calls
  Future<List<Subject>> getAllSubject() async {
    final results = await GradeService().getAllSubject();
    print('Results from GradeService.getAllSubject: $results');
    return results; // Assuming this returns a list of subjects as strings
  }

  Future<List<Classroom>> getAllClassroom() async {
    final response = await ClassroomService().getAllClassroom();
    print('Results from ClassroomService.getAllClassroom: $response');
    return response; // Assuming this returns a list of Classroom objects
  }

  Future<List<Teacher>> getAllTeacher() async {
    final results = await TeacherService().getAllTeacher();
    print('Results from TeacherService.getAllTeacher: $results');
    return results; // Assuming this returns a list of Teacher objects
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Dropdown Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('Select Classroom:', style: TextStyle(fontSize: 18)),
              FutureBuilder<List<Classroom>>(
                future: getAllClassroom(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error loading classrooms');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No classrooms available');
                  } else {
                    return DropdownButton<String>(
                      value: selectedClassroom,
                      hint: Text('Select Classroom'),
                      onChanged: (value) {
                        setState(() {
                          selectedClassroom = value;
                        });
                      },
                      items: snapshot.data!.map((classroom) {
                        return DropdownMenuItem<String>(
                          value: classroom
                              .id, // Assuming Classroom has an 'id' property
                          child: Text(classroom
                              .id), // Assuming Classroom has a 'name' property
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              Text('Select Teacher:', style: TextStyle(fontSize: 18)),
              FutureBuilder<List<Teacher>>(
                future: getAllTeacher(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error loading teachers');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No teachers available');
                  } else {
                    return DropdownButton<String>(
                      value: selectedTeacher,
                      hint: Text('Select Teacher'),
                      onChanged: (value) {
                        setState(() {
                          selectedTeacher = value;
                        });
                      },
                      items: snapshot.data!.map((teacher) {
                        return DropdownMenuItem<String>(
                          value: teacher
                              .id, // Assuming Teacher has an 'id' property
                          child: Text(teacher
                              .name), // Assuming Teacher has a 'name' property
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      print('selectedClassroom');
                      print(selectedClassroom);
                      print(selectedTeacher);
                      await GradeService().createEmptyGradeBulk(
                          '$selectedClassroom', '${selectedTeacher}');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Code to execute when 'Undo' is pressed
                              print('Undo action');
                            },
                          ),
                          content: Text('success')));
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Code to execute when 'Undo' is pressed
                              print('Undo action');
                            },
                          ),
                          content: Text('$error')));
                    }
                  },
                  child: Text("Create Grade Template"))
            ],
          ),
        ),
      ),
    );
  }
}
