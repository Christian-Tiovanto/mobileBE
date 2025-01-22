import 'package:flutter/material.dart';
import 'package:mobile_be/model/assignment.dart';
import 'package:mobile_be/pages/Assignment/Assignment/assignment_detail.dart';
import 'package:mobile_be/pages/Assignment/Assignment/assignment_form.dart';
import 'package:mobile_be/pages/Assignment/Assignment/submitAssignment.dart';
import 'package:mobile_be/services/assignment-service.dart';

class StudentAssignmentList extends StatefulWidget {
  StudentAssignmentList({Key? key}) : super(key: key);

  @override
  _StudentAssignmentListState createState() => _StudentAssignmentListState();
}

class _StudentAssignmentListState extends State<StudentAssignmentList> {
  List<Assignment> assignments = [];
  Future<List<Assignment>> getAllAssignmentByClassId() {
    final results = AssignmentService().getAllStudentAssignment();
    print('results di get class teacher');
    print(results);
    return results;
  }

  void _navigateToSubmission(Assignment assignment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubmitAssignment(assignment: assignment),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder(
          future: getAllAssignmentByClassId(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error} has occured'),
                );
              } else if (snapshot.hasData) {
                final data = snapshot.data as List<Assignment>;
                print('data assignment');
                print(data);
                print(data.isEmpty);
                assignments = data;
                return assignments.isEmpty
                    ? const Center(
                        child: Text('No assignments yet.'),
                      )
                    : ListView.separated(
                        itemCount: assignments.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final assignment = assignments[index];
                          print('assignment ini bawah');
                          print(assignment);
                          return ListTile(
                            title: Text(
                              assignment.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Due: ${assignment.dueDate}'),
                            onTap: () => _navigateToSubmission(assignment),
                          );
                        },
                      );
              }
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
