// ignore: file_names
import 'package:client/screens/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:client/atomes/background.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:client/atomes/textinput.dart';
import 'package:client/services/local_storage/authService.dart' as auth;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In screen',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const BackgroundLightMode(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 54, left: 32, right: 32),
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Welcome\nBack",
                            style: TextStyle(
                              fontSize: 72,
                              fontWeight: FontWeight.bold,
                            )))),
                TextInputGlass(
                    obscure: false,
                    inputText: "Entrez votre email",
                    top: 0,
                    bottom: 8,
                    left: 32,
                    right: 32,
                    controller: emailController),
                TextInputGlass(
                    obscure: true,
                    inputText: "Entrez votre mot de passe",
                    top: 0,
                    bottom: 24,
                    left: 32,
                    right: 32,
                    controller: passwordController),
                Image.asset(
                  'assets/signin/illustration.png',
                  width: MediaQuery.of(context).size.width * 0.7,
                  fit: BoxFit.cover,
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 32, right: 32, bottom: 20),
                  child: Row(
                    children: [
                      const Text("Connexion",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                          )),
                      const Spacer(),
                      GlassContainer(
                        border: 0,
                        linearGradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 243, 248, 255),
                            Color.fromARGB(255, 232, 211, 255)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(50),
                        height: 60,
                        width: 60,
                        blur: 10,
                        child: IconButton(
                          iconSize: 32,
                          color: const Color.fromARGB(255, 155, 147, 168),
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () async {
                            var res = await auth.login(
                                emailController.text, passwordController.text);
                            if (res == 200) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Navigation(),
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  title: const Text("Oups"),
                                  content: const Text(
                                      "Un des champs remplis est incorrect."),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text(
                                        "okay",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 172, 102, 184),
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
