import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradeScreen extends StatefulWidget {
  const GradeScreen({super.key});

  @override
  State<GradeScreen> createState() => _GradeScreenState();
}

class _GradeScreenState extends State<GradeScreen> {
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
              padding: EdgeInsets.all(20),
              child: Image.asset(
                './../../image/logo.jpeg',
              ),
            ),
            Divider(
              thickness: 3,
              color: Color.fromARGB(255, 231, 125, 11),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "Dashboard",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/attendance');
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "Attendance",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/grade');
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "Grade",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/announcements');
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "Announcements",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print('to be implemented');
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "Schedule",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print('to be implemented');
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "Reports",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0), // Apply padding here
            child: InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Icon(
                Icons.menu,
                size: 50,
              ),
            ),
          );
        }),
        backgroundColor: Color.fromARGB(255, 231, 125, 11),
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Menu',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        toolbarHeight: 100,
      ),
      body: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: 470,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 245, 183, 116),
                  borderRadius: BorderRadius.circular(20)),
              width: 300,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Text("A"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Student ID',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Subject',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '    : Angela Yang',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '    : ST00001',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '    : Sciences',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Scores",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 125, 11),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Assignment",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text(
                                '80',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 125, 11),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Mid Term",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text(
                                '80',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 125, 11),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Semester",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text(
                                '80',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
