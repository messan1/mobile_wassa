import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAssistance {
  static Future<dynamic> request(url) async {
    http.Response response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decode = jsonDecode(jsonData);
        return decode;
      } else {
        return "failed";
      }
    } catch (e) {
      return "Reached";
    }
  }

  static Future<dynamic> postRequest(url, header, postdata) async {
    http.Response response =
        await http.post(Uri.parse(url), headers: header, body: postdata);
    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decode = jsonDecode(jsonData);
        print(decode);
        return decode;
      } else {
        return "failed";
      }
    } catch (e) {
      return "Reached";
    }
  }
}
