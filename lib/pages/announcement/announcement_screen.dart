// Updated AnnouncementScreen with matching color and style as AnnouncementDetail
// Added a button for creating announcements
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_be/database_helper.dart';
import 'package:mobile_be/pages/announcement/ann_data.dart';
import 'package:mobile_be/pages/announcement/announcement_detail.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  late Future<List<Announcement>> _announcementList;

  @override
  void initState() {
    super.initState();
    _refreshAnnouncements();
  }

  void _refreshAnnouncements() {
    setState(() {
      _announcementList = DatabaseHelper().getAnnouncements();
    });
  }

  void _deleteAnnouncement(int id) async {
    await DatabaseHelper().deleteAnnouncement(id);
    _refreshAnnouncements();
  }

  Future<void> _showAnnouncementDialog([Announcement? announcement]) async {
    final titleController = TextEditingController(text: announcement?.title);
    final descriptionController = TextEditingController(text: announcement?.description);
    final dateController = TextEditingController(text: announcement?.date);
    File? selectedImage;

    if (announcement != null && announcement.image.isNotEmpty) {
      selectedImage = File(announcement.image);
    }

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(announcement == null ? 'Add Announcement' : 'Edit Announcement'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                ),
                const SizedBox(height: 10),
                selectedImage != null
                    ? Image.file(
                        selectedImage!,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                    : const Text('No image selected'),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile != null) {
                      setState(() {
                        selectedImage = File(pickedFile.path);
                      });
                    }
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Select Image'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedImage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select an image')),
                  );
                  return;
                }

                final newAnnouncement = Announcement(
                  id: announcement?.id,
                  title: titleController.text,
                  image: selectedImage!.path, // Save file path
                  description: descriptionController.text,
                  date: dateController.text,
                );

                if (announcement == null) {
                  await DatabaseHelper().insertAnnouncement(newAnnouncement);
                } else {
                  await DatabaseHelper().updateAnnouncement(newAnnouncement);
                }

                _refreshAnnouncements();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        title: const Text(
          'Announcements',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        toolbarHeight: 100,
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
              return const Center(child: Text('No announcements available.'));
            }

            return ListView.builder(
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                final announcement = announcements[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 255, 241, 224),
                    title: Text(
                      announcement.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 231, 125, 11),
                      ),
                    ),
                    subtitle: Text(
                      announcement.description,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        announcement.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image_not_supported, size: 50);
                        },
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteAnnouncement(announcement.id!),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnnouncementDetail(
                            title: announcement.title,
                            image: announcement.image,
                            description: announcement.description,
                            date: announcement.date,
                          ),
                        ),
                      );
                    },
                    onLongPress: () => _showAnnouncementDialog(announcement),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 231, 125, 11),
        onPressed: () => _showAnnouncementDialog(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
