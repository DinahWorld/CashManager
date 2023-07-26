import 'dart:developer';

import 'package:client/utils/Ingredient.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductServices {
  String name;
  String description;
  String img;
  String id;
  List<Ingredient> ingredients;

  ProductServices(
      this.name, this.description, this.img, this.ingredients, this.id);
}

Future<ProductServices> getProductData(String barCode) async {
  //barCode = '737628064502';
  List<Ingredient> ingredients = [];
  log(barCode);

  String url = 'https://world.openfoodfacts.org/api/v0/product/$barCode';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  log(response.body);
  final body = response.body;
  final json = jsonDecode(body);

  // product = json['product']['product_name'];
  // description = json['product']['categories'];
  // linkImg = json['product']['image_url'];

  for (int i = 0; i < json['product']['ingredients'].length; i++) {
    log(json['product']['ingredients'][i]['percent_estimate'].toString());
    ingredients.add(
      Ingredient(
        json['product']['ingredients'][i]['text'],
        json['product']['ingredients'][i]['percent_estimate'].toDouble(),
      ),
      //inal product = ProductServices();
    );
  }
  return ProductServices(
      json['product']['product_name'],
      json['product']['categories'],
      json['product']['image_url'],
      ingredients,
      barCode);
}
