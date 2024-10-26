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
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  './../../image/logo.jpeg',
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
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 300,
                height: 150,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.amber,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 16.0),
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
                        child: const Center(child: Text("image")),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        color: Colors.amber,
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 227, 132, 36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/announcements/detail');
                              // Add your onPressed code here!
                            },
                            child: const Text(
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
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                height: 150,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.amber,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 16.0),
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
                        child: const Center(child: Text("image")),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        color: Colors.amber,
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 227, 132, 36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/announcements/detail');
                              // Add your onPressed code here!
                            },
                            child: const Text(
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
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                height: 150,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.amber,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 16.0),
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
                        child: const Center(child: Text("image")),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        color: Colors.amber,
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 227, 132, 36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/announcements/detail');
                              // Add your onPressed code here!
                            },
                            child: const Text(
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
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                height: 150,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.amber,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 16.0),
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
                        child: const Center(child: Text("image")),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        color: Colors.amber,
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 227, 132, 36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/announcements/detail');
                              // Add your onPressed code here!
                            },
                            child: const Text(
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
