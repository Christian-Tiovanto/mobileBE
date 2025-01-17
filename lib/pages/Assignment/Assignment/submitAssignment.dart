import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mobile_be/model/assignment.dart'; // Untuk memilih file

class SubmitAssignment extends StatefulWidget {
  final Assignment assignment;

  const SubmitAssignment({Key? key, required this.assignment})
      : super(key: key);

  @override
  _SubmitAssignmentState createState() => _SubmitAssignmentState();
}

class _SubmitAssignmentState extends State<SubmitAssignment> {
  final TextEditingController _commentController = TextEditingController();
  String? selectedFilePath;
  bool _isSubmitted = false; // Flag to track submission status

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFilePath = result.files.single.path;
      });
    }
  }

  void _submitAssignment() {
    print('Submit button pressed'); // Debug log

    // Check if both file and comment are empty
    if (selectedFilePath == null && _commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please either attach a file or provide an answer'),
        ),
      );
      return;
    }

    // Create the submission
    print('Creating submission'); // Debug log
    final submission = Submission(
      submitterName: 'John Doe', // Replace with the actual user
      submissionTime: DateTime.now().toString(),
      filePath: selectedFilePath ?? '', // Allow submitting without a file
      comment: _commentController.text,
    );

    // Add the submission to the assignment's submissions list
    setState(() {
      widget.assignment.submissions.add(submission);
      _isSubmitted = true; // Mark as submitted
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Assignment submitted successfully!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Assignment'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assignment: ${widget.assignment.title}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Due: ${widget.assignment.dueDate}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Attach your file or type down your answer (optional):',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickFile,
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: selectedFilePath == null
                      ? const Text(
                          'Tap to select a file',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.attach_file),
                            Text(
                                'File selected: ${selectedFilePath!.split('/').last}'),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Answer (optional):',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add your answer...',
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _isSubmitted
                    ? null
                    : _submitAssignment, // Disable if already submitted
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: Text(
                  _isSubmitted ? 'Assignment Submitted' : 'Submit Assignment',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
