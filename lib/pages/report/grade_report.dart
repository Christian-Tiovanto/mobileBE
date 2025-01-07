import 'package:flutter/material.dart';
import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/model/grade-model.dart';
import 'package:mobile_be/model/studentmodel.dart';
import 'package:mobile_be/services/attendance-service.dart';
import 'package:mobile_be/services/grade-service.dart';

class GradeReport extends StatefulWidget {
  final Student student;
  const GradeReport({super.key, required this.student});

  @override
  State<GradeReport> createState() => _GradeReportState();
}

class _GradeReportState extends State<GradeReport> {
  final List<Student> subjects = [
    Student(
      id: '1',
      user_id: '1',
      class_id: Classroom(id: '6A'),
      name: 'Angela Yang',
    ),
  ];

  Future<dynamic> getStudentNItsGrade() async {
    final results = await GradeService()
        .getStudentNItsGrade(widget.student.id, widget.student.class_id.id);
    print('results di grade');
    print(results);
    return results;
  }

  Future<dynamic> getAttendanceCount(String status) async {
    final results = await AttendanceService().getAttendanceCount(
        widget.student.id, widget.student.class_id.id, status);
    print('results di grade');
    print(results);
    return results;
  }

  @override
  Widget build(BuildContext context) {
    final studentSubjects =
        subjects.where((s) => s.name == widget.student.name).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.student.name),
          backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        ),
        body: FutureBuilder(
            future: getStudentNItsGrade(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error} has occured'),
                  );
                } else if (snapshot.hasData) {
                  final List<Grade> data = snapshot.data;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Grades Table
                        Table(
                          border: TableBorder.all(color: Colors.grey),
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(1),
                            3: FlexColumnWidth(1),
                          },
                          children: [
                            const TableRow(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 245, 230, 204)),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Subject',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Assignment',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'MidTerm',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Semester',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            for (var subject in data)
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(subject.subject),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        subject.assignment_score.toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Text(subject.mid_term_score.toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Text(subject.semester_score.toString()),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Absence Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildAbsenceField('Sick', 'sakit'),
                            _buildAbsenceField('Permission', 'izin'),
                            _buildAbsenceField('Absent', 'absen'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Note Section
                      ],
                    ),
                  );
                }
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  Widget _buildAbsenceField(String fieldName, String status) {
    return FutureBuilder(
        future: getAttendanceCount(status),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error} has occured'),
              );
            } else if (snapshot.hasData) {
              final count = snapshot.data;
              return Expanded(
                child: Column(
                  children: [
                    Text(fieldName,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: Center(child: Text("$count Days")),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                    )
                  ],
                ),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
