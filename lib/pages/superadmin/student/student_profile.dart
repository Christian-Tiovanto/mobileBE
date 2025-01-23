import 'package:flutter/material.dart';
import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/model/studentmodel.dart';
import 'package:mobile_be/model/teachermodel.dart';
import 'package:mobile_be/pages/grade/lessongrade.dart';
import 'package:mobile_be/services/classroom-service.dart';
import 'package:mobile_be/services/grade-service.dart';
import 'package:mobile_be/services/student-service.dart';
import 'package:mobile_be/services/teacher-service.dart';

class StudentProfile extends StatefulWidget {
  final Student student;

  const StudentProfile({super.key, required this.student});

  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  String? selectedSubject;
  String? selectedClassCode;

  late List<Classroom> availableClasses = [];
  void getAllClassroom() async {
    final response = await ClassroomService().getAllClassroom();

    setState(() {
      availableClasses = response;
    });
  }

  @override
  void initState() {
    super.initState();
    // if (widget.student.classroom != null) {
    //   classes = List<Classroom>.from(widget.student.classroom!);
    // }
    getAllClassroom();
  }

  void _showEditDialog(Student student) {
    showDialog(
      context: context,
      builder: (context) {
        return EditClassesDialog(
          student: student,
          // availableClasses: availableClasses,
          initialClasses: student.class_id,
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
        title: Text(widget.student.name, style: const TextStyle(fontSize: 24)),
        backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _showEditDialog(widget.student);
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
                child: widget.student.name == 'icon'
                    ? Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey[700],
                      )
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                widget.student.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'ID: ${widget.student.user_id}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Student Class:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  widget.student.class_id.id != null
                      ? Text('${widget.student.class_id.id}')
                      : Text("No classes available",
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
  final Classroom initialClasses;
  final Student student;

  const EditClassesDialog(
      {Key? key, required this.initialClasses, required this.student})
      : super(key: key);

  @override
  _EditClassesDialogState createState() => _EditClassesDialogState();
}

class _EditClassesDialogState extends State<EditClassesDialog> {
  late Classroom classes;
  List<Classroom> availableClasses = []; // Initialize as an empty list

  String? selectedCLass;

  // Fetch classrooms data

  // Fetch subjects, called after getAllClassroom
  Future<List<Classroom>> getAllClassroom() async {
    final results = await ClassroomService().getAllClassroom();

    return results;
  }

  @override
  void initState() {
    super.initState();

    classes = widget.initialClasses;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Classes'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder<List<Classroom>>(
            future: getAllClassroom(), // Fetch both classrooms and subjects
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error} occurred'),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return DropdownButton<String>(
                    value: selectedCLass,
                    hint: const Text('Select a class'),
                    onChanged: (String? newSubject) {
                      setState(() {
                        selectedCLass = newSubject;
                      });
                    },
                    items: data.map<DropdownMenuItem<String>>((subject) {
                      return DropdownMenuItem<String>(
                        value: subject.id,
                        child: Text(subject.id),
                      );
                    }).toList(),
                  );
                }
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 16),
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
              if (selectedCLass == null) {
                return;
              }
              final response = await StudentService()
                  .updateStudentClassById(widget.student.id, selectedCLass!);
              await GradeService()
                  .createEmptyGrade(selectedCLass!, widget.student.id);

              if (response == true) Navigator.of(context).pop();
              setState(() {});
            } catch (error) {}
          },
          child: const Text('Edit Class'),
        ),
      ],
    );
  }
}
