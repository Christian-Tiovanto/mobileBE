import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnnouncementDetail extends StatefulWidget {
  const AnnouncementDetail({super.key});

  @override
  State<AnnouncementDetail> createState() => _AnnouncementDetailState();
}

class _AnnouncementDetailState extends State<AnnouncementDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 231, 125, 11),
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Announcements',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        toolbarHeight: 100,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 170,
              color: Colors.amber,
              child: Center(child: Text("Image")),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Happy Teacher Day",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  "This is the content of the announcement",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
