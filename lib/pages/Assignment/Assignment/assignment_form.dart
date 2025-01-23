import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_be/model/assignment.dart';
import 'package:mobile_be/services/assignment-service.dart';

class AssignmentForm extends StatefulWidget {
  String classId;
  AssignmentForm({Key? key, required this.classId}) : super(key: key);

  @override
  _AssignmentFormState createState() => _AssignmentFormState();
}

class _AssignmentFormState extends State<AssignmentForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String attachedFiles = '';

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );

      if (pickedTime != null) {
        final DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _dueDateController.text = '$finalDateTime';
        });
      }
    }
  }

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        attachedFiles = result.paths.first ?? '';
      });
    }
  }

  void _saveAssignment() async {
    if (_titleController.text.isNotEmpty &&
        _dueDateController.text.isNotEmpty) {
      try {
        final newAssignment = Assignment(
            title: _titleController.text,
            dueDate: DateTime.parse(_dueDateController.text),
            description: _descriptionController.text,
            attachedFiles: attachedFiles,
            class_id: widget.classId);

        final response = await AssignmentService().createAssignment(
            newAssignment, attachedFiles == '' ? null : attachedFiles);
        if (response == true) {
          Navigator.pop(context, newAssignment);
        }
      } catch (error) {}
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment Form'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Assignment Title',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter assignment title',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Due date and time',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectDateTime(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _dueDateController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select due date and time',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                maxLines: 6,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter description here...',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Attach files',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickFiles,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: attachedFiles.isEmpty
                        ? const Text(
                            'Drag or select a file',
                            style: TextStyle(color: Colors.grey),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.attach_file),
                              Text('${1} file(s) attached'),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                  child: ElevatedButton(
                onPressed: _saveAssignment,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.orange, // Mengubah warna background menjadi orange
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
