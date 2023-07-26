import 'package:client/services/local_storage/userDataService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TokenHolder {
  static final TokenHolder _instance = TokenHolder._internal();

  String token = '';

  factory TokenHolder() {
    return _instance;
  }

  TokenHolder._internal();
}

Future<int> login(String email, String password) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/auth/login'));
  request.body = json.encode({"password": password, "email": email});

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var res = await response.stream.transform(utf8.decoder).join();
    var jsonObject = jsonDecode(res);
    TokenHolder().token = jsonObject['token'];
    await UserDataService().getUserData(TokenHolder().token);
    print('RIGHT REQUEST');
  } else {
    print('BAD REQUEST');
  }
  return response.statusCode;
}
