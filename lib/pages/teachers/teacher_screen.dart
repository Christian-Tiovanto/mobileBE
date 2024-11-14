import 'package:flutter/material.dart';
import 'package:mobile_be/pages/teachers/teacher_profile.dart';

class TeacherScreen extends StatefulWidget {
  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  final List<Map<String, dynamic>> teachers = [
    {
      'title': 'Mr.',
      'name': 'Smith',
      'id': 'T001',
      'profilePic': 'icon',
      'classes': ['Mathematics 101', 'Science 201'],
    },
    {
      'title': 'Mrs.',
      'name': 'Johnson',
      'id': 'T002',
      'profilePic': 'icon',
      'classes': ['Science 101', 'Religion 201'],
    },
    {
      'title': 'Ms.',
      'name': 'Davis',
      'id': 'T003',
      'profilePic': 'icon',
      'classes': ['Art 101', 'Religion 201'],
    },
    {
      'title': 'Mr.',
      'name': 'Brown',
      'id': 'T004',
      'profilePic': 'icon',
      'classes': ['Art 101', 'Mathematics 201'],
    },
  ];

  bool _isEditMode = false;
  String _selectedTitle = 'Mr.';

  void _showAddTeacherDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController idController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Teacher'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: _selectedTitle,
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedTitle = newValue!;
                  });
                },
                items: ['Mr.', 'Mrs.', 'Ms.']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(value),
                    ),
                  );
                }).toList(),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                underline: Container(),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'ID'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  teachers.add({
                    'title': _selectedTitle,
                    'name': nameController.text,
                    'id': idController.text,
                    'profilePic': 'icon',
                    'classes': [],
                  });
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add Teacher'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteTeacherDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Teacher'),
          content: const Text('Are you sure you want to delete this teacher?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  teachers.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete Teacher'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView.builder(
        itemCount: teachers.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(
                '${teachers[index]['title']} ${teachers[index]['name']}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              trailing: Wrap(
                spacing: 12,
                children: [
                  if (_isEditMode)
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _showDeleteTeacherDialog(index);
                      },
                    ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherProfile(teacher: teachers[index]),
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
      floatingActionButton: _isEditMode
          ? FloatingActionButton(
              onPressed: _showAddTeacherDialog,
              child: const Icon(Icons.add),
              backgroundColor: const Color.fromARGB(255, 231, 125, 11),
              tooltip: 'Add Teacher',
            )
          : null,
    );
  }
}
