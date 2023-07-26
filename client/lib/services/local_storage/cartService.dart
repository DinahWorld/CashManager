import 'dart:convert';

import 'package:client/utils/ProductCart.dart';
import 'package:http/http.dart' as http;

class CartService {
  Future<List<ProductCart>> getItem(String token) async {
    List<ProductCart> cart = [];
    //late res = [];
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/carts/my'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final res = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());

      for (int i = 0; i < res['items'].length; i++) {
        cart.add(ProductCart(
            res['items'][i]['product_name'],
            res['items'][i]['product_price'].toDouble() / 100.0,
            res['items'][i]['product_code'],
            res['items'][i]['cart_item_id']));
      }
    } else {
      print(response.reasonPhrase);
    }
    return cart;
  }

  Future<int> addItemById(String token, String productId) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/carts/my'));

    request.body = json.encode({"code": productId});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(await response.stream.bytesToString());
    }

    return response.statusCode;
  }

  Future<int> deleteItemById(String token, int userId) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'DELETE',
        Uri.parse(
            'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/carts/my'));

    request.body = json.encode({"cart_item_id": userId});
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
