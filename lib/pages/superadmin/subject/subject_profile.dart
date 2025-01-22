import 'package:flutter/material.dart';

class SubjectProfile extends StatefulWidget {
  final Map<String, dynamic> classData;

  const SubjectProfile({super.key, required this.classData});

  @override
  _SubjectProfileState createState() => _SubjectProfileState();
}

class _SubjectProfileState extends State<SubjectProfile> {
  final TextEditingController _teacherController = TextEditingController();
  final TextEditingController _studentController = TextEditingController();
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        elevation: 4.0,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.done : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildClassInfo(),
              const SizedBox(height: 24.0),
              _buildTeacherInfo(),
              const SizedBox(height: 24.0),
              _buildStudentsList(),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(
      String title, String content, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: onConfirm,
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildClassInfo() {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Class Name: ${widget.classData['className']}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeacherInfo() {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: Colors.orange, size: 30),
                const SizedBox(width: 16.0),
                Text(
                  'Teacher: ${widget.classData['teacher']}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            if (_isEditing)
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.orange),
                onPressed: () {
                  _showTeacherEditDialog();
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showTeacherEditDialog() {
    _teacherController.text = widget.classData['teacher'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Teacher'),
          content: TextField(
            controller: _teacherController,
            decoration: const InputDecoration(labelText: 'Teacher Name'),
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
                  widget.classData['teacher'] = _teacherController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStudentsList() {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Students:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                if (_isEditing)
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.orange),
                    onPressed: () {
                      _showAddStudentDialog();
                    },
                  ),
              ],
            ),
            const SizedBox(height: 8.0),
            if (widget.classData['students'].isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.classData['students'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(widget.classData['students'][index]),
                    trailing: _isEditing
                        ? IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _showConfirmationDialog(
                                'Delete Student',
                                'Are you sure you want to remove this student?',
                                () {
                                  setState(() {
                                    widget.classData['students']
                                        .removeAt(index);
                                  });
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          )
                        : null,
                  );
                },
              )
            else
              const Center(
                child: Text(
                  'No students available.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showAddStudentDialog() {
    _studentController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Student'),
          content: TextField(
            controller: _studentController,
            decoration: const InputDecoration(labelText: 'Student Name'),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  widget.classData['students'].add(value);
                });
                _studentController.clear();
              }
            },
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
                if (_studentController.text.isNotEmpty) {
                  setState(() {
                    widget.classData['students'].add(_studentController.text);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
