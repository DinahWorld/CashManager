// ignore: file_names
import 'package:client/screens/AddNewCard.dart';
import 'package:client/screens/ScanSolde.dart';
import 'package:client/services/local_storage/paymentService.dart';
import 'package:client/screens/Product.dart';
import 'package:client/services/local_storage/authService.dart';
import 'package:client/services/local_storage/cartService.dart';
import 'package:client/services/local_storage/userDataService.dart';
import 'package:client/utils/ProductCart.dart';
import 'package:flutter/material.dart';
import 'package:client/molecules/Product.dart';
import 'package:client/atomes/background.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  PaymentService paymentService = PaymentService();
  List<ProductCart> cart = [];
  int total = 0;

  @override
  void initState() {
    super.initState();
    CartService().getItem(TokenHolder().token).then((value) => setState((() {
          cart = value;
        })));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Stack(children: [
        const BackgroundLightMode(),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 70, left: 32, right: 32),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Mon\nPanier",
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          )))),
              for (var i = 0; i < cart.length; i++) ...[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.032,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ProductScreen(
                              id: cart[i].id,
                              isInCart: true,
                              item: cart[i].itemId)),
                    );
                  },
                  child: Product(
                    product: cart[i],
                  ),
                ),
              ],
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.032,
              ),
              GlassContainer(
                width: MediaQuery.of(context).size.width * 0.80,
                height: 100,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const GlassText(
                            "Total : ",
                            color: Color.fromARGB(255, 72, 71, 72),
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: GlassText(
                            '${(computeTotal(cart) / 100).toString()} €',
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            title: const Text("Paiement"),
                            content: const Text(
                                "Vous devez choisir une méthode de paiement."),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {
                                  String paymentIntentId =
                                      await paymentService.createPaymentIntent(
                                          TokenHolder().token, total * 100);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => AddNewCardScreen(
                                              paymentIntentId: paymentIntentId,
                                              price: total,
                                            )),
                                  );
                                },
                                child: const Text(
                                  "Credit card",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 172, 102, 184),
                                      fontSize: 15),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const QRCodeScanner()),
                                  );
                                },
                                child: const Text(
                                  "Solde",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 172, 102, 184),
                                      fontSize: 15),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 172, 102, 184),
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const GlassContainer(
                        width: 80,
                        height: 30,
                        margin: EdgeInsets.only(top: 20),
                        child: Center(
                            child: GlassText("Valider", color: Colors.black)),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  int computeTotal(List<ProductCart> cart) {
    for (var i = 0; i < cart.length; i++) {
      total += cart[i].price.toInt();
    }
    return (total * 100);
  }
}
