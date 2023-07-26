import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentService {
  Future<int> createPaymentMethod(
      String token, cardNumber, expMonth, expYear, cvc) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/payment/method'));

    request.body = json.encode({
      "card_number": cardNumber,
      "exp_month": expMonth,
      "exp_year": expYear,
      "cvc": cvc
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }

  Future<String> createPaymentIntent(String token, int amount) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/payment/intent'));

    request.body = json.encode({"amount": amount});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final res = jsonDecode(await response.stream.bytesToString());
      return res['payment_intent_id'];
    } else {
      print(response.reasonPhrase);
    }
    return '';
  }

  Future<int> confirmPayment(String token, String paymentIntentId) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://1c35-2a01-e0a-9a4-7b30-1c17-bdb9-18d9-6a23.eu.ngrok.io/api/payment/confirm'));

    request.body = json.encode({"payment_intent_id": paymentIntentId});
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
