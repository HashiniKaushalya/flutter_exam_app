class Exam {
  int examId;
  String name;
  String duration;
  DateTime dateAssigned;
  int userId;

  Exam({
    this.examId,
    this.name,
    this.duration,
    this.dateAssigned,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = examId;
    map['examName'] = name;
    map['duration'] = duration;
    map['dateAssigned'] = dateAssigned;
    map['userId'] = userId;

    return map;
  }

  factory Exam.fromJson(Map<String, dynamic> responseData) {
    return Exam(
        examId: responseData['id'],
        name: responseData['examName'],
        duration: responseData['duration'],
        userId: responseData['userId']);
  }

  Exam.fromjson(dynamic o) {
    this.examId = o['id'];
    this.name = o['name'];
    this.duration = o['duration'];
    this.userId = o['userId'];
  }
}
