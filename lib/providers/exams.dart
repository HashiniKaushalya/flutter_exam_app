import 'dart:convert';

import 'package:first_project/utils/api_url.dart';
import 'package:http/http.dart';

class ExamProvider {
  Future<List<dynamic>> getExam() async {
    var result = await get(AppUrl.examList);
    return json.decode(result.body);
  }

  Future<int> deleteExam(int id) async {
    var result = await delete(AppUrl.examList + "/" + id.toString());
    return result.statusCode;
  }

  Future<int> updateExam(int id, data) async {
    print(id.toString() + data.toString());
    var result = await put(AppUrl.examList + "/" + id.toString(),
        body: data, headers: {'Content-Type': 'application/json'});
    print(result.body);
    return result.statusCode;
  }

  Future<int> addExam(data) async {
    var result = await post(AppUrl.examList,
        body: data, headers: {'Content-Type': 'application/json'});
    print(result.body);
    return result.statusCode;
  }
}
