import 'package:flutter/material.dart';
import 'package:mobile_be/pages/classes/class_profile.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({super.key});

  @override
  _ClassScreenState createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  final List<Map<String, dynamic>> classes = [
    {
      'className': '101',
      'teacher': 'Mr. Smith',
      'students': ['John', 'Sarah', 'Alex'],
    },
    {
      'className': '102',
      'teacher': 'Mrs. Johnson',
      'students': ['James', 'Emily', 'Robert'],
    },
    {
      'className': '201',
      'teacher': 'Ms. Davis',
      'students': ['Olivia', 'Ethan', 'Charlotte'],
    },
    {
      'className': '202',
      'teacher': 'Mr. Brown',
      'students': ['Liam', 'Sophia', 'Jackson'],
    },
  ];

  bool _isEditMode = false;

  void _showAddClassDialog() {
    TextEditingController classController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Class'),
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
              onPressed: () {
                String className = classController.text.trim();
                if (className.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Class name cannot be empty!')),
                  );
                } else {
                  setState(() {
                    classes.add({
                      'className': className,
                      'teacher': 'Unassigned',
                      'students': [],
                    });
                  });
                  Navigator.of(context).pop();
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
                setState(() {
                  classes.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete Class'),
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
      body: ListView.builder(
        itemCount: classes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(
                'Class: ${classes[index]['className']}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              trailing: Wrap(
                spacing: 12,
                children: [
                  if (_isEditMode)
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _showDeleteClassDialog(index);
                      },
                    ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClassProfile(classData: classes[index]),
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
              onPressed: _showAddClassDialog,
              backgroundColor: const Color.fromARGB(255, 231, 125, 11),
              tooltip: 'Add Class',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}