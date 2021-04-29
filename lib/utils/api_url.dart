import 'dart:convert';
import 'dart:developer';
import 'package:first_project/models/user.dart';
import 'package:first_project/models/exam.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUrl {
  static const String ngrokUrl = 'https://59c7478e23bc.ngrok.io/api/';

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future registerUser(User user) async {
    Map<String, dynamic> body = {
      'Email': user.email,
      'FullName': user.name,
      'Password': user.password,
    };

    var encodedBody = json.encode(body);
    log(encodedBody);
    return await http.post(ngrokUrl + 'UserTbs',
        headers: header, body: encodedBody);
  }

  static Future loginUser(User user) async {
    return await http.get(ngrokUrl +
        'UserTbs/Login?email=${user.email}&password=${user.password}');
  }

  static Future getExamList() async {
    return await http.get(ngrokUrl + 'ExamTb');
  }

  static Future getUserList() async {
    return await http.get(ngrokUrl + 'UserTbs');
  }

  static Future addExam(Exam exam) async {
    Map<String, dynamic> body = {
      'ExamName': exam.name,
      'Duration': exam.duration,
    };

    var encodedBody = json.encode(body);
    log(encodedBody);
    var res = await http.post(ngrokUrl + 'ExamTb',
        headers: header, body: encodedBody);
    return res;
  }

  static Future deleteExam(int id) async {
    var result = await delete(AppUrl.ngrokUrl + 'ExamTb' + "/" + id.toString());
    return result.statusCode;
  }

  static Future updateExam(int id, Exam exam) async {
    Map<String, dynamic> body = {
      'ExamName': exam.name,
      'Duration': exam.duration,
    };

    var encodedBody = json.encode(body);
    log(encodedBody);
    var res = await http.put(ngrokUrl + 'ExamTb' + "/" + id.toString(),
        headers: header, body: encodedBody);
    return res;
  }

  static Future getScheduledList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int userId = sharedPreferences.getInt('userId');
    return await http.get(ngrokUrl + 'ScheduleExams/GetScheduledExam?userId='+ userId.toString());
  }

  static Future postScheduleExam() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int userId = sharedPreferences.getInt('userId');
    Map<String, dynamic> body = {
      //"ExamId": examId,
      "UserId": userId,
      //"Date":date
    };
    var encodedBody = json.encode(body);

    return await http.post(ngrokUrl + 'ScheduleExams',
        headers: header, body: encodedBody);
  }
}
