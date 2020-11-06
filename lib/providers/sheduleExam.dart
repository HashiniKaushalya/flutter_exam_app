import 'dart:convert';
import 'package:first_project/utils/api_url.dart';
import 'package:http/http.dart';

class ExamsSheduleProvider {
  Future<List<dynamic>> getExam() async {
    var result = await get(AppUrl.examListSheduled);
    return json.decode(result.body);
  }

  Future<int> sheduleExam(data) async {
    print(json.encode(data));
    var result = await post(AppUrl.examListSheduled,
        body: json.encode(data), headers: {'Content-Type': 'application/json'});
    print(result.body);
    return result.statusCode;
  }
}
