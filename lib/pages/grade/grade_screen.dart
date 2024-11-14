import 'package:flutter/material.dart';
import 'package:mobile_be/model/grade-model.dart';
import 'package:mobile_be/model/studentmodel.dart';
import 'package:mobile_be/services/grade-service.dart';

class GradeScreen extends StatefulWidget {
  // final Student student;
  final String lessonName;
  final String class_id;
  final String student_uid;
  const GradeScreen(
      {super.key,
      required this.lessonName,
      required this.class_id,
      required this.student_uid});

  @override
  State<GradeScreen> createState() => _GradeScreenState();
}

class _GradeScreenState extends State<GradeScreen> {
  Future<dynamic> getStudentGrade(
      String userId, String subject, String classroom) {
    final results = GradeService().getStudentGrade(userId, subject, classroom);
    print('results di grade');
    print(results);
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                'image/logo.jpeg',
              ),
            ),
            const Divider(
              thickness: 3,
              color: Color.fromARGB(255, 231, 125, 11),
            ),
            ..._buildDrawerItems(context),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Icon(
                Icons.menu,
                size: 50,
              ),
            ),
          );
        }),
        backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        title: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Menu',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getStudentGrade(widget.student_uid, 'science', '6A'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error} has occured'),
                  );
                } else if (snapshot.hasData) {
                  print('data di studentgrade');
                  final grade = snapshot.data as Grade;
                  print(grade);
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 245, 183, 116),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 300,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Text(
                                "A",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  shadows: [
                                    Shadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      offset: const Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Name',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                      Text('Student ID',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                      Text('Subject',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('    : ${grade.student_name}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                      Text('    : ${grade.student_id}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                      Text('    : ${grade.subject}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Text(
                              "Scores",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            _buildScoreRow(
                                "Assignment", grade.assignment_score),
                            const SizedBox(height: 20),
                            _buildScoreRow("Mid Term", grade.mid_term_score),
                            const SizedBox(height: 20),
                            _buildScoreRow("Semester", grade.semester_score),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 231, 125, 11),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 12),
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              child: const Text("Back"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
              return Center(child: CircularProgressIndicator());
            }),
        // child: Align(
        //   alignment: Alignment.topCenter,
        //   child: Padding(
        //     padding: const EdgeInsets.only(top: 30),
        //     child: Container(
        //       padding: const EdgeInsets.all(16),
        //       decoration: BoxDecoration(
        //         color: const Color.fromARGB(255, 245, 183, 116),
        //         borderRadius: BorderRadius.circular(20),
        //       ),
        //       width: 300,
        //       child: Column(
        //         children: [
        //           CircleAvatar(
        //             radius: 30,
        //             backgroundColor: Colors.white,
        //             child: Text(
        //               "A",
        //               style: TextStyle(
        //                 fontSize: 40,
        //                 fontWeight: FontWeight.bold,
        //                 color: Colors.black,
        //                 shadows: [
        //                   Shadow(
        //                     color: Colors.grey.withOpacity(0.5),
        //                     offset: const Offset(2.0, 2.0),
        //                     blurRadius: 3.0,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(20.0),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 const Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text('Name',
        //                         style: TextStyle(
        //                             fontSize: 16, fontWeight: FontWeight.w500)),
        //                     Text('Student ID',
        //                         style: TextStyle(
        //                             fontSize: 16, fontWeight: FontWeight.w500)),
        //                     Text('Subject',
        //                         style: TextStyle(
        //                             fontSize: 16, fontWeight: FontWeight.w500)),
        //                   ],
        //                 ),
        //                 const SizedBox(width: 20),
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text('    : ${widget.student.name}',
        //                         style: const TextStyle(
        //                             fontSize: 16, fontWeight: FontWeight.w500)),
        //                     Text('    : ${widget.student.name}',
        //                         style: const TextStyle(
        //                             fontSize: 16, fontWeight: FontWeight.w500)),
        //                     Text('    : ${widget.student.name}',
        //                         style: const TextStyle(
        //                             fontSize: 16, fontWeight: FontWeight.w500)),
        //                   ],
        //                 )
        //               ],
        //             ),
        //           ),
        //           const Text(
        //             "Scores",
        //             style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        //           ),
        //           const SizedBox(height: 10),
        //           // _buildScoreRow("Assignment", widget.student.assignmentScore),
        //           // const SizedBox(height: 20),
        //           // _buildScoreRow("Mid Term", widget.student.midTermScore),
        //           // const SizedBox(height: 20),
        //           // _buildScoreRow("Semester", widget.student.semesterScore),
        //           const SizedBox(height: 20),
        //           ElevatedButton(
        //             onPressed: () {
        //               Navigator.pop(context);
        //             },
        //             style: ElevatedButton.styleFrom(
        //               backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        //               padding: const EdgeInsets.symmetric(
        //                   horizontal: 40, vertical: 12),
        //               textStyle: const TextStyle(
        //                   fontSize: 20, fontWeight: FontWeight.bold),
        //             ),
        //             child: const Text("Back"),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  List<Widget> _buildDrawerItems(BuildContext context) {
    return [
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/dashboard');
        },
        child: const Card(
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
              "Dashboard",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildScoreRow(String label, int score) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 231, 125, 11),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '$score',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
