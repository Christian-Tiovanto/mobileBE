import 'package:flutter/material.dart';
import 'package:mobile_be/database_helper.dart';
import 'package:mobile_be/pages/announcement/announcement_detail.dart';
import 'package:mobile_be/pages/announcement/ann_data.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  late Future<List<Announcement>> _announcementList;
  late DatabaseHelper _database;
  @override
  void initState() {
    super.initState();
    _database = DatabaseHelper();
    _announcementList = _database.getAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
      ),
      body: FutureBuilder<List<Announcement>>(
        future: _announcementList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final announcements = snapshot.data!;
            if (announcements.isEmpty) {
              return Center(
                child: ElevatedButton(
                    onPressed: () async {
                      await _database.insertAnnouncement(Announcement(
                          title: 'tes',
                          image: 'image/qualification.png',
                          description: 'tes',
                          date: 'tes'));
                    },
                    child: Text('No announcements available.')),
              );
            }

            // return ElevatedButton(
            //     onPressed: () async {
            //       await _database.deleteAllAnnouncements();
            //     },
            //     child: Text("delete all"));

            return ListView.builder(
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(announcements[index].title),
                  subtitle: Text(announcements[index].description),
                  leading: Image.asset(
                    announcements[index].image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  trailing: Text(announcements[index].date),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnnouncementDetail(
                          title: announcements[index].title,
                          image: announcements[index].image,
                          description: announcements[index].description,
                          date: announcements[index].date,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
