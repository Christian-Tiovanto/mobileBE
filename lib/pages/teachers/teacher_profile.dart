import 'package:flutter/material.dart';

class TeacherProfile extends StatefulWidget {
  final Map<String, dynamic> teacher;

  const TeacherProfile({super.key, required this.teacher});

  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  List<String> classes = [];
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
    if (widget.teacher['classes'] != null) {
      classes = List<String>.from(widget.teacher['classes']);
    }
  }

  void _showEditDialog() {

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Classes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedSubject,
                hint: const Text('Select a subject'),
                onChanged: (String? newSubject) {
                  setState(() {
                    selectedSubject = newSubject;
                    selectedClassCode = null;
                  });
                },
                items: availableClasses.keys.map<DropdownMenuItem<String>>((subject) {
                  return DropdownMenuItem<String>(
                    value: subject,
                    child: Text(subject),
                  );
                }).toList(),
              ),
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
                  items: availableClasses[selectedSubject]!
                      .map<DropdownMenuItem<String>>((classCode) {
                    return DropdownMenuItem<String>(
                      value: classCode,
                      child: Text(classCode),
                    );
                  }).toList(),
                ),
              const SizedBox(height: 16),
              ...classes.map((className) {
                return ListTile(
                  title: Text(className),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        classes.remove(className);
                      });
                      Navigator.of(context).pop();
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
                    classes.add('$selectedSubject $selectedClassCode');
                    selectedClassCode = null;
                  });
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.teacher['name'], style: const TextStyle(fontSize: 24)),
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
                child: widget.teacher['profilePic'] == 'icon'
                    ? Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey[700],
                      )
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                widget.teacher['name'],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'ID: ${widget.teacher['id']}',
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
                      classCode,
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
