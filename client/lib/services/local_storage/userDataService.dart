// ignore: file_names
import 'package:client/services/local_storage/authService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDataService {
  static final UserDataService _instance = UserDataService._internal();

  String username = 'NOT FOUND';
  factory UserDataService() {
    return _instance;
  }

  UserDataService._internal();

  Future<int> register(String username, String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/users'));

    request.body = json
        .encode({"username": username, "email": email, "password": password});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }

  Future<void> getUserData(String token) async {
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/users/me'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.transform(utf8.decoder).join();
      var jsonObject = jsonDecode(res);
      username = jsonObject['username'];
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<int> updateUser(String username) async {
    var token = TokenHolder().token;
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'PATCH',
        Uri.parse(
            'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/users/me'));
    request.body = json.encode({"username": username});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }

    return response.statusCode;
  }
}
