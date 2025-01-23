import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_be/model/assignment.dart';
import 'package:mobile_be/pages/Assignment/Assignment/submitAssignment.dart';
import 'package:mobile_be/pages/view_image-assignment.dart';
import 'package:mobile_be/pages/view_image.dart';
import 'package:mobile_be/services/assignment-service.dart';
import 'package:permission_handler/permission_handler.dart';

class AssignmentDetail extends StatefulWidget {
  final Assignment assignment;

  const AssignmentDetail({Key? key, required this.assignment})
      : super(key: key);

  @override
  _AssignmentDetailState createState() => _AssignmentDetailState();
}

class _AssignmentDetailState extends State<AssignmentDetail> {
  final DateFormat formatter = DateFormat('MM/dd/yyyy HH:mm');
  void _updateScore(Submission submission, int score) async {
    try {
      await AssignmentService().updateSubmissionScore(submission, score);
    } catch (error) {}

    setState(() {
      submission.score = score;
    });
  }

  Future<List<Submission>> getAllSubmissionByAssignmentId(String assignmentId) {
    final results =
        AssignmentService().getAllSubmissionByAssignmentId(assignmentId);

    return results;
  }

  void _downloadFile(String url) {
    // Implement file download logic here
  }

  // Fungsi untuk menavigasi ke halaman submit assignment
  void _navigateToSubmitAssignment(Assignment assignment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubmitAssignment(assignment: assignment),
      ),
    );
  }

  // Memeriksa apakah tugas sudah lewat tenggat waktu
  bool get isAssignmentClosed {
    return DateTime.now()
        .isAfter(widget.assignment.dueDate); // Compare DateTime objects
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.assignment.title),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Due: ${formatter.format(widget.assignment.dueDate)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              widget.assignment.description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text(
              'Submissions:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            FutureBuilder(
                future: getAllSubmissionByAssignmentId(
                    widget.assignment.assignment_id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error} has occured'),
                      );
                    } else if (snapshot.hasData) {
                      final data = snapshot.data as List<Submission>;

                      return data.isEmpty
                          ? const Text('No submissions yet.')
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final submission = data[index];
                                return Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: ListTile(
                                    title: Text(
                                      submission.submitterName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        'Submitted at: ${submission.submissionTime}'),
                                    onTap: () {
                                      _showSubmissionDetail(
                                          context, submission);
                                    },
                                    trailing: SizedBox(
                                      width: 100,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: submission.score == 0
                                                    ? 'Score'
                                                    : submission.score
                                                        .toString(),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              onSubmitted: (value) async {
                                                final int? score =
                                                    int.tryParse(value);
                                                if (score != null &&
                                                    score >= 0 &&
                                                    score <= 100) {
                                                  _updateScore(
                                                      submission, score);
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Please enter a valid score (0-100).'),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                    }
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            const Text(
              'File Attachment',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            widget.assignment.attachedFiles != ''
                ? ListTile(
                    title: GestureDetector(
                      onTap: () async {
                        // Implement the PDF viewer logic here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewFileAssignmentPage(
                              assignmentId: widget.assignment.assignment_id!,
                              fileName: widget.assignment.attachedFiles,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        widget.assignment.attachedFiles,
                        style: TextStyle(
                            color: Colors
                                .blue), // Optional: Add color to indicate it's clickable
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.download),
                      onPressed: () async {
                        // Implement the download logic here
                        await AssignmentService()
                            .getAssignmentAttachment(widget.assignment);
                      },
                    ),
                  )
                : Text(''),

            const SizedBox(height: 16),
            // Menampilkan pesan jika assignment sudah tutup
            if (isAssignmentClosed)
              const Text(
                'Assignment is closed',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 16),
            // Tombol untuk submit assignment, dinonaktifkan jika sudah tutup
            // if (!isAssignmentClosed)
            //   Center(
            //     child: ElevatedButton(
            //       onPressed: () =>
            //           _navigateToSubmitAssignment(widget.assignment),
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.orange,
            //       ),
            //       child: const Text(
            //         'Submit Assignment',
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}

void _showSubmissionDetail(BuildContext context, Submission submission) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Submission by ${submission.submitterName}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Submitted at: ${submission.submissionTime}'),
            const SizedBox(height: 16),
            Text('File: ${submission.filePath}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (submission.filePath == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Doesnt have file')),
                  );
                  Navigator.pop(context); // Close the dialog
                  return;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewFilePage(
                              assignmentId: submission.submission_id!,
                              fileName: submission.filePath!,
                            )));
                // // Logic to open the file or navigate to file viewer
                // Navigator.pop(context); // Close the dialog
              },
              child: const Text('View File'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
