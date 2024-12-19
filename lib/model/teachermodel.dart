import 'package:mobile_be/model/classroom-model.dart';
import 'package:mobile_be/pages/grade/lessongrade.dart';

class Teacher {
  final String id;
  final String name;
  final String user_id;
  final List<dynamic> classroom;
  final List<dynamic> subject_teach;
  Teacher(
      {required this.id,
      required this.name,
      required this.user_id,
      required this.classroom,
      required this.subject_teach});

  factory Teacher.fromJson(Map<String, dynamic> value) {
    print('value di teacher');
    print(value);
    return Teacher(
        id: value['_id'],
        name: value['name'],
        user_id: value['user_id'],
        classroom: List<Classroom>.from(value['class_id']
            .map((classroom) => Classroom.fromJson(classroom))),
        subject_teach: value['subject_teach']);
  }
}
