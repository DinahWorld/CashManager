import 'package:client/utils/Product.dart';
import 'package:client/utils/ProductCart.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

class Product extends StatefulWidget {
  ProductCart product;
  Product({super.key, required this.product});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  int _counter = 1;

  String img = 'https://media.tenor.com/On7kvXhzml4AAAAj/loading-gif.gif';

  void initState() {
    super.initState();
    widget.product.getProductImg().then((value) => setState((() {
          img = value;
        })));
  }

  @override
  Widget build(BuildContext context) {
    double price = widget.product.price * _counter;

    return Center(
      child: GlassContainer(
        height: 100,
        width: MediaQuery.of(context).size.width * 0.80,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GlassContainer(
              borderRadius: BorderRadius.circular(50),
              border: 1,
              height: 50,
              width: 50,
              child: Image.network(img),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassContainer(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: GlassText(
                        widget.product.name,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           if (_counter > 0) {
                  //             _counter--;
                  //           }
                  //         });
                  //       },
                  //       child: const GlassContainer(
                  //         margin: EdgeInsets.only(right: 8, left: 8),
                  //         child: Padding(
                  //           padding: EdgeInsets.all(8),
                  //           child: GlassText(
                  //             "-",
                  //             color: Colors.black,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     GlassContainer(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8),
                  //         child: GlassText(
                  //           _counter.toString(),
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           _counter++;
                  //           widget.product.nb += 1;
                  //         });
                  //       },
                  //       child: const GlassContainer(
                  //         margin: EdgeInsets.only(left: 8),
                  //         child: Padding(
                  //           padding: EdgeInsets.all(8),
                  //           child: GlassText(
                  //             "+",
                  //             color: Colors.black,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlassContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: GlassText(
                        price.toStringAsFixed(2),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
