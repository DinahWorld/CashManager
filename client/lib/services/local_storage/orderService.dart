import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../atomes/order.dart';
import 'authService.dart';

class OrderService {
  Future<int> createOrder(String token, paymentIntentId, price) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/orders'));

    request.body =
        json.encode({"payment_intent_id": paymentIntentId, "price": price});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }

    return response.statusCode;
  }

  Future<List<Order>> getAllOrders() async {
    var token = TokenHolder().token;
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/orders/list'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var res = await response.stream.transform(utf8.decoder).join();
    if (response.statusCode == 200) {
      final a = jsonDecode(res)["orders"];
      print(a[0]);
      final parsed = a.cast<Map<String, dynamic>>();
      return parsed.map<Order>((json) => Order.fromJson(json)).toList();
      //print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }
}
