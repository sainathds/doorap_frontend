import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/customdialog.dart';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/model/request/customer_cancel_order_request.dart';
import 'package:door_ap/customer/model/request/customer_complete_order_request.dart';
import 'package:door_ap/customer/model/request/customer_my_order_request.dart';
import 'package:door_ap/customer/model/response/customer_my_order_response.dart';
import 'package:door_ap/customer/model/response/customer_update_status_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerMyOrdersController extends GetxController{

  String tag = 'CustomerMyOrdersController';
  late Function refreshPage;
  List<Payload> myOrders = <Payload>[];





  ///*
  ///
  ///
  void hitMyOrderApi() async{
    CustomerMyOrderRequest requestModel = CustomerMyOrderRequest();
    requestModel.customerId = MySharedPreference.getInt(MyConstants.keyUserId);

    final results = await Request().requestPostWithHeader(
        url: customerMyOrderApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){

        CustomerMyOrderResponse responseModel = CustomerMyOrderResponse.fromJson(results);
        log(tag + "hitMyOrderApi Response : " + json.encode(responseModel));

        if(responseModel.status == 200){
          if(responseModel.payload != null && responseModel.payload!.isNotEmpty){
            myOrders.clear();
            myOrders = responseModel.payload!;
          }
          refreshPage.call();
        }else{// if error occur then msg is "Something went wrong or validation msg"
          log('hitMyOrderApi Error: ');

        }
      }
    }catch(exception){
      log('hitMyOrderApi Exception: ' + exception.toString() );
    }


  }


  ///*
  ///
  ///CANCEL order
  void hitCancelOrderApi(int orderPrimaryKey, String orderId, vendorId) async{
    CustomerCancelOrderRequest requestModel = CustomerCancelOrderRequest();
    requestModel.id = orderPrimaryKey;
    requestModel.orderId = orderId;
    requestModel.vendorId = vendorId;


    final results = await Request().requestPostWithHeader(
        url: customerCancelOrderApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerUpdateStatusResponse responseModel = CustomerUpdateStatusResponse.fromJson(results);
        log(tag + "hitCancelOrderApi Response : " + responseModel.toString());
        if(responseModel.status == 200){

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) =>
                CustomDialog(
                    my_context: Get.context!,
                    img: successImage,
                    title: "",
                    description: responseModel.msg!,
                    buttonText: 'Ok',
                    okBtnFunction: hitMyOrderApi
                ),
          );

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
      log(tag + "hitCancelOrderApi Exception " + exception.toString());
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
  /// COMPLETE Order
  void hitCompleteOrderApi(int orderPrimaryKey, String orderId, int vendorId) async{
    CustomerCompleteOrderRequest requestModel = CustomerCompleteOrderRequest();
    requestModel.id = orderPrimaryKey;
    requestModel.orderId = orderId;
    requestModel.vendorId = vendorId;  //required in order details n order list response


    final results = await Request().requestPostWithHeader(
        url: customerCompletedOrderApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerUpdateStatusResponse responseModel = CustomerUpdateStatusResponse.fromJson(results);
        log(tag + "hitCompleteOrderApi Response : " + responseModel.toString());
        if(responseModel.status == 200){

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) =>
                CustomDialog(
                    my_context: Get.context!,
                    img: successImage,
                    title: "",
                    description: responseModel.msg!,
                    buttonText: 'Ok',
                    okBtnFunction: hitMyOrderApi
                ),
          );

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
      log(tag + "hitCompleteOrderApi Exception " + exception.toString());
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