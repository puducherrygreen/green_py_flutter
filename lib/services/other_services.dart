import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constant/green_api.dart';

class OtherServices {
  static Future sendQuery(
      {required String query, required String userId}) async {
    final client = http.Client();
    final res = await client
        .post(GreenApi.kSendQuery, body: {"query": query, "userId": userId});
    print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }
}
