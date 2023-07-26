import 'package:client/screens/Navigation.dart';
import 'package:flutter/material.dart';

class SuccessPaymentScreen extends StatefulWidget {
  const SuccessPaymentScreen({Key? key}) : super(key: key);

  @override
  State<SuccessPaymentScreen> createState() => _SuccessPaymentScreenState();
}

class _SuccessPaymentScreenState extends State<SuccessPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Spacer(),
              const Text(
                "Payment successful",
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              const Text(
                "Thank you for your purchase",
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => Navigation(
                              index: 1,
                            )),
                  );
                },
                child: const Text("Back to home"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
