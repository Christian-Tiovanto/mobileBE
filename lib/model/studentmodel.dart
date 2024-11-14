import 'package:mobile_be/model/classroom-model.dart';

class Student {
  final String id;
  final String name;
  final String user_id;
  final Classroom class_id;
  Student(
      {required this.id,
      required this.name,
      required this.user_id,
      required this.class_id});

  factory Student.fromJson(Map<String, dynamic> value) {
    print('value di student');
    print(value);
    return Student(
        id: value['_id'],
        name: value['name'],
        user_id: value['user_id'],
        class_id: value['class_id'] != null
            ? Classroom.fromJson(value['class_id'])
            : Classroom(id: ''));
  }
}
