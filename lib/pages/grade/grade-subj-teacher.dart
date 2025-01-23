import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_be/services/grade-service.dart';

class GradeDetailPage extends StatefulWidget {
  final String classId;

  GradeDetailPage({required this.classId});

  @override
  _GradeDetailPageState createState() => _GradeDetailPageState();
}

class _GradeDetailPageState extends State<GradeDetailPage> {
  Future<dynamic> getAllGradeTeacherTeach() {
    final results = GradeService().getAllGradeByClassNPopulate(widget.classId);

    return results;
  }

  List<dynamic> students = [];

  // Input formatter to allow only numbers between 0-100
  final TextInputFormatter numberInputFormatter =
      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]$|^[1-9][0-9]$|^100$'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange, // Set AppBar color to orange
        title: Text(
          'Grade',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text('Name',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('assignment_score',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('mid_term_score',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('semester_score',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            Divider(),
            FutureBuilder(
                future: getAllGradeTeacherTeach(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error} has occured'),
                      );
                    } else if (snapshot.hasData) {
                      students = snapshot.data;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            final student = students[index];

                            return Row(
                              children: [
                                Expanded(child: Text(student['name'])),
                                Expanded(
                                    child: Text(student['assignment_score']
                                        .toString())),
                                Expanded(
                                  child: TextField(
                                    inputFormatters: [numberInputFormatter],
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      // setState(() {
                                      // Ensure the value is within the range 0-100
                                      student['mid_term_score'] =
                                          (int.tryParse(value) ?? 0)
                                              .clamp(0, 100);
                                      // });
                                    },
                                    decoration: InputDecoration(
                                      hintText: "${student['mid_term_score']}",
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(8),
                                      border: InputBorder
                                          .none, // Remove the underline
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    inputFormatters: [numberInputFormatter],
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      // setState(() {
                                      // Ensure the value is within the range 0-100
                                      student['semester_score'] =
                                          (int.tryParse(value) ?? 0)
                                              .clamp(0, 100);
                                      // });?
                                    },
                                    decoration: InputDecoration(
                                      hintText: "${student['semester_score']}",
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(8),
                                      border: InputBorder
                                          .none, // Remove the underline
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            SizedBox(height: 16), // Add some spacing
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await GradeService().updateGradeScoreBulk(students);
                  // Handle save action
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Data Saved')));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Button background color
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.white), // Text color inside button
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
