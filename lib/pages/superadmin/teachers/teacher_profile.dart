import 'package:flutter/material.dart';
import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/model/teachermodel.dart';
import 'package:mobile_be/pages/grade/lessongrade.dart';
import 'package:mobile_be/services/classroom-service.dart';
import 'package:mobile_be/services/grade-service.dart';
import 'package:mobile_be/services/teacher-service.dart';

class TeacherProfile extends StatefulWidget {
  final Teacher teacher;

  const TeacherProfile({super.key, required this.teacher});

  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  List<Classroom> classes = [];
  String? selectedSubject;
  String? selectedClassCode;

  late List<Classroom> availableClasses = [];
  void getAllClassroom() async {
    final response = await ClassroomService().getAllClassroom();
    print("di getAllClassroom");
    setState(() {
      availableClasses = response;
    });
    print(response);
  }

  @override
  void initState() {
    print("availableClasses['science']");
    super.initState();
    if (widget.teacher.classroom != null) {
      classes = List<Classroom>.from(widget.teacher.classroom!);
    }
    getAllClassroom();
  }

  void _showEditDialog(Teacher teacher) {
    showDialog(
      context: context,
      builder: (context) {
        return EditClassesDialog(
          teacher: teacher,
          // availableClasses: availableClasses,
          initialClasses: classes,
          // onClassesUpdated: (updatedClasses) {
          //   setState(() {
          //     classes = updatedClasses.map((id) => Classroom(id: id)).toList();
          //   });
          // },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.teacher.name, style: const TextStyle(fontSize: 24)),
        backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              print('Edit button pressed');
              _showEditDialog(widget.teacher);
            },
            tooltip: 'Edit Classes',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                child: widget.teacher.name == 'icon'
                    ? Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey[700],
                      )
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                widget.teacher.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'ID: ${widget.teacher.user_id}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Classes Attended:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Column(
                children: classes.isNotEmpty
                    ? classes.map<Widget>((classr) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            classr.id,
                            style: const TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList()
                    : [
                        Text("No classes available",
                            style: const TextStyle(fontSize: 18))
                      ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditClassesDialog extends StatefulWidget {
  final List<Classroom> initialClasses;
  final Teacher teacher;

  const EditClassesDialog(
      {Key? key, required this.initialClasses, required this.teacher})
      : super(key: key);

  @override
  _EditClassesDialogState createState() => _EditClassesDialogState();
}

class _EditClassesDialogState extends State<EditClassesDialog> {
  late List<Classroom> classes;
  List<Classroom> availableClasses = []; // Initialize as an empty list

  String? selectedSubject;
  String? selectedClassCode;
  String? selectedHomeroomClass;

  // Fetch classrooms data
  void getAllClassroom() async {
    final response = await ClassroomService().getAllClassroom();
    print("Fetched classrooms");
    setState(() {
      availableClasses = response; // Assign fetched data to availableClasses
    });
    print(response);
  }

  // Fetch subjects, called after getAllClassroom
  Future<List<Subject>> getAllSubject() async {
    final results = await GradeService().getAllSubject();
    print('Results from getAllSubject');
    print(results);
    return results;
  }

  @override
  void initState() {
    super.initState();
    print('ini di initsatate');
    getAllClassroom(); // Initial classroom fetch
    classes = List<Classroom>.from(widget.initialClasses);
  }

  @override
  Widget build(BuildContext context) {
    print('availableClasses di buildcontext');
    print(availableClasses);
    return AlertDialog(
      title: const Text('Edit Classes'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Select Homeroom Class"),
          DropdownButton<String>(
            value: selectedHomeroomClass != null
                ? selectedHomeroomClass
                : widget.teacher.homeroom_class != null
                    ? widget.teacher.homeroom_class!.id
                    : null,
            hint: const Text('Select Homeroom class'),
            onChanged: (String? newClassCode) {
              setState(() {
                selectedHomeroomClass = newClassCode;
              });
            },
            items: availableClasses.map<DropdownMenuItem<String>>((classCode) {
              return DropdownMenuItem<String>(
                value: classCode.id,
                child: Text(classCode.id), // Display classCode.id
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          FutureBuilder<List<Subject>>(
            future: getAllSubject(), // Fetch both classrooms and subjects
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error} occurred'),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return DropdownButton<String>(
                    value: selectedSubject,
                    hint: const Text('Select a subject'),
                    onChanged: (String? newSubject) {
                      setState(() {
                        selectedSubject = newSubject;
                        selectedClassCode =
                            null; // Reset class code on subject change
                      });
                    },
                    items: data.map<DropdownMenuItem<String>>((subject) {
                      return DropdownMenuItem<String>(
                        value: subject.name,
                        child: Text(subject.name),
                      );
                    }).toList(),
                  );
                }
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          const SizedBox(height: 16),
          if (selectedSubject != null && availableClasses.isNotEmpty)
            DropdownButton<String>(
              value: selectedClassCode,
              hint: const Text('Select class'),
              onChanged: (String? newClassCode) {
                setState(() {
                  selectedClassCode = newClassCode;
                });
              },
              items:
                  availableClasses.map<DropdownMenuItem<String>>((classCode) {
                return DropdownMenuItem<String>(
                  value: classCode.id,
                  child: Text(classCode.id), // Display classCode.id
                );
              }).toList(),
            ),
          const SizedBox(height: 16),
          ...classes.map((classr) {
            return ListTile(
              title: Text(classr.id),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  try {
                    classes.remove(classr);
                    final response = await TeacherService()
                        .updateTeacheTeachNClass(
                            widget.teacher.id,
                            classes.map((el) => el.id).toList(),
                            widget.teacher.subject_teach,
                            widget.teacher.homeroom_class != null
                                ? widget.teacher.homeroom_class?.id
                                : null);
                    if (response == true) {
                      setState(() {
                        classes.remove(classr);
                      });
                    }
                  } catch (err) {
                    print('err di delete class');
                    print(err);
                  }
                },
              ),
            );
          }).toList(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              print("ini di button editclass");
              print(selectedSubject);
              print(selectedClassCode);
              final response = await TeacherService().updateTeacheTeachNClass(
                  widget.teacher.id,
                  [
                    ...widget.teacher.classroom.map((val) => val.id),
                    selectedClassCode != null ? selectedClassCode : ''
                  ],
                  selectedSubject != null
                      ? selectedSubject!
                      : widget.teacher.subject_teach,
                  selectedHomeroomClass);
              if (response == true) Navigator.of(context).pop();
            } catch (error) {
              print('error di teaccher profile');
              print(error);
            }
          },
          child: const Text('Edit Class And Subject'),
        ),
      ],
    );
  }
}
