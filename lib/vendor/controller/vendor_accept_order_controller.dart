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
import 'package:door_ap/vendor/controller/vendor_home_controller.dart';
import 'package:door_ap/vendor/model/request/vendor_order_list_request.dart';
import 'package:door_ap/vendor/model/request/vendor_start_job_request.dart';
import 'package:door_ap/vendor/model/request/vendro_accept_decline_order_request.dart';
import 'package:door_ap/vendor/model/response/vendor_accept_decline_order_response.dart';
import 'package:door_ap/vendor/model/response/vendor_order_list_response.dart';
import 'package:door_ap/vendor/model/response/vendor_start_job_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorAcceptOrderController extends GetxController{

  String tag = "VendorAcceptOrderController";
  late Function refreshPage;
  List<Payload> acceptedOrderList = <Payload>[];

  late VendorHomeController vendorHomeController;



  ///*
  ///
  /// get Accepted Orders list by calling show_order_to_vendor/ Api
  /// pass orderStatus value as "Accepted"
  void hitVendorOrdersApi() async{
    VendorOrderListRequest requestModel = VendorOrderListRequest();
    requestModel.vendorId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.orderStatus = 'Accepted';

    final results = await Request().requestPostWithHeader(
        url: vendorOrderListApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){

        VendorOrderListResponse responseModel = VendorOrderListResponse.fromJson(results);
        log(tag + "hitVendorOrdersApi Response : " + json.encode(responseModel));

        if(responseModel.status == 200){
          if(responseModel.payload != null && responseModel.payload!.isNotEmpty){
            acceptedOrderList.clear();
            acceptedOrderList = responseModel.payload!;
          }else{
            acceptedOrderList.clear();
          }

          refreshPage.call();
        }else{// if error occur then msg is "Something went wrong or validation msg"
          log('hitVendorOrdersApi Error: ');

        }
      }
    }catch(exception){
      log('hitVendorOrdersApi Exception: ' + exception.toString() );
    }


  }


  ///*
  ///
  ///
  void hitCancelOrderApi(int primaryId, String orderId, String orderStatus, int customerId ) async{
    VendorAcceptDeclineOrderRequest requestModel = VendorAcceptDeclineOrderRequest();
    requestModel.id = primaryId;
    requestModel.orderId = orderId;
    requestModel.orderStatus = orderStatus;
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
                    okBtnFunction: hitVendorOrdersApi
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
  ///
  void hitStartJobApi(int primaryId, String orderId, String orderStatus, int customerId, int vendorId) async{
    VendorStartJobRequest requestModel = VendorStartJobRequest();
    requestModel.id = primaryId;
    requestModel.orderId = orderId;
    requestModel.orderStatus = orderStatus;
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
                    okBtnFunction: hitAcceptedAndCurrentOrderApi
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

  ///*
  ///
  ///
  hitAcceptedAndCurrentOrderApi() {
    vendorHomeController.hitCurrentOrderApi();
    hitVendorOrdersApi();
  }

}