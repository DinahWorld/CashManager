import 'package:client/screens/Auth.dart';
import 'package:client/screens/Navigation.dart';
import 'package:client/screens/Product.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/Home.dart';
import 'package:client/screens/Cart.dart';
import 'package:client/screens/History.dart';
import 'package:client/screens/Profile.dart';
import 'package:client/screens/SignUp.dart';
import 'package:client/screens/Scan.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    //return Navigation();
    return const AuthScreen();
  }
}
