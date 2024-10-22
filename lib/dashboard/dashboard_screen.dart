import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(
            Icons.menu,
            size: 50,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 231, 125, 11),
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Menu",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        toolbarHeight: 100,
      ),
    );
  }
}
