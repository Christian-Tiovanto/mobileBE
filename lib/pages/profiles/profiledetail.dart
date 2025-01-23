import 'package:flutter/material.dart';
import 'package:mobile_be/model/studentmodel.dart';
import 'package:mobile_be/services/student-service.dart';

class ProfileDetail extends StatefulWidget {
  final String userId;
  const ProfileDetail({super.key, required this.userId});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  Future<dynamic> getStudentByUserId(String userId) {
    final results = StudentService().getStudentByUserId(userId);

    return results;
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Student Details
            FutureBuilder(
                future: getStudentByUserId(widget.userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error} has occured'),
                      );
                    } else if (snapshot.hasData) {
                      final data = snapshot.data as Student;
                      return Column(
                        children: [
                          detailItem('Student Id', data.user_id),
                          detailItem('Name', data.name),
                          detailItem('Phone Number', '${data.phone_number}'),
                        ],
                      );
                    }
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }

  // Widget for displaying each detail
  Widget detailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
