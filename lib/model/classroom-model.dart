class Classroom {
  final String id;

  Classroom({required this.id});

  factory Classroom.fromJson(String id) {
    print('id di classroom');
    print(id);
    return Classroom(id: id);
  }
}
