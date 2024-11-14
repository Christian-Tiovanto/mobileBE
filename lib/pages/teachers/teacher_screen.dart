import 'package:flutter/material.dart';
import 'package:mobile_be/model/teachermodel.dart';
import 'package:mobile_be/pages/teachers/teacher_profile.dart';

import 'package:flutter/material.dart';
import 'package:mobile_be/pages/grade/grade_screen.dart';
import 'package:mobile_be/model/studentmodel.dart';
import 'package:mobile_be/services/student-service.dart';
import 'package:mobile_be/services/teacher-service.dart';

class TeacherScreenHttp extends StatefulWidget {
  TeacherScreenHttp({
    super.key,
  });

  @override
  State<TeacherScreenHttp> createState() => _TeacherScreenHttpState();
}

class _TeacherScreenHttpState extends State<TeacherScreenHttp> {
  final String teacherName = 'ini ntar fetch API'; // Add teacherName property

  bool _isEditMode = false;
  String _selectedTitle = 'Mr.';

  void _showAddTeacherDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController idController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneNumController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Teacher'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: 'ID'),
                ),
                TextField(
                  controller: phoneNumController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                ),
              ],
            ),
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
                  final response = await TeacherService().registerTeacher(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                      idController.text,
                      phoneNumController.text);
                  if (response == true) {
                    setState(() {});
                    Navigator.of(context).pop();
                  }
                } catch (error) {
                  print('error di addteacher');
                  print(error);
                }
              },
              child: const Text('Add Teacher'),
            ),
          ],
        );
      },
    );
  }

  // void _showDeleteTeacherDialog(int index) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Delete Teacher'),
  //         content: const Text('Are you sure you want to delete this teacher?'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               setState(() {
  //                 // teachers.removeAt(index);
  //               });
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Delete Teacher'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<dynamic> getAllTeacher() {
    final results = TeacherService().getAllTeacher();
    print('results di grade');
    print(results);
    return results;
  }

  @override
  Widget build(BuildContext context) {
    // final String lessonName = widget.lessonName;
    return Scaffold(
      floatingActionButton: _isEditMode
          ? FloatingActionButton(
              onPressed: _showAddTeacherDialog,
              child: const Icon(Icons.add),
              backgroundColor: const Color.fromARGB(255, 231, 125, 11),
              tooltip: 'Add Teacher',
            )
          : null,
      appBar: AppBar(
        title: const Text('Teachers', style: TextStyle(fontSize: 24)),
        backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        actions: [
          IconButton(
            icon: Icon(_isEditMode ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditMode = !_isEditMode;
              });
            },
            tooltip: _isEditMode ? 'Cancel Edit' : 'Edit Teachers',
          ),
        ],
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
          FutureBuilder(
              future: getAllTeacher(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error} has occured'),
                    );
                  } else if (snapshot.hasData) {
                    print('data di studentgrade');
                    final data = snapshot.data as List<Teacher>;
                    print(data);
                    return Expanded(
                      child: data.isEmpty
                          ? Center(child: Text('No students found for .'))
                          : ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  child: ListTile(
                                    title: Text(
                                      '${data[index].name}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    trailing: Wrap(
                                      spacing: 12,
                                      children: [
                                        if (_isEditMode)
                                          // IconButton(
                                          //   icon: const Icon(Icons.delete,
                                          //       color: Colors.red),
                                          //   onPressed: () {
                                          //     _showDeleteTeacherDialog(index);
                                          //   },
                                          // ),
                                          IconButton(
                                            icon:
                                                const Icon(Icons.arrow_forward),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TeacherProfile(
                                                          teacher: data[index]),
                                                ),
                                              );
                                            },
                                          ),
                                      ],
                                    ),
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

// class TeacherScreen extends StatefulWidget {
//   @override
//   _TeacherScreenState createState() => _TeacherScreenState();
// }

// class _TeacherScreenState extends State<TeacherScreen> {
//   final List<Map<String, dynamic>> teachers = [
//     {
//       'title': 'Mr.',
//       'name': 'Smith',
//       'id': 'T001',
//       'profilePic': 'icon',
//       'classes': ['Mathematics 101', 'Science 201'],
//     },
//     {
//       'title': 'Mrs.',
//       'name': 'Johnson',
//       'id': 'T002',
//       'profilePic': 'icon',
//       'classes': ['Science 101', 'Religion 201'],
//     },
//     {
//       'title': 'Ms.',
//       'name': 'Davis',
//       'id': 'T003',
//       'profilePic': 'icon',
//       'classes': ['Art 101', 'Religion 201'],
//     },
//     {
//       'title': 'Mr.',
//       'name': 'Brown',
//       'id': 'T004',
//       'profilePic': 'icon',
//       'classes': ['Art 101', 'Mathematics 201'],
//     },
//   ];

//   bool _isEditMode = false;
//   String _selectedTitle = 'Mr.';

//   void _showAddTeacherDialog() {
//     TextEditingController nameController = TextEditingController();
//     TextEditingController idController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Add Teacher'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               DropdownButton<String>(
//                 value: _selectedTitle,
//                 isExpanded: true,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _selectedTitle = newValue!;
//                   });
//                 },
//                 items: ['Mr.', 'Mrs.', 'Ms.']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(value),
//                     ),
//                   );
//                 }).toList(),
//                 icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
//                 underline: Container(),
//               ),
//               TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: 'Name'),
//               ),
//               TextField(
//                 controller: idController,
//                 decoration: const InputDecoration(labelText: 'ID'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   teachers.add({
//                     'title': _selectedTitle,
//                     'name': nameController.text,
//                     'id': idController.text,
//                     'profilePic': 'icon',
//                     'classes': [],
//                   });
//                 });
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Add Teacher'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showDeleteTeacherDialog(int index) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Delete Teacher'),
//           content: const Text('Are you sure you want to delete this teacher?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   teachers.removeAt(index);
//                 });
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Delete Teacher'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Teachers', style: TextStyle(fontSize: 24)),
//         backgroundColor: const Color.fromARGB(255, 231, 125, 11),
//         actions: [
//           IconButton(
//             icon: Icon(_isEditMode ? Icons.close : Icons.edit),
//             onPressed: () {
//               setState(() {
//                 _isEditMode = !_isEditMode;
//               });
//             },
//             tooltip: _isEditMode ? 'Cancel Edit' : 'Edit Teachers',
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: teachers.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//             child: ListTile(
//               title: Text(
//                 '${teachers[index]['title']} ${teachers[index]['name']}',
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//               ),
//               trailing: Wrap(
//                 spacing: 12,
//                 children: [
//                   if (_isEditMode)
//                     IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       onPressed: () {
//                         _showDeleteTeacherDialog(index);
//                       },
//                     ),
//                   IconButton(
//                     icon: const Icon(Icons.arrow_forward),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               TeacherProfile(teacher: teachers[index]),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: _isEditMode
//           ? FloatingActionButton(
//               onPressed: _showAddTeacherDialog,
//               child: const Icon(Icons.add),
//               backgroundColor: const Color.fromARGB(255, 231, 125, 11),
//               tooltip: 'Add Teacher',
//             )
//           : null,
//     );
//   }
// }
