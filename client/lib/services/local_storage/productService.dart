import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:client/services/local_storage/authService.dart';

class ProductService {
  Future<int> createProduct(
      String code, String name, int price, bool isBuyable) async {
    var token = TokenHolder().token;

    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/products'));

    request.body = json.encode(
        {"code": code, "name": name, "price": price, "is_buyable": isBuyable});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }

  Future<int> getOne(String token, code) async {
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/products/$code'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }

  Future<int> updateProduct(String price, String name, int userId) async {
    var token = TokenHolder().token;

    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.Request(
        'PATCH',
        Uri.parse(
            'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/products/$userId'));

    request.body = json.encode({"price": price, "name": name});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }

  Future<int> deleteProduct(int userId) async {
    var token = TokenHolder().token;

    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.Request(
        'DELETE',
        Uri.parse(
            'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/products/$userId'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }
}
