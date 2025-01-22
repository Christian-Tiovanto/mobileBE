import 'package:flutter/material.dart';
import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/pages/grade/lessongrade.dart';
import 'package:mobile_be/pages/superadmin/classes/class_profile.dart';
import 'package:mobile_be/services/classroom-service.dart';
import 'package:mobile_be/services/grade-service.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  bool _isEditMode = false;

  void _showAddClassDialog() {
    TextEditingController classController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Subject'),
          content: TextField(
            controller: classController,
            decoration: const InputDecoration(labelText: 'Class Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  String className = classController.text.trim();
                  if (className.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Class name cannot be empty!')),
                    );
                  } else {
                    final response = await GradeService()
                        .createSubject(classController.text.trim());
                    if (response == true) {
                      Navigator.of(context).pop();
                      setState(() {});
                    }
                  }
                } catch (error) {
                  print('error di create class');
                  print(error);
                }
              },
              child: const Text('Add Class'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteClassDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Class'),
          content: const Text('Are you sure you want to delete this class?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Delete Class'),
            ),
          ],
        );
      },
    );
  }

  Future getAllClassroom() async {
    final response = await GradeService().getAllSubject();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classes', style: TextStyle(fontSize: 24)),
        backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        actions: [
          IconButton(
            icon: Icon(_isEditMode ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditMode = !_isEditMode;
              });
            },
            tooltip: _isEditMode ? 'Cancel Edit' : 'Edit Classes',
          ),
        ],
      ),
      body: FutureBuilder(
          future: getAllClassroom(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error} has occured'),
                );
              } else if (snapshot.hasData) {
                print('data di studentgrade');
                final classroom = snapshot.data as List<Subject>;
                print(classroom);
                return ListView.builder(
                  itemCount: classroom.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Text(
                          'Subject: ${classroom[index].name}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        // trailing: Wrap(
                        //   spacing: 12,
                        //   children: [
                        //     if (_isEditMode)
                        //       IconButton(
                        //         icon: const Icon(Icons.delete, color: Colors.red),
                        //         onPressed: () {
                        //           _showDeleteClassDialog(index);
                        //         },
                        //       ),
                        //     IconButton(
                        //       icon: const Icon(Icons.arrow_forward),
                        //       onPressed: () {
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => ClassProfile(classData: classes[index]),
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //   ],
                        // ),
                      ),
                    );
                  },
                );
              }
            }
            return Center(child: CircularProgressIndicator());
          }),
      // ListView.builder(
      //   itemCount: classes.length,
      //   itemBuilder: (context, index) {
      //     return Card(
      //       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      //       child: ListTile(
      //         title: Text(
      //           'Class: ${classes[index]['className']}',
      //           style:
      //               const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      //         ),
      //         trailing: Wrap(
      //           spacing: 12,
      //           children: [
      //             if (_isEditMode)
      //               IconButton(
      //                 icon: const Icon(Icons.delete, color: Colors.red),
      //                 onPressed: () {
      //                   _showDeleteClassDialog(index);
      //                 },
      //               ),
      //             IconButton(
      //               icon: const Icon(Icons.arrow_forward),
      //               onPressed: () {
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                     builder: (context) => ClassProfile(classData: classes[index]),
      //                   ),
      //                 );
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),

      floatingActionButton: _isEditMode
          ? FloatingActionButton(
              onPressed: _showAddClassDialog,
              backgroundColor: const Color.fromARGB(255, 231, 125, 11),
              tooltip: 'Add Class',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
