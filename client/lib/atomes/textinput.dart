import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

// ignore: must_be_immutable
class TextInputGlass extends StatelessWidget {
  String inputText;
  double top;
  double bottom;
  double left;
  double right;
  bool obscure;
  TextEditingController controller;

  TextInputGlass(
      {super.key,
      required this.obscure,
      required this.inputText,
      required this.top,
      required this.bottom,
      required this.left,
      required this.right,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
        child: GlassListTile(
          radius: 32,
          blur: 8,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0.5),
            ],
            stops: const [0.0, 1.0],
          ),
          title: TextField(
            obscureText: obscure,
            controller: controller,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            decoration: InputDecoration(
              hintText: inputText,
              border: InputBorder.none,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 175, 170, 170),
              ),
            ),
          ),
          onTap: () {},
        ));
  }
}
