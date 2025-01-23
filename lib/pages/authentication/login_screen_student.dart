import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_be/services/student-service.dart';
import 'package:mobile_be/services/teacher-service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPageStudent extends StatefulWidget {
  LoginPageStudent({super.key});

  @override
  State<LoginPageStudent> createState() => _LoginPageStudentState();
}

class _LoginPageStudentState extends State<LoginPageStudent> {
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
                    const SizedBox(
                      height: 25,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text('EMAIL'),
                    ),
                    TextField(
                      controller: idEditingController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 231, 225, 213),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 231, 225, 213),
                          ),
                        ),
                        hintText: AppLocalizations.of(context)!.email_hint,
                        fillColor: const Color.fromARGB(255, 231, 225, 213),
                        filled: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text('PASSWORD'),
                    ),
                    TextField(
                      controller: passwordEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 231, 225, 213),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 231, 225, 213),
                          ),
                        ),
                        fillColor: const Color.fromARGB(255, 231, 225, 213),
                        filled: true,
                        hintText: AppLocalizations.of(context)!.pass_hint,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                          try {
                            final response = await StudentService().login(
                                idEditingController.text,
                                passwordEditingController.text,
                                'student');

                            Navigator.pushNamed(context, '/dashboard-student');
                          } catch (e) {}
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/forgot-password');
                        },
                        child: Text(AppLocalizations.of(context)!.forgetpass)),
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
