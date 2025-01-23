class Assignment {
  final String? assignment_id;
  final String title;
  final DateTime dueDate;
  final String description;
  final String attachedFiles;
  final String? class_id;
  final List<Submission> submissions;

  Assignment({
    this.assignment_id,
    required this.title,
    required this.dueDate,
    required this.description,
    required this.attachedFiles,
    this.class_id,
    this.submissions = const [],
  });

  factory Assignment.fromJson(Map<String, dynamic> value) {
    return Assignment(
        assignment_id: value['_id'],
        title: value['title'],
        description: value['description'],
        dueDate: DateTime.parse(value['due_date']),
        class_id: value['class_id'],
        attachedFiles: value['file_url'] != null ? value['file_url'] : '');
  }
}

class Submission {
  final String? submission_id;
  final String submitterName;
  final String submissionTime;
  final String? filePath;
  int score;
  final String? comment;

  Submission({
    this.submission_id,
    required this.submitterName,
    required this.submissionTime,
    required this.filePath,
    this.score = 0,
    this.comment, // Nullable comment
  });
  factory Submission.fromJson(Map<String, dynamic> value) {
    return Submission(
      submission_id: value['_id'],
      submissionTime: '',
      submitterName: value['student_id']['name'],
      filePath: value['file_url'],
      score: value['score'],
      comment: '',
    );
  }
}
