import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/global_data.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/model/request/customer_book_order_request.dart';
import 'package:door_ap/customer/model/request/customer_cart_count_request.dart';
import 'package:door_ap/customer/model/request/customer_payment_intent_request.dart';
import 'package:door_ap/customer/model/response/customer_book_order_response.dart';
import 'package:door_ap/customer/model/response/customer_cart_count_response.dart';
import 'package:door_ap/customer/model/response/customer_payment_intent_response.dart';
import 'package:door_ap/customer/screen/customer_order_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerCheckoutController extends GetxController{
  String tag = "CustomerCheckoutController";
  TextEditingController locationEditController = TextEditingController();
  CustomerBookOrderRequest requestModel = CustomerBookOrderRequest();
  double latitude = 0.0;
  double longitude = 0.0;
  String address = "";
  String city = "";
  String zipCode = "";
  String countryName = "";



  bool isPaymentSucceeded = false;



  late Function makePayment;
  String stripeClientSecretKey = '';
  String stripeEphemeralKeySecret = '';
  String stripeCustomerId = '';
  String paymentIntentId = '';


  ///*
  ///
  /// it is use to generate payment with stripe and provide client_secret key
  /// which is use to make payment
  void hitCreatePaymentIntentApi(double totalAmount) async{

    CustomerPaymentIntentRequest requestModel = CustomerPaymentIntentRequest();
    requestModel.userId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.amount = totalAmount.toInt();
    requestModel.email  = MySharedPreference.getString(MyConstants.keyEmail);


    final results = await Request().requestPostWithHeader(
        url: customerCreatePaymentIntentApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerPaymentIntentResponse responseModel = CustomerPaymentIntentResponse.fromJson(results);
        log(tag + "hitCreatePaymentIntentApi Response : " + json.encode(responseModel));

        if(responseModel.status == 200){

          stripeClientSecretKey = '';
          stripeCustomerId = '';
          stripeEphemeralKeySecret = '';
          paymentIntentId = '';

          stripeClientSecretKey = responseModel.payload!.clientSecret!;
          stripeCustomerId = responseModel.payload!.customerId!;
          stripeEphemeralKeySecret = responseModel.payload!.ephemeralKey!;
          paymentIntentId = responseModel.payload!.paymentIntentId!;

          log('CUSTOMER_ID :  ' + stripeCustomerId );
          log('CLIENT_SECRET :  ' + stripeClientSecretKey);
          log('EPHMERAL_KEY :  ' + stripeEphemeralKeySecret);

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


  ///*
  ///
  ///
  void hitBookingOrderApi() async{
    requestModel.address = address;
    requestModel.customerCountry = countryName;
    requestModel.city = city;
    requestModel.zipCode = int.parse(zipCode);
    requestModel.lat = latitude;
    requestModel.lng = longitude;
    requestModel.paymentIntentId = paymentIntentId;


    final results = await Request().requestPostWithHeader(
        url: customerBookOrderApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerBookOrderResponse responseModel = CustomerBookOrderResponse.fromJson(results);
        log(tag + "hitBookingOrderApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          hitCartCountApi();
          if(responseModel.payload != null){
            MySharedPreference.setString(MyConstants.keyPromoCode, "");
            Get.off(() => CustomerOrderDetailsScreen(
              orderPrimaryKey: responseModel.payload!.id!,
              orderUniqueId: responseModel.payload!.orderId!,
                callFrom: 'CheckoutScreen'));
          }
        }else{   // if error occur then msg is "Something went wrong or validation msg"
          log("hitBookingOrderApi Error : ");
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
      log("hitBookingOrderApi Exception : " + exception.toString());
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



  ///*
  ///
  ///
  void hitCartCountApi() async{
    CustomerCartCountRequest requestModel = CustomerCartCountRequest();
    requestModel.customerId = MySharedPreference.getInt(MyConstants.keyUserId);

    final results = await Request().requestPostHeaderNoProgressBar(
        url: customerCartCountApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){

        CustomerCartCountResponse responseModel = CustomerCartCountResponse.fromJson(results);
        log(tag + "hitCartCountApi Response : " + json.encode(responseModel));

        if(responseModel.status == 200){
          GlobalData.cartCount = responseModel.payload!.itemCount!;
          GlobalData.cartCategoryId = responseModel.payload!.categoryId!;
          GlobalData.vendorId = responseModel.payload!.vendorId!;

        }else{// if error occur then msg is "Something went wrong or validation msg"
          log('hitCartCountApi Error: ');

        }
      }
    }catch(exception){
      log('hitCartCountApi Exception: ' + exception.toString() );
    }


  }

}