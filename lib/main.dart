import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_be/pages/announcement/announcement_detail.dart';
import 'package:mobile_be/pages/announcement/announcement_screen.dart';
import 'package:mobile_be/pages/attendance/attendancescreen.dart';
import 'package:mobile_be/pages/dashboard/dashboard_screen.dart';
import 'package:mobile_be/pages/authentication/forgot_password_screen.dart';
import 'package:mobile_be/pages/authentication/insert_new_password.dart';
import 'package:mobile_be/pages/authentication/login_screen.dart';
import 'package:mobile_be/pages/grade/grade_screen.dart';
import 'package:mobile_be/pages/grade/lessongrade.dart';
import 'package:mobile_be/pages/grade/studentgrade.dart';

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
          '/login': (BuildContext context) => const LoginPage(),
          '/forgot-password': (BuildContext context) => const ForgotPassword(),
          '/dashboard': (BuildContext context) => const Dashboard(),
          '/insert-new-password': (BuildContext context) => const InsertNewPassword(),
          '/attendance': (BuildContext context) => const AttendanceScreen(),
          '/grade': (BuildContext context) => LessonGrade(),
          '/announcements': (BuildContext context) => const AnnouncementScreen(),
          '/announcements/detail': (BuildContext context) =>
              const AnnouncementDetail()
        });
  }
}
