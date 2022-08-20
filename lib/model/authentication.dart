import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Authentication {
  static String keyApplicationId = 'com.voyce';
  static String keyParseServerUrl = 'https://test.voycephone.com/parse/';

  static initializeParse() async {
    await Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      autoSendSessionId: true,
    );
  }

  static Future<ParseResponse> signInUser(username, password) {
    ParseUser user = ParseUser(username, password, username);
    return user.login();
  }

  static Future<ParseResponse> registerUser(username, password, email) async {
    print('username = $username  pass = $password');
    var user = ParseUser.createUser(
      username,
      password,
      email,
    );
    return user.signUp();
  }
}
