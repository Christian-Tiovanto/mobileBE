import 'package:flutter/material.dart';
import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/model/teachermodel.dart';
import 'package:mobile_be/pages/grade/lessongrade.dart';
import 'package:mobile_be/services/grade-service.dart';

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

  final Map<String, List<String>> availableClasses = {
    'Mathematics': ['101', '102', '201', '202'],
    'Science': ['101', '102', '201', '202'],
    'Religion': ['101', '102', '201', '202'],
    'Art': ['101', '102', '201', '202'],
  };

  @override
  void initState() {
    super.initState();
    if (widget.teacher.classroom != null) {
      classes = List<Classroom>.from(widget.teacher.classroom);
    }
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return EditClassesDialog(
          availableClasses: availableClasses,
          initialClasses: classes,
          onClassesUpdated: (dynamic updatedClasses) {
            setState(() {
              classes = updatedClasses;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('widget.teacher di teacher profile');
    print(widget.teacher.classroom.map((classr) => classr.id));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.teacher.name, style: const TextStyle(fontSize: 24)),
        backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              print('Edit button pressed');
              _showEditDialog();
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
                children: classes.map<Widget>((classCode) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      '${widget.teacher.classroom.map((classr) => classr.id)}',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditClassesDialog extends StatefulWidget {
  final Map<String, List<String>> availableClasses;
  final List<Classroom> initialClasses;
  final ValueChanged<List<String>> onClassesUpdated;

  const EditClassesDialog({
    Key? key,
    required this.availableClasses,
    required this.initialClasses,
    required this.onClassesUpdated,
  }) : super(key: key);

  @override
  _EditClassesDialogState createState() => _EditClassesDialogState();
}

class _EditClassesDialogState extends State<EditClassesDialog> {
  late List<Classroom> classes;
  String? selectedSubject;
  String? selectedClassCode;

  Future<dynamic> getAllSubject() {
    final results = GradeService().getAllSubject();
    print('results di grade');
    print(results);
    return results;
  }

  @override
  void initState() {
    super.initState();
    classes = List<Classroom>.from(widget.initialClasses);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Classes'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder(
              future: getAllSubject(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error} has occured'),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data as List<Subject>;
                    print('data di teacherprofile subject');
                    print(data);
                    return DropdownButton<String>(
                      value: selectedSubject,
                      hint: const Text('Select a subject'),
                      onChanged: (String? newSubject) {
                        print('newSubject');
                        print(newSubject);
                        setState(() {
                          selectedSubject = newSubject;
                          // selectedClassCode =
                          //     null; // Reset class code on subject change
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
                return Center(child: CircularProgressIndicator());
              }),
          const SizedBox(height: 16),
          if (selectedSubject != null)
            DropdownButton<String>(
              value: selectedClassCode,
              hint: const Text('Select class'),
              onChanged: (String? newClassCode) {
                setState(() {
                  selectedClassCode = newClassCode;
                });
              },
              items: widget.availableClasses[selectedSubject]!
                  .map<DropdownMenuItem<String>>((classCode) {
                return DropdownMenuItem<String>(
                  value: classCode,
                  child: Text(classCode),
                );
              }).toList(),
            ),
          // DropdownButton<String>(
          //   value: selectedSubject,
          //   hint: const Text('Select a subject'),
          //   onChanged: (String? newSubject) {
          //     setState(() {
          //       selectedSubject = newSubject;
          //       selectedClassCode = null; // Reset class code on subject change
          //     });
          //   },
          //   items: widget.availableClasses.keys
          //       .map<DropdownMenuItem<String>>((subject) {
          //     return DropdownMenuItem<String>(
          //       value: subject,
          //       child: Text(subject),
          //     );
          //   }).toList(),
          // ),

          // const SizedBox(height: 16),
          // if (selectedSubject != null)
          //   DropdownButton<String>(
          //     value: selectedClassCode,
          //     hint: const Text('Select class'),
          //     onChanged: (String? newClassCode) {
          //       setState(() {
          //         selectedClassCode = newClassCode;
          //       });
          //     },
          //     items: widget.availableClasses[selectedSubject]!
          //         .map<DropdownMenuItem<String>>((classCode) {
          //       return DropdownMenuItem<String>(
          //         value: classCode,
          //         child: Text(classCode),
          //       );
          //     }).toList(),
          //   ),
          const SizedBox(height: 16),
          ...classes.map((className) {
            return ListTile(
              title: Text(className.id),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    classes.remove(className);
                  });
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
          onPressed: () {
            if (selectedClassCode != null &&
                !classes.contains('$selectedSubject $selectedClassCode')) {
              setState(() {
                // classes.add('$selectedSubject $selectedClassCode');
                // selectedClassCode = null; // Reset the selected class code
              });
              // widget.onClassesUpdated(classes); // Notify parent widget
              Navigator.of(context).pop();
            } else if (selectedClassCode == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please select a class code')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Class code already exists')),
              );
            }
          },
          child: const Text('Add Class'),
        ),
      ],
    );
  }
}
