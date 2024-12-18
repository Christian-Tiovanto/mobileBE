import 'package:flutter/material.dart';
import 'package:mobile_be/pages/schedules/scheduledetail.dart';

class Schedulescreen extends StatefulWidget {
  const Schedulescreen({super.key});

  @override
  State<Schedulescreen> createState() => _SchedulescreenState();
}

class _SchedulescreenState extends State<Schedulescreen> {
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
            'Schedule',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        toolbarHeight: 100,
      ),
      body: ListView(
        children: [
          WeekDayItem(
              day: 'Monday',
              onTap: () => navigateToSchedule(context, 'Monday')),
          WeekDayItem(
              day: 'Tuesday',
              onTap: () => navigateToSchedule(context, 'Tuesday')),
          WeekDayItem(
              day: 'Wednesday',
              onTap: () => navigateToSchedule(context, 'Wednesday')),
          WeekDayItem(
              day: 'Thursday',
              onTap: () => navigateToSchedule(context, 'Thursday')),
          WeekDayItem(
              day: 'Friday',
              onTap: () => navigateToSchedule(context, 'Friday')),
        ],
      ),
    );
  }

  void navigateToSchedule(BuildContext context, String day) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scheduledetail(day: day),
      ),
    );
  }
}

class WeekDayItem extends StatelessWidget {
  final String day;
  final VoidCallback onTap;

  const WeekDayItem({required this.day, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              day,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
