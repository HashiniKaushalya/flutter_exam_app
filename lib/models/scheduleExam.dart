class ScheduleExam {
  int id;
  int examId;
  int userId;
  String date;
  String examName;

  ScheduleExam({this.id, this.examId, this.userId, this.date, this.examName});

  factory ScheduleExam.fromJson(Map<String, dynamic> responseData) {
    return ScheduleExam(
        id: responseData['id'],
        examId: responseData['examId'],
        userId: responseData['userId'],
        date: responseData['date'],
        examName: responseData['examName']);
  }
}
