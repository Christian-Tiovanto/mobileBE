// announcement.dart
class Announcement {
  final int? id;
  final String title;
  final String image;
  final String description;
  final String date;

  Announcement({
    this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.date,
  });

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      description: map['description'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'description': description,
      'date': date,
    };
  }

  @override
  String toString() {
    return 'Announcement{id: $id, title: $title, image: $image, description: $description, date: $date}';
  }
}
