import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_be/services/teacher-service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
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
                        onPressed: () async {
                          Navigator.pushNamed(context, '/choose-teacher-role');
                        },
                        child: Text(
                          'Teacher',
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
                        onPressed: () async {
                          if (idEditingController.text == 'admin' &&
                              passwordEditingController.text == '123456') {
                            Navigator.pushNamed(context, '/admin-page');
                          } else {
                            try {
                              final response = await TeacherService().login(
                                  idEditingController.text,
                                  passwordEditingController.text,
                                  '');

                              Navigator.pushNamed(context, '/dashboard');
                            } catch (e) {
                              print('error ini di login screen');
                              print(e);
                            }
                          }
                        },
                        child: Text(
                          'Student',
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
