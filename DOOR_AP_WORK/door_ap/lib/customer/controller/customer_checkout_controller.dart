import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/customer/model/request/customer_book_order_request.dart';
import 'package:door_ap/customer/model/response/customer_book_order_response.dart';
import 'package:door_ap/customer/screen/customer_order_details_screen.dart';
import 'package:flutter/cupertino.dart';
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

  ///*
  ///
  ///
  void hitBookingOrderApi() async{
    requestModel.address = address;
    requestModel.city = city;
    requestModel.zipCode = int.parse(zipCode);
    requestModel.lat = latitude;
    requestModel.lng = longitude;

    final results = await Request().requestPostWithHeader(
        url: customerBookOrderApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerBookOrderResponse responseModel = CustomerBookOrderResponse.fromJson(results);
        log(tag + "hitRemoveFromCartApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          if(responseModel.payload != null){
            Get.off(() => CustomerOrderDetailsScreen(orderPrimaryKey: responseModel.payload!.id!, orderUniqueId: responseModel.payload!.orderId!,));
          }


        }else{   // if error occur then msg is "Something went wrong or validation msg"
          log("hitRemoveFromCartApi Error : ");

        }
      }
    }catch(exception){
      log("hitRemoveFromCartApi Exception : " + exception.toString());
    }

  }
}