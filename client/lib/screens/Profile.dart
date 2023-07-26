import 'package:flutter/material.dart';
import 'package:client/atomes/background.dart';
import 'package:client/atomes/textinput.dart';

import '../services/local_storage/userDataService.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String username = UserDataService().username;
    var usernameController = TextEditingController();

    return MaterialApp(
        title: 'Profile screen',
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(children: [
              const BackgroundLightMode(),
              Expanded(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                    Container(
                        margin: const EdgeInsets.only(top: 16),
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ClipOval(
                            child: Image.asset(
                          'assets/profile/Avatar.png',
                          fit: BoxFit.cover,
                        ))),
                    Text(
                      username,
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Column(children: [
                      Stack(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 54, left: 32, right: 32),
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 8, bottom: 16),
                                child: const Text(
                                  'Modifier mes\ninformations',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      TextInputGlass(
                          obscure: false,
                          inputText: "Nom d'utilisateur",
                          top: 0,
                          bottom: 0,
                          left: 32,
                          right: 32,
                          controller: usernameController),
                    ]),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      // ignore: sort_child_properties_last
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 156, 80, 255),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        child: const Text(
                          'Valider ✔️',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                        onPressed: () async {
                          if (usernameController.text == "") {
                            usernameController.text = username;
                          }
                          var res = await UserDataService()
                              .updateUser(usernameController.text);
                          if (res == 200) {
                            UserDataService().username =
                                usernameController.text;
                            // ignore: use_build_context_synchronously
                            showMyDialog(context, "Succès",
                                "Modification effectuée avec succès.");
                          } else {
                            // ignore: use_build_context_synchronously
                            showMyDialog(context, "Oups",
                                "Un des champs remplis est incorrect.");
                          }
                        },
                      ),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 228, 225, 225),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(0, 2))
                          ]),
                    ),
                  ])))
            ])));
  }

  Future<dynamic> showMyDialog(context, title, content) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text(
              "okay",
              style: TextStyle(
                  color: Color.fromARGB(255, 172, 102, 184), fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
