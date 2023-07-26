import 'dart:async';
import 'dart:ffi';
import 'package:client/molecules/Product.dart';
import 'package:client/screens/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:client/atomes/background.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({super.key});
  @override
  State<BarcodeScanner> createState() => BarcodeScannerState();
}

class BarcodeScannerState extends State<BarcodeScanner> {
  String _scanBarcode = '';
  void initState() {
    super.initState();
    barcodeScan();
  }

  Future<void> barcodeScan() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = '';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_scanBarcode.isEmpty) {
      return Container(
          alignment: Alignment.center,
          child: Stack(children: <Widget>[
            const BackgroundLightMode(),
            Align(
              alignment: AlignmentDirectional.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.cyan,
                          ),
                          onPressed: () => barcodeScan(),
                          child: const Text('Barcode Scan',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold))),
                    ),
                  ]),
            )
          ]));
    } else {
      return (ProductScreen(
        id: _scanBarcode,
        isInCart: false,
      ));
    }
  }
}
