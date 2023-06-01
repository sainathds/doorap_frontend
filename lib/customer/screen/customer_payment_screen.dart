import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/customer/controller/customer_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class CustomerPaymentScreen extends StatefulWidget {
  const CustomerPaymentScreen({Key? key}) : super(key: key);

  @override
  _CustomerPaymentScreenState createState() => _CustomerPaymentScreenState();
}

class _CustomerPaymentScreenState extends State<CustomerPaymentScreen> {

  CustomerPaymentController _getXController = Get.put(CustomerPaymentController());




  @override
  void initState() {
    // TODO: implement initState

    _getXController.makePayment = makePayment;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            TextButton(
                onPressed: () {
                  _getXController.hitCreatePaymentIntentApi();
                },
                child: Text('Pay'))

          ],
        ),
      ),
    );
  }


  ///*
  ///
  ///
  Future<void> makePayment() async {
    try {

      BillingDetails billingDetails = BillingDetails(
          email: 'testing@coppanet.com'
      );



      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            billingDetails: billingDetails,
            paymentIntentClientSecret: _getXController.clientSecretKey,
            customerId: _getXController.customerId,
            customerEphemeralKeySecret: _getXController.customerEphemeralKeySecret,
            // allowsDelayedPaymentMethods: true,
            // currencyCode: 'usd',
            style: ThemeMode.dark,
            merchantDisplayName: 'Doorap Stripe Test',
          ));

      displayPaymentSheet();

    } catch (e) {
      log('makePayment Exception : ' + e.toString());
    }
  }


  ///*
  ///
  ///
  displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
    setState(() {});


   /*PaymentIntent paymentIntent =  await Stripe.instance.confirmPayment(_getXController.clientSecretKey, );

   paymentIntent.status;

    if(paymentIntent.status == PaymentIntentsStatus.Succeeded){
      // enableButton;
    }*/
  }
}

