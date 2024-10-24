import 'package:flutter/material.dart';
import 'package:mobile_be/attendance/attendancescreen.dart';
import 'package:mobile_be/dashboard/dashboard_screen.dart';
import 'package:mobile_be/authentication/forgot_password_screen.dart';
import 'package:mobile_be/authentication/insert_new_password.dart';
import 'package:mobile_be/authentication/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AttendanceScreen(),
      ),
    );
  }
}
