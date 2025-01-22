import 'package:flutter/material.dart';
import 'package:mobile_be/model/attendance-model.dart';
import 'package:mobile_be/services/attendance-service.dart';

class AttendanceStudentScreen extends StatefulWidget {
  const AttendanceStudentScreen({super.key});

  @override
  _AttendanceStudentScreenState createState() =>
      _AttendanceStudentScreenState();
}

class _AttendanceStudentScreenState extends State<AttendanceStudentScreen> {
  // Sample data for days and dates
  Future<dynamic> getAttendanceByStudentId() {
    final results = AttendanceService().getAttendanceByStudentId();
    print('results di get class teacher');
    print(results);
    return results;
  }

  final List<Map<String, dynamic>> attendanceData = [
    {"date": DateTime.now().subtract(Duration(days: 0)), "status": "present"},
    {"date": DateTime.now().subtract(Duration(days: 1)), "status": "sick"},
    {"date": DateTime.now().subtract(Duration(days: 2)), "status": "absent"},
    {
      "date": DateTime.now().subtract(Duration(days: 3)),
      "status": "permission",
      "reason": "Family event"
    },
    {"date": DateTime.now().subtract(Duration(days: 4)), "status": "present"},
    {"date": DateTime.now().subtract(Duration(days: 5)), "status": "sick"},
    {"date": DateTime.now().subtract(Duration(days: 6)), "status": "absent"},
    {
      "date": DateTime.now().subtract(Duration(days: 7)),
      "status": "permission",
      "reason": "Doctor appointment"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Attendance'),
          backgroundColor: Colors.orange,
        ),
        body: FutureBuilder(
            future: getAttendanceByStudentId(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error} has occured'),
                  );
                } else if (snapshot.hasData) {
                  print('snapshot.data di AttendanceStudentScreen');
                  print(snapshot.data);
                  final List<Attendance> data = snapshot.data;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      // final data = sortedData[index];

                      return ListTile(
                        title: Text(
                          "${_getDayName(data[index].date!)}, ${data[index].date!.day} ${_getMonthName(data[index].date!.month)} ${data[index].date!.year}",
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.info,
                            color: _getStatusColor(data[index].status),
                          ),
                          onPressed: () {
                            _showStatusMessage(context, data[index].status,
                                'No reason provided');
                          },
                        ),
                      );
                    },
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  void _showStatusMessage(BuildContext context, String status, String? reason) {
    String title;
    String? subtitle;

    switch (status) {
      case "present":
        title = "You are present";
        break;
      case "sick":
        title = "You are sick";
        break;
      case "absent":
        title = "You are absent";
        break;
      case "permission":
        title = "You take permission";
        subtitle = reason;
        break;
      default:
        title = "Unknown status";
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: subtitle != null ? Text(subtitle) : null,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "present":
        return Colors.green;
      case "izin":
      case "sakit":
        return Colors.orange;
      case "absen":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Helper to get day name
  String _getDayName(DateTime date) {
    const days = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ];
    return days[date.weekday - 1];
  }

  // Helper to get month name
  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }
}
