import 'package:client/atomes/background.dart';
import 'package:client/atomes/product.dart';
import 'package:client/screens/Navigation.dart';
import 'package:client/services/local_storage/authService.dart';
import 'package:client/services/local_storage/cartService.dart';
import 'package:client/services/local_storage/productService.dart';
import 'package:client/utils/Ingredient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:client/atomes/ingredientPercentage.dart';

import '../utils/Product.dart';

class ProductScreen extends StatefulWidget {
  String id;
  bool isInCart;
  int? item;
  ProductScreen({
    Key? key,
    required this.id,
    required this.isInCart,
    this.item,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  ProductServices product = ProductServices('', '',
      'https://media.tenor.com/On7kvXhzml4AAAAj/loading-gif.gif', [], '');
  int resCode = 0;

  @override
  initState() {
    super.initState();
    print("initState Called");
    getProductData(widget.id).then((value) => setState((() {
          product = value;
        })));
    ProductService()
        .getOne(TokenHolder().token, widget.id)
        .then((value) => setState((() {
              resCode = value;
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundLightMode(),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: productImage(),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    productDescription(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    ingredientList(),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Center(child: addToCart()!),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productImage() {
    return GlassmorphicContainer(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.width * 0.60,
      borderRadius: 20,
      blur: 20,
      alignment: Alignment.bottomCenter,
      border: 2,
      linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF).withOpacity(0.4),
            const Color.fromARGB(255, 218, 214, 214).withOpacity(0.3),
          ],
          stops: const [
            0.1,
            1,
          ]),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color((0xFFFFFFFF)).withOpacity(0.5),
          const Color.fromARGB(255, 243, 240, 240).withOpacity(0.5),
        ],
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Opacity(
            opacity: 0.8,
            child: Image.network(
              product.img,
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.width * 0.55,
            ),
          ),
        ),
      ),
    );
  }

  Widget productDescription() {
    return GlassmorphicContainer(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.width * 0.50,
      borderRadius: 20,
      blur: 20,
      alignment: Alignment.bottomCenter,
      border: 2,
      linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF).withOpacity(0.4),
            const Color.fromARGB(255, 218, 214, 214).withOpacity(0.3),
          ],
          stops: const [
            0.1,
            1,
          ]),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color((0xFFFFFFFF)).withOpacity(0.5),
          const Color.fromARGB(255, 243, 240, 240).withOpacity(0.5),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          Text(
            product.name,
            style: const TextStyle(
                color: Color.fromARGB(255, 143, 141, 141),
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.05,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Text(
              product.description,
              style: const TextStyle(
                color: Color.fromARGB(255, 143, 141, 141),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ingredientList() {
    return Column(
      children: [
        for (var i = 0; (i < product.ingredients.length && i < 3); i++) ...[
          Row(
            children: [
              IngredientPercentage(context, product.ingredients[i]),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.02,
          ),
        ],
      ],
    );
  }

  Widget addToCart() {
    if (resCode == 200) {
      if (!widget.isInCart) {
        return AnimatedButton(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.width * 0.15,
          text: 'Ajouter au panier     🛒',
          selectedText: 'Retirer du panier     🗑',
          isReverse: true,
          selectedTextColor: Color.fromARGB(255, 255, 255, 255),
          selectedBackgroundColor: Color.fromARGB(255, 33, 2, 43),
          transitionType: TransitionType.LEFT_TO_RIGHT,
          backgroundColor: Color.fromARGB(255, 200, 166, 240),
          borderColor: Color.fromARGB(34, 199, 177, 226),
          borderRadius: 50,
          borderWidth: 2,
          onPress: () {
            print(widget.id);
            CartService().addItemById(TokenHolder().token, widget.id);
          },
        );
      } else {
        return AnimatedButton(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.width * 0.15,
            selectedText: 'Ajouter au panier     🛒',
            text: 'Retirer du panier     🗑',
            isReverse: true,
            selectedTextColor: Color.fromARGB(255, 255, 255, 255),
            backgroundColor: Color.fromARGB(255, 33, 2, 43),
            transitionType: TransitionType.LEFT_TO_RIGHT,
            selectedBackgroundColor: Color.fromARGB(255, 200, 166, 240),
            borderColor: Color.fromARGB(34, 199, 177, 226),
            borderRadius: 50,
            borderWidth: 2,
            onPress: () {
              CartService().deleteItemById(TokenHolder().token, widget.item!);
              Future.delayed(
                const Duration(milliseconds: 500),
                () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Navigation(index: 3),
                  ));
                },
              );
            });
      }
    }
    return AnimatedButton(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.width * 0.15,
      selectedText: 'Article indisponible 😣',
      text: 'Article indisponible 😣',
      isReverse: true,
      selectedTextColor: Color.fromARGB(255, 255, 255, 255),
      backgroundColor: Color.fromARGB(255, 159, 159, 159),
      transitionType: TransitionType.LEFT_TO_RIGHT,
      selectedBackgroundColor: Color.fromARGB(255, 159, 159, 159),
      borderColor: Color.fromARGB(255, 159, 159, 159),
      borderRadius: 50,
      borderWidth: 2,
      onPress: () {},
    );
  }
}
