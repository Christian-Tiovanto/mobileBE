import 'package:flutter/material.dart';

class Scheduledetail extends StatelessWidget {
  final String day;
  const Scheduledetail({required this.day, super.key});

  @override
  Widget build(BuildContext context) {
    final schedules = getScheduleForDay(day);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            day,
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < schedules.length; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            schedules[i]['title']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Text(schedules[i]['time']!),
                      ],
                    ),
                    if (i < schedules.length - 1) const Divider(height: 24.0),
                  ],
                ),
            ],
          ),
        ));
  }

  List<Map<String, String>> getScheduleForDay(String day) {
    switch (day) {
      case 'Monday':
        return [
          {'title': 'Warming up', 'time': '08.10 - 08.20'},
          {'title': 'Vocabulary', 'time': '08.20 - 09.00'},
          {'title': 'Music', 'time': '09.00 - 09.40'},
          {'title': 'Art', 'time': '09.40 - 10.20'},
          {'title': 'Break Time', 'time': '10.20 - 10.50'},
          {'title': 'Social Studies', 'time': '10.50 - 11.30'},
          {'title': 'Comprehension', 'time': '11.30 - 12.10'},
        ];
      case 'Tuesday':
        return [
          {'title': 'Warming up', 'time': '08.10 - 08.20'},
          {'title': 'Religion', 'time': '08.20 - 09.00'},
          {'title': 'Science', 'time': '09.00 - 09.40'},
          {'title': 'Science', 'time': '09.40 - 10.20'},
          {'title': 'Break Time', 'time': '10.20 - 10.50'},
          {'title': 'Chinese', 'time': '10.50 - 11.30'},
          {'title': 'Chinese', 'time': '11.30 - 12.10'},
        ];
      case 'Wednesday':
        return [
          {'title': 'Warming up', 'time': '08.10 - 08.20'},
          {'title': 'PE', 'time': '08.20 - 09.00'},
          {'title': 'Math', 'time': '09.00 - 09.40'},
          {'title': 'Math', 'time': '09.40 - 10.20'},
          {'title': 'Break Time', 'time': '10.20 - 10.50'},
          {'title': 'Pancasila', 'time': '10.50 - 11.30'},
          {'title': 'IT', 'time': '11.30 - 12.10'},
        ];
      case 'Thursday':
        return [
          {'title': 'Warming up', 'time': '08.10 - 08.20'},
          {'title': 'Grammar', 'time': '08.20 - 09.00'},
          {'title': 'Comprehension', 'time': '09.00 - 09.40'},
          {'title': 'Craft', 'time': '09.40 - 10.20'},
          {'title': 'Break Time', 'time': '10.20 - 10.50'},
          {'title': 'Bahasa', 'time': '10.50 - 11.30'},
          {'title': 'Grammar', 'time': '11.30 - 12.10'},
        ];
      case 'Friday':
        return [
          {'title': 'Warming up', 'time': '08.10 - 08.20'},
          {'title': 'Math', 'time': '08.20 - 09.00'},
          {'title': 'Math', 'time': '09.00 - 09.40'},
          {'title': 'Chinese', 'time': '09.40 - 10.20'},
          {'title': 'Break Time', 'time': '10.20 - 10.50'},
          {'title': 'Chinese', 'time': '10.50 - 11.30'},
          {'title': 'Vocabulary', 'time': '11.30 - 12.10'},
        ];
      default:
        return [];
    }
  }
}
