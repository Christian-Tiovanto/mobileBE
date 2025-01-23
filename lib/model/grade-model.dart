class Grade {
  final String id;
  final String student_name;
  final String student_id;
  final String subject;
  final int assignment_score;
  final int mid_term_score;
  final int semester_score;
  Grade(
      {required this.id,
      required this.assignment_score,
      required this.mid_term_score,
      required this.semester_score,
      required this.student_id,
      required this.student_name,
      required this.subject});

  factory Grade.fromJson(Map<String, dynamic> value) {
    return Grade(
        id: value['_id'],
        assignment_score: value['assignment_score'],
        mid_term_score: value['mid_term_score'],
        semester_score: value['semester_score'],
        student_id: value['user_id']['user_id'],
        student_name: value['user_id']['name'],
        subject: value['subject']);
  }
}
