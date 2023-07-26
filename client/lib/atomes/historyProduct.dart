// ignore: file_names
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

// ignore: must_be_immutable
class HistoryProduct extends StatelessWidget {
  String id;
  String productName;
  String price;
  String image;

  HistoryProduct(
      {super.key,
      required this.id,
      required this.productName,
      required this.price,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      margin: const EdgeInsets.only(bottom: 12, left: 40, right: 40),
      width: MediaQuery.of(context).size.width * 1,
      height: 100,
      borderRadius: 40,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFFFFFFF).withOpacity(0.4),
          const Color.fromARGB(255, 218, 214, 214).withOpacity(0.3),
        ],
      ),
      border: 5,
      blur: 10,
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
          ClipRRect(
            borderRadius: BorderRadius.circular(20), // Image border
            child: SizedBox.fromSize(
              size: Size.fromRadius(48), // Image radius
              child: Image.asset('assets/home/ScanIllu.png', fit: BoxFit.cover),
              //child: Image.network('assets/home/ScanIllu.png', fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  'Commande :  n° $id',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.normal),
                ),
                Text(
                  '$price€',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
