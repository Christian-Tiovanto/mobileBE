import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            child: Text("img"),
            height: 300,
            width: 300,
            color: Colors.blue,
          ),
          Text(
            "Welcome Back Teachers",
            style: TextStyle(fontSize: 20),
          ),
          Container(
            child: Column(
              children: [],
            ),
          )
        ],
      ),
    );
  }
}
