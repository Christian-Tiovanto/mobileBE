import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_be/pages/attendance/attendancescreen.dart';
import 'package:mobile_be/widget/ImageStreamWidget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                'image/logo.jpeg',
              ),
            ),
            const Divider(
              thickness: 3,
              color: Color.fromARGB(255, 231, 125, 11),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(14.0),
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
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(14.0),
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
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(14.0),
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
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(14.0),
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
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(14.0),
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
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(14.0),
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
              child: const Icon(
                Icons.menu,
                size: 50,
              ),
            ),
          );
        }),
        backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        title: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Menu',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('image/bg_mobile_be.jpg'))),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber),
                  width: 300,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome Back"),
                          Text(
                            'Jiara Martins',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 26),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                  child: ImageStreamWidget(
                                      imageUrl:
                                          '/api/v1/teacher/6730d11712f72969415a65ae/photo'))))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 350,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AttendanceScreen()));
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Icon(
                                      Icons.assignment_turned_in_sharp,
                                      color: Colors.white,
                                      size: 80,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Attendance",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/grade');
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset(
                                      'image/qualification.png',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Grade",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/announcements');
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Image(
                                      image: AssetImage('image/marketing.png'),
                                      width: 50,
                                      height: 50,
                                      color: Colors.white,
                                    ),
                                    // child: Icon(
                                    //   Icons.assignment_turned_in_sharp,
                                    //   color: Colors.white,
                                    //   size: 80,
                                    // ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Announcements",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    print("wow");
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset(
                                      'image/reading.png',
                                      width: 50,
                                      height: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Student Profile",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    print('ea');
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset(
                                      'image/calendar.png',
                                      width: 50,
                                      height: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Schedule",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    print("wow");
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset(
                                      'image/report.png',
                                      width: 50,
                                      height: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Reports",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
