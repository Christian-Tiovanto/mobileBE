import 'package:mobile_be/model/classroom-model.dart';

class Student {
  final String id;
  final String name;
  final String user_id;
  final Classroom class_id;
  final String? phone_number;
  Student(
      {required this.id,
      required this.name,
      required this.user_id,
      required this.class_id,
      this.phone_number});

  factory Student.fromJson(Map<String, dynamic> value) {
    print('value di student');
    print(value);
    return Student(
        id: value['_id'],
        name: value['name'],
        user_id: value['user_id'],
        phone_number:
            value['phone_number'] != null ? value['phone_number'] : '',
        class_id: value['class_id'] != null
            ? Classroom.fromJson(value['class_id'])
            : Classroom(id: ''));
  }
}
