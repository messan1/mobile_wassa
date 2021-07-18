
import 'package:ucolis/src/app/Endpoint.dart';
import 'package:ucolis/src/utils/Assistance/RequestAssistance.dart';

class AuthAssistance {
  static Future<dynamic> getAuthState() async {
    var response =
        await RequestAssistance.request(ApiEndpoint + "/api/test/all");
    return response;
  }

}
