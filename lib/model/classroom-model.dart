class Classroom {
  final String id;

  Classroom({required this.id});

  factory Classroom.fromJson(String id) {
    return Classroom(id: id);
  }
}
