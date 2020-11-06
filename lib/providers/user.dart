import 'dart:convert';

import 'package:first_project/utils/api_url.dart';
import 'package:http/http.dart';

class UserListProvider {
  Future<List<dynamic>> getUserList() async {
    var result = await get(AppUrl.userList);
    return json.decode(result.body);
  }
}

