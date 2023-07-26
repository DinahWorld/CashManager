import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

Widget carrousselContainer(BuildContext context) {
  return GlassmorphicContainer(
    width: MediaQuery.of(context).size.width * 0.40,
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
    child: const Text(
      '',
      style: TextStyle(
        color: Color.fromARGB(255, 143, 141, 141),
      ),
    ),
  );
}
