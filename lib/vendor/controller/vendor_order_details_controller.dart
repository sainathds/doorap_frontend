import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/customdialog.dart';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/vendor/model/request/vendor_order_details_request.dart';
import 'package:door_ap/vendor/model/request/vendor_start_job_request.dart';
import 'package:door_ap/vendor/model/request/vendro_accept_decline_order_request.dart';
import 'package:door_ap/vendor/model/response/vendor_accept_decline_order_response.dart';
import 'package:door_ap/vendor/model/response/vendor_order_details_response.dart';
import 'package:door_ap/vendor/model/response/vendor_start_job_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorOrderDetailsController extends GetxController{

  String tag = "VendorOrderDetailsController";
  late Function refreshPage;

  //requestBody param
  late int orderPrimaryKey;
  late String orderUniqueId;

  Payload? orderPayload;

  //order_data
  String orderId = "";
  String status = "";
  String bookingDate = "";
  String bookingTime = "";
  String categoryName = "";
  int customerId = 0;
  int vendorId = 0;
  String serviceAddress = ""; //customer address



  //order_service
  List<OrderService> orderService = <OrderService>[];

  //Customer Info
  String customerName = "";

  //payment_information
  double totalPrice = 0.0;
  int totalItem = 0;
  double convenienceFees = 0.0;
  double totalAmount = 0.0;

  ///*
  ///
  void clearData() {
    orderPayload = null;

    //customer info
    customerName = "";

    //order_data
    orderId = "";
    status = "";
    bookingDate = "";
    bookingTime = "";
    categoryName = "";
    customerId = 0;
    vendorId = 0;
    serviceAddress = "";


    //order_service
    orderService.clear();

    //payment_information
    totalPrice = 0.0;
    totalItem = 0;
    convenienceFees = 0.0;
    totalAmount = 0.0;

  }


  ///*
  ///
  /// get order details by calling show_vendor_order_detail/ Api
  void hitGetOrderDetailsApi() async{

    VendorOrderDetailsRequest requestModel = VendorOrderDetailsRequest();
    requestModel.id = orderPrimaryKey; //order primary key 35
    requestModel.orderId = orderUniqueId;  //order unique id ORD4353288

    final results = await Request().requestPostWithHeader(
        url: vendorOrderDetailsApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        VendorOrderDetailsResponse responseModel = VendorOrderDetailsResponse.fromJson(results);
        log(tag + "hitGetOrderDetailsApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          if(responseModel.payload != null){
            orderPayload = responseModel.payload!;

            //order_data
            if(orderPayload!.orderData != null){
              orderId = orderPayload!.orderData!.orderId!;
              bookingDate = orderPayload!.orderData!.bookingDate!;
              bookingTime = orderPayload!.orderData!.bookingStartTime!;
              status = orderPayload!.orderData!.orderStatus!;
              categoryName = orderPayload!.orderData!.fkCategoryCategoryName!;
              customerId = orderPayload!.orderData!.fkCustomer!;
              vendorId = orderPayload!.orderData!.fkVendor!;
              serviceAddress = orderPayload!.orderData!.address!;
            }

            //order_Service
            if(orderPayload!.orderService != null && orderPayload!.orderService!.isNotEmpty ){
              orderService = orderPayload!.orderService!;
            }

            //vendor_details
            if(orderPayload!.customerDetails != null){
              customerName = orderPayload!.customerDetails!.fkCustomerName!;
            }

            //payment_information
            if(orderPayload!.paymentInformation != null){
              totalItem = orderPayload!.paymentInformation!.quantity!;
              totalPrice = orderPayload!.paymentInformation!.subTotal!;
              convenienceFees = orderPayload!.paymentInformation!.vendorConvenienceFee!;
              totalAmount = orderPayload!.paymentInformation!.vendorPayAmount!;
            }
            refreshPage.call();
          }
        }else{   // if error occur then msg is "Something went wrong or validation msg"

          orderPayload = null;
          orderService.clear();
          refreshPage.call();
          log("hitGetOrderDetailsApi Error : ");

        }
      }
    }catch(exception){
      orderPayload = null;
      orderService.clear();
      refreshPage.call();
      log("hitGetOrderDetailsApi Exception : " + exception.toString());
    }

  }


  ///*
  ///
  /// accept or reject order by calling order_accept_decline/ Api
  void hitAcceptDeclineOrderApi(String orderStatus ) async{
    VendorAcceptDeclineOrderRequest requestModel = VendorAcceptDeclineOrderRequest();
    requestModel.id = orderPrimaryKey;
    requestModel.orderId = orderUniqueId;
    requestModel.orderStatus = orderStatus;
    requestModel.customerId = customerId;


    final results = await Request().requestPostWithHeader(
        url: vendorAcceptDeclineOrderApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        VendorAcceptDeclineOrderResponse responseModel = VendorAcceptDeclineOrderResponse.fromJson(results);
        log(tag + "hitAcceptDeclineOrderApi Response : " + responseModel.toString());
        if(responseModel.status == 200){

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) =>
                CustomDialog(
                    my_context: Get.context!,
                    img: orderStatus == 'Accepted' ? successImage : declineIc,
                    title: orderStatus == 'Accepted'? "" : 'Sorry',
                    description: responseModel.msg!,
                    buttonText: 'Ok',
                    okBtnFunction: hitGetOrderDetailsApi
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
      log(tag + "hitAcceptDeclineOrderApi Exception " + exception.toString());
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
  /// cancel order by calling order_accept_decline/ Api
  void hitCancelOrderApi() async{
    VendorAcceptDeclineOrderRequest requestModel = VendorAcceptDeclineOrderRequest();
    requestModel.id = orderPrimaryKey;
    requestModel.orderId = orderUniqueId;
    requestModel.orderStatus = 'Cancelled';
    requestModel.customerId = customerId;


    final results = await Request().requestPostWithHeader(
        url: vendorAcceptDeclineOrderApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        VendorAcceptDeclineOrderResponse responseModel = VendorAcceptDeclineOrderResponse.fromJson(results);
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
                    okBtnFunction: hitGetOrderDetailsApi
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
  /// start job by calling order_start_job/ Api
  void hitStartJobApi() async{
    VendorStartJobRequest requestModel = VendorStartJobRequest();
    requestModel.id = orderPrimaryKey;
    requestModel.orderId = orderUniqueId;
    requestModel.orderStatus = 'Started';
    requestModel.customerId = customerId;
    requestModel.vendorId = vendorId;

    final results = await Request().requestPostWithHeader(
        url: vendorStartOrderApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        VendorStartJobResponse responseModel = VendorStartJobResponse.fromJson(results);
        log(tag + "hitStartJobApi Response : " + responseModel.toString());
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
                    okBtnFunction: hitGetOrderDetailsApi
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
      log(tag + "hitStartJobApi Exception " + exception.toString());
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