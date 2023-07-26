import 'package:client/utils/Ingredient.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

Widget IngredientPercentage(BuildContext context, Ingredient ingredient) {
  return (GlassmorphicContainer(
    width: MediaQuery.of(context).size.width * 0.19,
    height: MediaQuery.of(context).size.width * 0.19,
    borderRadius: 100,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.18,
            child: Center(
              child: Text(
                ingredient.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 143, 141, 141),
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
        Text(
          '${ingredient.percentage.round()} %',
          style: const TextStyle(
              color: Color.fromARGB(255, 143, 141, 141),
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
      ],
    ),
  ));
}
