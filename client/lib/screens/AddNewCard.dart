import 'dart:developer';

import 'package:client/screens/SuccessPayment.dart';
import 'package:client/services/local_storage/authService.dart';
import 'package:client/services/local_storage/orderService.dart';
import 'package:client/services/local_storage/paymentService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNewCardScreen extends StatefulWidget {
  String paymentIntentId;
  int price;
  AddNewCardScreen(
      {Key? key, required this.paymentIntentId, required this.price})
      : super(key: key);

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  TextEditingController cardNumberController =
      TextEditingController(text: '4242424242424242');
  TextEditingController cvvController = TextEditingController(text: '333');
  TextEditingController expiryDateController =
      TextEditingController(text: '12/30');
  int paymentMethodId = 0;

  PaymentService paymentService = PaymentService();
  OrderService orderService = OrderService();

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
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: cardNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(19),
                      ],
                      decoration: InputDecoration(hintText: "Card number"),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: cvvController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              // Limit the input
                              LengthLimitingTextInputFormatter(4),
                            ],
                            decoration: const InputDecoration(hintText: "CVV"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: expiryDateController,
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                            ],
                            decoration:
                                const InputDecoration(hintText: "MM/YY"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  child: const Text("Add card"),
                  onPressed: () async {
                    // Create payment method
                    await paymentService.createPaymentMethod(
                      TokenHolder().token,
                      cardNumberController.text,
                      int.parse(expiryDateController.text.split("/")[0]),
                      int.parse("20${expiryDateController.text.split("/")[1]}"),
                      cvvController.text,
                    );

                    // TODO - confirm payment with payment intent id
                    await paymentService.confirmPayment(
                        TokenHolder().token, widget.paymentIntentId);

                    // TODO - Create Order with payment intent id
                    await orderService.createOrder(TokenHolder().token,
                        widget.paymentIntentId, widget.price);

                    // TODO - Redirect to success screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const SuccessPaymentScreen()),
                    );
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
