import 'dart:convert';

import 'package:client/utils/Ingredient.dart';
import 'package:client/utils/Product.dart';
import 'package:http/http.dart' as http;

class ProductCart {
  String name;
  double price;
  String id;
  late String img;
  int nb = 1;
  int itemId;

  ProductCart(this.name, this.price, this.id, this.itemId);

  Future<String> getProductImg() async {
    String url = 'https://world.openfoodfacts.org/api/v0/product/$id';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    return json['product']['image_url'];
  }
}
