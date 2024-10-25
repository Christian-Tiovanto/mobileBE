import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_be/announcement/announcement_detail.dart';
import 'package:mobile_be/announcement/announcement_screen.dart';
import 'package:mobile_be/attendance/attendancescreen.dart';
import 'package:mobile_be/dashboard/dashboard_screen.dart';
import 'package:mobile_be/authentication/forgot_password_screen.dart';
import 'package:mobile_be/authentication/insert_new_password.dart';
import 'package:mobile_be/authentication/login_screen.dart';
import 'package:mobile_be/grade/grade_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/login",
        routes: {
          '/login': (BuildContext context) => LoginPage(),
          '/forgot-password': (BuildContext context) => ForgotPassword(),
          '/dashboard': (BuildContext context) => Dashboard(),
          '/insert-new-password': (BuildContext context) => InsertNewPassword(),
          '/attendance': (BuildContext context) => AttendanceScreen(),
          '/grade': (BuildContext context) => GradeScreen(),
          '/announcements': (BuildContext context) => AnnouncementScreen(),
          '/announcements/detail': (BuildContext context) =>
              AnnouncementDetail()
        });
  }
}
