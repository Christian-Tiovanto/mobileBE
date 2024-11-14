import 'package:flutter/material.dart';
import 'package:mobile_be/pages/announcement/announcement_detail.dart';
import 'package:mobile_be/pages/announcement/announcement_screen.dart';
import 'package:mobile_be/pages/attendance/attendancescreen.dart';
import 'package:mobile_be/pages/authentication/forgot_password_screen.dart';
import 'package:mobile_be/pages/authentication/insert_new_password.dart';
import 'package:mobile_be/pages/authentication/login_screen.dart';
import 'package:mobile_be/pages/dashboard/dashboard_screen.dart';
import 'package:mobile_be/pages/grade/choose-class_screen.dart';
import 'package:mobile_be/pages/grade/lessongrade.dart';

import 'package:mobile_be/pages/teachers/teacher_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';


Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  return token != null;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final loggedIn = await isLoggedIn();
  print('loggedIn');
  print(loggedIn);
  runApp(MainApp(
    isLoggedIn: loggedIn,
  ));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  const MainApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? Dashboard() : LoginPage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case '/forgot-password':
            return MaterialPageRoute(
                builder: (context) => const ForgotPassword());
          case '/dashboard':
            return MaterialPageRoute(builder: (context) => const Dashboard());
          case '/insert-new-password':
            return MaterialPageRoute(
                builder: (context) => const InsertNewPassword());
          case '/attendance':
            return MaterialPageRoute(
                builder: (context) => const AttendanceScreen());
          case '/grade':
            return MaterialPageRoute(
                builder: (context) => PickSubjectPage(
                      classId: '',
                    ));
          case '/choose-class-grade':
            return MaterialPageRoute(builder: (context) => ChooseClassPage());
          case '/announcements':
            return MaterialPageRoute(
                builder: (context) => const AnnouncementScreen());
          case '/announcements/detail':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => AnnouncementDetail(
                title: args['title'],
                image: args['image'],
                description: args['description'],
                date: args['date'],
              ),
            );
          default:
            return MaterialPageRoute(builder: (context) => const LoginPage());
        }
      },

    );
  }
}
