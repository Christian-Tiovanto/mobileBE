class Attendance {
  final String user_id;
  final String status;
  final DateTime? date;
  final String class_id;
  final String reason;
  final String tahun_ajaran;

  Attendance(
      {required this.user_id,
      required this.status,
      this.date,
      required this.class_id,
      required this.reason,
      required this.tahun_ajaran});

  factory Attendance.fromJson(Map<String, dynamic> value) {
    print('ini di Attendance');
    return Attendance(
        user_id: value['user_id'],
        status: value['status'],
        date: value['date'],
        class_id: value['class_id'],
        reason: value['reason'],
        tahun_ajaran: value['tahun_ajaran']);
  }

  Map<String, dynamic> toJson(Map<String, dynamic> value) {
    return {
      "user_id": value['user_id'],
      "status": value['status'],
      "date": value['date'],
      "class_id": value['class_id'],
      "reason": value['reason'],
      "tahun_ajaran": value['tahun_ajaran']
    };
  }
}
