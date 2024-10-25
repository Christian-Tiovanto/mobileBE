import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceDetail extends StatelessWidget {
  final DateTime selectedDate;

  AttendanceDetail({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formattedDate,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 20),
            Text('Attendance details for the selected date...'),
          ],
        ),
      ),
    );
  }
}
