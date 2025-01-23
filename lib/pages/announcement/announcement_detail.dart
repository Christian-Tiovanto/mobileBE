import 'package:flutter/material.dart';
import 'package:mobile_be/main.dart';

class AnnouncementDetail extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final String date;
  final String file_url;

  const AnnouncementDetail(
      {super.key,
      required this.title,
      required this.image,
      required this.description,
      required this.date,
      required this.file_url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 170,
              color: Colors.amber,
              child: Image.network(
                'http://$baseHost:$basePort/api/v1/announcement/${file_url}/file',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Image failed to load.'));
                },
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                date,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
