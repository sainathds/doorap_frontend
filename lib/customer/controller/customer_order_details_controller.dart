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
import 'package:door_ap/customer/model/request/customer_feedback_request.dart';
import 'package:door_ap/customer/model/request/customer_order_details_request.dart';
import 'package:door_ap/customer/model/response/customer_feedback_response.dart';
import 'package:door_ap/customer/model/response/customer_order_details_response.dart';
import 'package:door_ap/customer/model/response/customer_update_status_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerOrderDetailsController extends GetxController{

  String tag = "CustomerOrderDetailsController";
  late Function refreshPage;

  //requestbody param
  late int orderPrimaryKey;
  late String orderUniqueId;


  Payload? orderPayload;

  //order_data
  String orderId = "";
  String status = "";
  String bookingDate = "";
  String bookingTime = "";
  String address = "";

  //order_service
  List<OrderService> orderService = <OrderService>[];


  //vendor_profile
  int vendorId = 0;
  int vendorUserId = 0;
  String vendorName = "";
  String categoryName = "";
  String vendorImage = "";

  //payment_information
  int totalItem = 0;
  double totalPrice = 0.0;
  double discount = 0.0;
  double convenienceFees = 0.0;
  double totalAmount = 0.0;


  //feedback and review
  List<Reviewandfeedback> reviewAndFeedback = <Reviewandfeedback>[];
  double rating = 0.0;
  String feedback = "";


  //feedback
  TextEditingController reviewEditController = TextEditingController();
  double ratingValue = 0.0;


  ///*
  ///
  /// get order details by calling show_customer_order_detail/ Api
  void hitGetOrderDetailsApi() async{

    CustomerOrderDetailsRequest requestModel = CustomerOrderDetailsRequest();
    requestModel.id = orderPrimaryKey; //order primary key 35
    requestModel.orderId = orderUniqueId;  //order unique id ORD4353288

    final results = await Request().requestPostWithHeader(
        url: customerOrderDetailsApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerOrderDetailsResponse responseModel = CustomerOrderDetailsResponse.fromJson(results);
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
              vendorId = orderPayload!.orderData!.fkVendor!;
              address = orderPayload!.orderData!.address!;
            }

            //order_Service
            if(orderPayload!.orderService != null && orderPayload!.orderService!.isNotEmpty ){
              orderService = orderPayload!.orderService!;
            }

            //vendor_details
            if(orderPayload!.vendorDetails != null){
              // vendorId = orderPayload!.vendorDetails!.
              vendorUserId = orderPayload!.vendorDetails!.fkVendorFkUserId!;
              vendorName = orderPayload!.vendorDetails!.fkVendorFullName!;
              vendorImage = orderPayload!.vendorDetails!.fkVendorProfileImage!;
              categoryName = orderPayload!.vendorDetails!.fkServiceFkCategoryCategoryName!;

            }

            //payment_information
            if(orderPayload!.paymentInformation != null){
              totalItem = orderPayload!.paymentInformation!.quantity!;
              totalPrice = orderPayload!.paymentInformation!.subTotal!;
              discount = orderPayload!.paymentInformation!.discount!;
              convenienceFees = orderPayload!.paymentInformation!.convenienceFee!;
              totalAmount = orderPayload!.paymentInformation!.totalAmount!;
            }

            //Review And feedback
            if(orderPayload!.reviewandfeedback != null && orderPayload!.reviewandfeedback!.isNotEmpty ){
              reviewAndFeedback = orderPayload!.reviewandfeedback!;
              rating = reviewAndFeedback[0].rating!;
              feedback = reviewAndFeedback[0].feedback!;
            }

            refreshPage.call();
          }
        }else{   // if error occur then msg is "Something went wrong or validation msg"
          orderService.clear();
          refreshPage.call();
          log("hitGetOrderDetailsApi Error : ");

        }
      }
    }catch(exception){
      orderService.clear();
      refreshPage.call();
      log("hitGetOrderDetailsApi Exception : " + exception.toString());
    }

  }

  ///*
  ///
  void clearData() {
    orderPayload = null;

    //order_data
     orderId = "";
     status = "";
     bookingDate = "";
     bookingTime = "";
     address = "";


    //order_service
    orderService.clear();

    //vendor_profile
    vendorId = 0;
    vendorName = "";
    categoryName = "";
    vendorImage = "";

    //payment_information
     totalItem = 0;
     totalPrice = 0.0;
     discount = 0.0;
     convenienceFees = 0.0;
     totalAmount = 0.0;


     //reviewAndFeedback
    reviewAndFeedback.clear();
    rating = 0.0;
    feedback = "";
  }


  ///*
  ///
  ///CANCEL order by calling
  /// customer_cancel_order/ Api
  void hitCancelOrderApi() async{
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
  /// COMPLETE Order
  /// once job start by vendor
  /// order will complete only when customer
  /// click on button "Mark as Completed"
  /// i.e complete order by calling order_completed/
  void hitCompleteOrderApi() async{
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



  ///*
  ///
  /// give feedback by calling rating_feedback/ api
  void hitFeedbackApi() async{
    CustomerFeedbackRequest requestModel = CustomerFeedbackRequest();
    requestModel.id = orderPrimaryKey;
    requestModel.vendorId = vendorId;
    requestModel.rating = ratingValue;
    requestModel.feedback = reviewEditController.text;


    final results = await Request().requestPostWithHeader(
        url: customerFeedbackApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerFeedbackResponse responseModel = CustomerFeedbackResponse.fromJson(results);
        log(tag + "hitFeedbackApi Response : " + responseModel.toString());
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
                    okBtnFunction: dismissDialogAndHitApi
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
      log(tag + "hitFeedbackApi Exception " + exception.toString());
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
  dismissDialogAndHitApi() {
    Navigator.pop(Get.context!);
    hitGetOrderDetailsApi();
  }
}