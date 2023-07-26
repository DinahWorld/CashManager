import 'package:client/atomes/background.dart';
import 'package:client/atomes/order.dart';
import 'package:client/services/local_storage/authService.dart';
import 'package:client/services/local_storage/orderService.dart';
import 'package:flutter/material.dart';
import 'package:client/atomes/background.dart';
import 'package:client/atomes/historyProduct.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'History screen',
      home: Scaffold(
        // ignore: prefer_const_literals_to_create_immutables
        body: Stack(children: [
          const BackgroundLightMode(),
          Center(
              child: Column(children: [
            SizedBox(
              height: 25,
            ),
            buildHeader(context),
            buildListOrders(context)
          ]))
        ]),
      ),
    );
  }

  //add throw

  Widget buildListOrders(context) {
    var listProducts = OrderService().getAllOrders();

    return FutureBuilder<List<Order>>(
      future: listProducts,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          List<Order>? orders = snapshot.data;
          if (orders != null) {
            return Column(
              children: const [
                SizedBox(
                  height: 300,
                ),
                Text(
                  'Aucune commande 😣',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            );
          } // List of product objects
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              Order order = orders![index];
              return HistoryProduct(
                id: order.id.toString(),
                productName: "Kinder",
                price: order.price.toString(),
                image: "assets/history/kinder.png",
              );
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget buildHeader(context) {
    return Container(
      margin: const EdgeInsets.only(top: 54, left: 32, right: 32, bottom: 32),
      child: const Align(
          alignment: Alignment.centerLeft,
          child: Text("Historique",
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ))),
    );
  }
}
