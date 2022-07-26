import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/model/request/customer_payment_intent_request.dart';
import 'package:door_ap/customer/model/response/customer_payment_intent_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


class CustomerPaymentController extends GetxController{


  String tag = 'CustomerPaymentController';

  TextEditingController cardNoEditController = TextEditingController();
  TextEditingController expiryDateEditController = TextEditingController();
  TextEditingController cvvNoEditController = TextEditingController();
  TextEditingController cardHolderEditController = TextEditingController();


  FocusNode cardNoFocus = FocusNode();
  FocusNode expiryDateFocus = FocusNode();
  FocusNode cvvNoFocus = FocusNode();
  FocusNode cardHolderFocus = FocusNode();


  bool isCardNoEmpty = false;
  bool isExpiryDateEmpty = false;
  bool isCvvNoEmpty = false;
  bool isCardHolderEmpty = false;


  ///*
  ///
  ///
  void isCardDataValid(){

    if(cardNoEditController.text.isEmpty){
      isCardNoEmpty = true;

    }else if(expiryDateEditController.text.isEmpty){
      isCardNoEmpty = false;
      isExpiryDateEmpty = true;

    }else if(cvvNoEditController.text.isEmpty){
      isCardNoEmpty = false;
      isExpiryDateEmpty = false;
      isCvvNoEmpty = true;

    }else if(cardHolderEditController.text.isEmpty){
      isCardNoEmpty = false;
      isExpiryDateEmpty = false;
      isCvvNoEmpty = false;
      isCardHolderEmpty = true;

    }else{
      setErrorFieldToFalse();
      // saveCardAndCreateToken();
    }

  }

  ///*
  ///
  ///
  void setErrorFieldToFalse() {
    isCardNoEmpty = false;
    isExpiryDateEmpty = false;
    isCvvNoEmpty = false;
    isCardHolderEmpty = false;

  }




   late Function makePayment;
   String clientSecretKey = '';
   String customerEphemeralKeySecret = '';
   String customerId = '';


  ///*
  ///
  /// it is use to generate payment with stripe and provide client_secret key
  /// which is use to make payment
  void hitCreatePaymentIntentApi() async{

    CustomerPaymentIntentRequest requestModel = CustomerPaymentIntentRequest();
    requestModel.userId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.amount = 7;


    final results = await Request().requestPostWithHeader(
        url: customerCreatePaymentIntentApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerPaymentIntentResponse responseModel = CustomerPaymentIntentResponse.fromJson(results);
        log(tag + "hitCreatePaymentIntentApi Response : " + json.encode(responseModel));

        if(responseModel.status == 200){

          clientSecretKey = '';
          customerId = '';
          customerEphemeralKeySecret = '';

          clientSecretKey = responseModel.payload!.clientSecret!;
          customerId = responseModel.payload!.customerId!;
          customerEphemeralKeySecret = responseModel.payload!.ephemeralKey!;

          log('CUSTOMER_ID :  ' + customerId );
          log('CLIENT_SECRET :  ' + clientSecretKey);
          log('EPHMERAL_KEY :  ' + customerEphemeralKeySecret);


          makePayment.call();

        }else{   // if error occur then msg is "Something went wrong or validation msg"
          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: responseModel.msg!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );

        }
      }
    }catch(exception){
      log(tag + "hitCreatePaymentIntentApi Exception " + exception.toString());
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: MyString.errorMessage!,
          img: errorImage,
          text: '',
          key: null,
        ),
      );
    }

  }

}