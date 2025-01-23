import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_be/model/studentmodel.dart';
import 'package:mobile_be/pages/profiles/profiledetail.dart';
import 'package:mobile_be/services/student-service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String> _students = [
    'Angela Yang',
    'Benaro',
    'Cherrilyn',
    'Davin Alvaro',
  ];

  Future<dynamic> getAllStudent() {
    final results = StudentService().getAllStudent();

    return results;
  }

  List<Student> _filteredStudents = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredStudents = List.from([]);
    _searchController.addListener(() {
      setState(() {
        _filteredStudents = _filteredStudents
            .where((student) => student.name
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                onTap: () {},
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
                onTap: () {},
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
              padding: const EdgeInsets.only(left: 20.0),
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
              'Student Profiles',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          toolbarHeight: 100,
        ),
        body: FutureBuilder(
            future: getAllStudent(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error} has occured'),
                  );
                } else if (snapshot.hasData) {
                  _filteredStudents = snapshot.data as List<Student>;
                  return Column(
                    children: [
                      // Search Bar
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(Icons.search, color: Colors.grey),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  decoration: const InputDecoration(
                                    hintText: 'Search...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // List of Students
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          itemCount: _filteredStudents.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                _filteredStudents[index].name,
                                style: const TextStyle(fontSize: 18),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileDetail(
                                        userId: _filteredStudents[index].id),
                                  ),
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                        ),
                      ),
                    ],
                  );
                }
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
