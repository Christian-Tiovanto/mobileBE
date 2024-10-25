import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              Container(
                width: 200,
                height: 200,
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Image.asset(
                  './../../image/logo.jpeg',
                ),
              ),
              Divider(
                thickness: 3,
                color: Color.fromARGB(255, 231, 125, 11),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      "Dashboard",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/attendance');
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      "Attendance",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/grade');
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
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
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      "Announcements",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print('to be implemented');
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      "Schedule",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print('to be implemented');
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      "Reports",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(left: 20.0), // Apply padding here
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(
                  Icons.menu,
                  size: 50,
                ),
              ),
            );
          }),
          backgroundColor: Color.fromARGB(255, 231, 125, 11),
          title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          toolbarHeight: 100,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                width: 300,
                height: 150,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Teacher Day",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.lightBlue,
                        width: double.infinity,
                        child: Center(child: Text("image")),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        color: Colors.amber,
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              backgroundColor:
                                  Color.fromARGB(255, 227, 132, 36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/announcements/detail');
                              // Add your onPressed code here!
                            },
                            child: Text(
                              'View Detail',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                height: 150,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Teacher Day",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.lightBlue,
                        width: double.infinity,
                        child: Center(child: Text("image")),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        color: Colors.amber,
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              backgroundColor:
                                  Color.fromARGB(255, 227, 132, 36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/announcements/detail');
                              // Add your onPressed code here!
                            },
                            child: Text(
                              'View Detail',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                height: 150,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Teacher Day",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.lightBlue,
                        width: double.infinity,
                        child: Center(child: Text("image")),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        color: Colors.amber,
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              backgroundColor:
                                  Color.fromARGB(255, 227, 132, 36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/announcements/detail');
                              // Add your onPressed code here!
                            },
                            child: Text(
                              'View Detail',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                height: 150,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Teacher Day",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.lightBlue,
                        width: double.infinity,
                        child: Center(child: Text("image")),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        color: Colors.amber,
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              backgroundColor:
                                  Color.fromARGB(255, 227, 132, 36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/announcements/detail');
                              // Add your onPressed code here!
                            },
                            child: Text(
                              'View Detail',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
