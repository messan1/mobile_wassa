import 'dart:convert';

import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:ucolis/src/DataHandler/userAuth.dart';
import 'package:ucolis/src/Model/AuthState.dart';
import 'package:ucolis/src/app/Endpoint.dart';
import 'package:ucolis/src/utils/Assistance/RequestAssistance.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ucolis/src/views/screens/login/login.dart';
import 'package:ucolis/src/views/screens/mapFromDeliver/mapFromDeliver.dart';

class AuthAssistanceMethods {
  static void verifyAuth() async {
    final storage = new FlutterSecureStorage();
    Map<String, String> allValues = await storage.readAll();

    if (allValues["id"] != null && allValues["id"].isNotEmpty) {
      if (allValues["role"] == "ROLE_CLIENT") {
     //   Get.offAll(DashBoard());
      } else {
        Get.offAll(MapFromDeliver());
      }
    } else {
      Get.offAll(Login());
    }
  }

  static Future<AuthState> getAuthState(body, context) async {
    String uri = ApiEndpoint + "/api/auth/signin";
    final storage = new FlutterSecureStorage();

    var response = await RequestAssistance.postRequest(
        uri, {"Content-Type": "application/json"}, body);

    if (response == "failed") {
      return null;
    }

    await storage.write(key: "id", value: response["id"]);
    await storage.write(key: "username", value: response["username"]);
    await storage.write(key: "email", value: response["email"]);
    await storage.write(key: "role", value: response["roles"][0]);
    await storage.write(key: "accessToken", value: response["accessToken"]);
    await storage.write(key: "tokenType", value: response["tokenType"]);

    AuthState authState = new AuthState();
    authState.id = response["id"];
    authState.username = response["username"];
    authState.email = response["email"];
    authState.role = response["roles"][0];
    authState.acsessToken = response["accessToken"];
    authState.isActive = response["isActive"];
    authState.isDeleted = response["isDeleted"];
    authState.tokenType = response["tokenType"];

    Provider.of<UserAuth>(context, listen: false).updateAuthState(authState);

    return authState;
  }

  static Future<dynamic> signupUser(context) async {
    String uri = ApiEndpoint + "/api/auth/signup";
    Map data = {
      'nom': Provider.of<UserAuth>(context, listen: false).firstname,
      'prenom': Provider.of<UserAuth>(context, listen: false).lastname,
      'username': Provider.of<UserAuth>(context, listen: false).email,
      'roles': [Provider.of<UserAuth>(context, listen: false).role],
      'phone': Provider.of<UserAuth>(context, listen: false).phoneNumber,
      'password': Provider.of<UserAuth>(context, listen: false).password,
      'trigramme': Provider.of<UserAuth>(context, listen: false).firstname,
      'email': Provider.of<UserAuth>(context, listen: false).email
    };
    String body = json.encode(data);

    var response = await RequestAssistance.postRequest(
        uri, {"Content-Type": "application/json"}, body);

    if (response == "failed") {
      return null;
    }

    return response;
  }

  static Future<dynamic> verifytel(context) async {
    String tel = Provider.of<UserAuth>(context, listen: false).phoneNumber;
    print(tel);
    var response = await RequestAssistance.request(
        ApiEndpoint + "/api/test/verifytel?tel=${tel}");
    return response;
  }

  static Future<dynamic> verifyemail(context) async {
    String email = Provider.of<UserAuth>(context, listen: false).email;

    var response = await RequestAssistance.request(
        ApiEndpoint + "/api/test/verifyemail?email=${email}");
    return response;
  }

  static Future<dynamic> uploadImage(filename, name) async {
    print("posted");
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiEndpoint + "/api/files/savefile?name=${name}"));
    request.files.add(await http.MultipartFile.fromPath('file', filename));
    var res = await request
        .send()
        .whenComplete(() => "done")
        .onError((error, stackTrace) => error);
  }
}
