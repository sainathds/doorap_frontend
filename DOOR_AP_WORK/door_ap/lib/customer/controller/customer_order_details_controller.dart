import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/customer/model/request/customer_order_details_request.dart';
import 'package:door_ap/customer/model/response/customer_order_details_response.dart';
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

  //order_service
  List<OrderService> orderService = <OrderService>[];


  //vendor_profile
  String vendorName = "";
  String categoryName = "";

  //payment_information
  int duration = 0;
  double totalAmount = 0.0;
  String address = "";


  ///*
  ///
  ///
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
              status = orderPayload!.orderData!.orderStatus!;
            }

            //order_Service
            if(orderPayload!.orderService != null && orderPayload!.orderService!.isNotEmpty ){
              orderService = orderPayload!.orderService!;
            }

            //vendor_details
            if(orderPayload!.vendorDetails != null){
              vendorName = orderPayload!.vendorDetails!.fkVendorFullName!;
              categoryName = orderPayload!.vendorDetails!.fkServiceFkCategoryCategoryName!;
            }

            //payment_information
            if(orderPayload!.paymentInformation != null){
              totalAmount = orderPayload!.paymentInformation!.totalAmount!;
              duration = orderPayload!.paymentInformation!.duration!;
              address = orderPayload!.paymentInformation!.address!;
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

    //order_service
    orderService.clear();

    //vendor_profile
    vendorName = "";
    categoryName = "";

    //payment_information
     duration = 0;
     totalAmount = 0.0;
     address = "";

  }


}