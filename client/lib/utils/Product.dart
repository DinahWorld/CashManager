import 'package:client/utils/Ingredient.dart';

class Product {
  String name;
  String description;
  List<Ingredient> ingredient;
  String img;

  Product(this.name, this.description, this.ingredient, this.img);
}
