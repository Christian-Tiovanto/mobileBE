import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceDetail extends StatefulWidget {
  final DateTime selectedDate;

  const AttendanceDetail({super.key, required this.selectedDate});

  @override
  _AttendanceDetailState createState() => _AttendanceDetailState();
}

class _AttendanceDetailState extends State<AttendanceDetail> {
  final Map<String, String> _attendanceStatus = {};

  final List<String> _students = [
    'Angela Yang',
    'Benaro',
    'Cherrilyn',
    'Davin Alvaro',
  ];

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
        backgroundColor: Colors.orange,
        title: const Text('Attendance'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
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
    String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(widget.selectedDate);

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
        _buildAttendanceField('Present', _getCount('Present')),
        const SizedBox(height: 10),
        _buildAttendanceField('Permission', _getCount('Permission')),
        const SizedBox(height: 10),
        _buildAttendanceField('Sick', _getCount('Sick')),
        const SizedBox(height: 10),
        _buildAttendanceField('Absent', _getCount('Absent')),
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
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
              _attendanceStatus[student] = 'Present';
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
        children: _students.map((student) => _buildStudentRow(student)).toList(),
      ),
    );
  }

  Widget _buildStudentRow(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 16),
          ),
          DropdownButton<String>(
            value: _attendanceStatus[name],
            items: const [
              DropdownMenuItem(
                value: 'Present',
                child: Text('Present'),
              ),
              DropdownMenuItem(
                value: 'Permission',
                child: Text('Permission'),
              ),
              DropdownMenuItem(
                value: 'Sick',
                child: Text('Sick'),
              ),
              DropdownMenuItem(
                value: 'Absent',
                child: Text('Absent'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _attendanceStatus[name] = value!;
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
      onPressed: () {
        if (_attendanceStatus.length < _students.length) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Incomplete Data'),
                content: const Text('Attendance data is incomplete, please check again.'),
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
          Navigator.pushReplacementNamed(context, '/attendance');
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
