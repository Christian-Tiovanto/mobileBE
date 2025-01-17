import 'package:flutter/material.dart';
import 'package:mobile_be/model/assignment.dart';
import 'package:mobile_be/pages/Assignment/Assignment/assignment_detail.dart';
import 'package:mobile_be/pages/Assignment/Assignment/assignment_form.dart';
import 'package:mobile_be/services/assignment-service.dart';

class AssignmentList extends StatefulWidget {
  String classroomId;
  AssignmentList({Key? key, required this.classroomId}) : super(key: key);

  @override
  _AssignmentListState createState() => _AssignmentListState();
}

class _AssignmentListState extends State<AssignmentList> {
  List<Assignment> assignments = [];
  Future<List<Assignment>> getAllAssignmentByClassId(String classId) {
    final results = AssignmentService().getAllAssignmentByClassId(classId);
    print('results di get class teacher');
    print(results);
    return results;
  }

  void _navigateToAddAssignment() async {
    print('widget.classroomId');
    print(widget.classroomId);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AssignmentForm(
                classId: widget.classroomId,
              )),
    );

    if (result != null && result is Assignment) {
      setState(() {
        assignments.add(result);
      });
    }
  }

  void _navigateToDetail(Assignment assignment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssignmentDetail(assignment: assignment),
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
          future: getAllAssignmentByClassId(widget.classroomId),
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
                        child: Text(
                            'No assignments yet. Tap the + button to add one.'),
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
                            onTap: () => _navigateToDetail(assignment),
                          );
                        },
                      );
              }
            }
            return Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddAssignment,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
