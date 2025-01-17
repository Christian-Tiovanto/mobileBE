import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_be/model/attendance-model.dart';
import 'package:mobile_be/model/studentmodel.dart';
import 'package:mobile_be/model/teachermodel.dart';
import 'package:mobile_be/services/attendance-service.dart';
import 'package:mobile_be/services/student-service.dart';
import 'package:mobile_be/services/teacher-service.dart';
import 'package:mobile_be/utils/decode-jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceDetail extends StatefulWidget {
  final DateTime selectedDate;

  const AttendanceDetail({super.key, required this.selectedDate});

  @override
  _AttendanceDetailState createState() => _AttendanceDetailState();
}

class _AttendanceDetailState extends State<AttendanceDetail> {
  final Map<String, String> _attendanceStatus = {};
  String? _jwtToken;
  late SharedPreferences _prefs;
  Map<String, dynamic>? _jwtPayload;

  Future<dynamic> getAllStudent() async {
    final _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString('token');
    if (token == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }
    _jwtPayload = decodeJwtPayload(token);
    final Teacher teacher =
        await TeacherService().getTeacherById(_jwtPayload!['id']);
    print('teacher');
    print('teacher.homeroom_class');
    print(teacher.homeroom_class!.id);
    final results =
        await StudentService().getStudentByClassId(teacher.homeroom_class!.id);
    print('results di grade');
    print(results);
    return results;
  }

  List<Student> _students = [];

  Future _removeData() async {
    print("kepanggil gak sih");
    _prefs = await SharedPreferences.getInstance();
    bool removed = await _prefs.remove('token');
    if (removed) {
      print(_prefs.getString('token'));
      setState(() {});
      print('Data removed successfully!');
    } else {
      print('Error removing data.');
    }
  }

  int _getCount(String status) {
    return _attendanceStatus.values.where((value) => value == status).length;
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
              onTap: () {
                Navigator.pushNamed(context, '/schedule');
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
            InkWell(
              onTap: () async {
                await _removeData();
                setState(() {});
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    "Log Out",
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateHeader(),
            const SizedBox(height: 20),
            _buildAttendanceFields(),
            const SizedBox(height: 20),
            _buildAllPresentButton(),
            const SizedBox(height: 20),
            _buildStudentList(),
            const SizedBox(height: 20),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateHeader() {
    String formattedDate =
        DateFormat('EEEE, d MMMM yyyy').format(widget.selectedDate);
    return Text(
      formattedDate,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  Widget _buildAttendanceFields() {
    return Column(
      children: [
        _buildAttendanceField('Present', _getCount('present')),
        const SizedBox(height: 10),
        _buildAttendanceField('Permission', _getCount('izin')),
        const SizedBox(height: 10),
        _buildAttendanceField('Sick', _getCount('sakit')),
        const SizedBox(height: 10),
        _buildAttendanceField('Absent', _getCount('absen')),
      ],
    );
  }

  Widget _buildAttendanceField(String label, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 60,
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              hintText: '$count',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAllPresentButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            for (var student in _students) {
              _attendanceStatus[student.id] = 'present';
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'ALL PRESENT',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildStudentList() {
    return FutureBuilder(
      future: getAllStudent(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error} has occured'),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data as List<Student>;
            _students = data;
            if (data.length == 0) {
              return Text("No Student in this class");
            }
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: data
                    .map(
                        (student) => _buildStudentRow(student.id, student.name))
                    .toList(),
              ),
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      },
      // child:
      // Container(
      //   padding: const EdgeInsets.all(16),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10),
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey.withOpacity(0.2),
      //         spreadRadius: 2,
      //         blurRadius: 5,
      //       ),
      //     ],
      //   ),
      //   child: Column(
      //     children:
      //         _students.map((student) => _buildStudentRow(student)).toList(),
      //   ),
      // ),
    );
  }

  Widget _buildStudentRow(String id, String studentName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            studentName,
            style: const TextStyle(fontSize: 16),
          ),
          DropdownButton<String>(
            value: _attendanceStatus[id],
            items: const [
              DropdownMenuItem(
                value: 'present',
                child: Text('Present'),
              ),
              DropdownMenuItem(
                value: 'izin',
                child: Text('Permission'),
              ),
              DropdownMenuItem(
                value: 'sakit',
                child: Text('Sick'),
              ),
              DropdownMenuItem(
                value: 'absen',
                child: Text('Absent'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _attendanceStatus[id] = value!;
              });
            },
            hint: const Text('Select'),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (_attendanceStatus.length < _students.length) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Incomplete Data'),
                  content: const Text(
                      'Attendance data is incomplete, please check again.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            try {
              final List<Map<String, dynamic>> createBulkAttendanceDto =
                  _attendanceStatus.entries.map((entry) {
                return {
                  "user_id": entry.key,
                  "status": entry.value,
                  "class_id": "6A",
                  "reason": "",
                  "tahun_ajaran": "2023",
                  "date": "${widget.selectedDate}"
                };
              }).toList();

              await AttendanceService()
                  .createBulkAttendance(createBulkAttendanceDto);
              Navigator.pushReplacementNamed(context, '/attendance');
            } catch (error) {
              print(error);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error.toString())));
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'SAVE',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
