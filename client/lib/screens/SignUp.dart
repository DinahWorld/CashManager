// ignore_for_file: file_names

import 'package:client/screens/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:client/atomes/background.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:client/atomes/textinput.dart';
import 'package:client/services/local_storage/userDataService.dart' as users;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignUpScreen> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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
                    child: Text(
                      "Welcome\nBack",
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextInputGlass(
                    obscure: false,
                    inputText: "Username",
                    top: 0,
                    bottom: 8,
                    left: 32,
                    right: 32,
                    controller: usernameController),
                TextInputGlass(
                    obscure: false,
                    inputText: "E-mail",
                    top: 0,
                    bottom: 8,
                    left: 32,
                    right: 32,
                    controller: emailController),
                TextInputGlass(
                    obscure: true,
                    inputText: "Mot de passe",
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
                      const Text("Sign in",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
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
                            var res = await users.UserDataService().register(
                                usernameController.text,
                                emailController.text,
                                passwordController.text);
                            if (res == 201) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SignInScreen(),
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
