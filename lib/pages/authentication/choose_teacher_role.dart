import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_be/pages/authentication/login_screen_teacher.dart';
import 'package:mobile_be/services/teacher-service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseTeacherRoleScreen extends StatefulWidget {
  const ChooseTeacherRoleScreen({super.key});

  @override
  State<ChooseTeacherRoleScreen> createState() =>
      _ChooseTeacherRoleScreenState();
}

class _ChooseTeacherRoleScreenState extends State<ChooseTeacherRoleScreen> {
  final idEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 200,
                width: 300,
                child: Image(image: AssetImage('image/logo.jpeg')),
              ),
              Text(
                AppLocalizations.of(context)!.welcome_login,
                style: TextStyle(fontSize: 40),
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 186, 115),
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Text(
                      'Choose Role You Want to Log In',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      constraints: const BoxConstraints.tightFor(width: 200),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.blue,
                          backgroundColor:
                              const Color.fromARGB(255, 227, 132, 36),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPageTeacher(
                                        dashboardRoute: '/dashboard',
                                        forType: 'homeroom_teacher',
                                      )));
                        },
                        child: Text(
                          'Homeroom Teacher',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      constraints: const BoxConstraints.tightFor(width: 200),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.blue,
                          backgroundColor:
                              const Color.fromARGB(255, 227, 132, 36),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPageTeacher(
                                        dashboardRoute:
                                            '/dashboard-subj-teacher',
                                        forType: 'subject_teacher',
                                      )));
                        },
                        child: Text(
                          'Subject Teacher',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
