import 'dart:developer';

import 'package:client/screens/Navigation.dart';
import 'package:client/screens/Scan.dart';
import 'package:client/services/local_storage/userDataService.dart';
import 'package:flutter/material.dart';
import 'package:client/atomes/background.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../molecules/carrousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home screen',
      home: Scaffold(
        body: Stack(
          children: [
            const BackgroundLightMode(),
            SingleChildScrollView(
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.07,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.17,
                      ),
                      buildHeader(context),
                      const SizedBox(
                        height: 20,
                      ),
                      buildBody(context)
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.07,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.86,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 143, 141, 141),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    UserDataService().username,
                    style: const TextStyle(
                        fontSize: 27,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Container(
                      child: ClipOval(
                          child: Image.asset(
                    'assets/profile/Avatar.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )))),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Navigation(
                  index: 2,
                ),
              ),
            );
          },
          child: GlassmorphicContainer(
            width: MediaQuery.of(context).size.width * 0.86,
            height: MediaQuery.of(context).size.height * 0.20,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/home/ScanIllu.png',
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: const Text(
                    textAlign: TextAlign.center,
                    'Scan tes articles pour les ajouter à ton panier !',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0, 2.0),
                          blurRadius: 20.0,
                          color: Color.fromARGB(90, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.86,
          child: const Text(
            'Les nouveautés',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.86,
            child: const Carrousel()),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.86,
          child: const Text(
            'Les Best-seller',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.86,
            child: const Carrousel()),
      ],
    );
  }
}
