import 'package:flutter/material.dart';
import 'package:mobile_be/pages/Assignment/Assignment/student_assignment_list.dart';
import 'package:mobile_be/pages/attendance/attendance-student.dart';
import 'package:mobile_be/pages/dashboard/dashboard_screen-student.dart';
import 'package:mobile_be/pages/report/student_grade.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerStudent extends StatelessWidget {
  DrawerStudent({super.key});
  late SharedPreferences _prefs;

  Future _removeData() async {
    _prefs = await SharedPreferences.getInstance();
    bool removed = await _prefs.remove('token');
    if (removed) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => DashboardStudent()));
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
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GradeStudentReport()));
            },
            child: const Card(
              child: Padding(
                padding: EdgeInsets.all(14.0),
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
            child: const Card(
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  "Announcements",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StudentAssignmentList()));
            },
            child: const Card(
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  "Assignments",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AttendanceStudentScreen()));
            },
            child: const Card(
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  "Attendance",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await _removeData();
              Navigator.pushReplacementNamed(context, '/');
            },
            child: const Card(
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  "Log Out",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
