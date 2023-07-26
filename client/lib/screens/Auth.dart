import 'package:client/screens/SignIn.dart';
import 'package:client/screens/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:client/atomes/background.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In screen',
      home: Scaffold(
        body: Stack(
          children: [
            const BackgroundLightMode(),
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                  margin: const EdgeInsets.only(top: 54, left: 32, right: 32),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Welcome",
                          style: TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                          )))),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                },
                child: GlassmorphicContainer(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.20,
                  borderRadius: 50,
                  blur: 20,
                  alignment: Alignment.bottomCenter,
                  border: 2,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFFFFFFF).withOpacity(0.4),
                        const Color.fromARGB(255, 218, 214, 214)
                            .withOpacity(0.3),
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
                  child: const Center(
                      child: Text('Connexion',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(123, 0, 0, 0)))),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                  );
                },
                child: GlassmorphicContainer(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.20,
                  borderRadius: 50,
                  blur: 20,
                  alignment: Alignment.bottomCenter,
                  border: 2,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFFFFFFF).withOpacity(0.4),
                        const Color.fromARGB(255, 218, 214, 214)
                            .withOpacity(0.3),
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
                  child: const Center(
                    child: Text(
                      'Inscription',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(123, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
              ),
              Image.asset(
                'assets/signin/illustration.png',
                width: MediaQuery.of(context).size.width * 0.7,
                fit: BoxFit.cover,
              ),
            ])
          ],
        ),
      ),
    );
  }
}
