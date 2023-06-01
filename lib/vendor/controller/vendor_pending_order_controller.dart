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
import 'package:door_ap/vendor/model/request/vendro_accept_decline_order_request.dart';
import 'package:door_ap/vendor/model/response/vendor_accept_decline_order_response.dart';
import 'package:door_ap/vendor/model/response/vendor_order_list_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorPendingOrderController extends GetxController{


  String tag = "VendorPendingOrderController";
  late Function refreshPage;
  late Function redirectToAccepted;
  List<Payload> pendingOrderList = <Payload>[];



  ///*
  ///
  /// get Pending Orders list by calling show_order_to_vendor/ Api
  /// pass orderStatus value as "Pending"
  void hitVendorOrdersApi() async{
    VendorOrderListRequest requestModel = VendorOrderListRequest();
    requestModel.vendorId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.orderStatus = 'Pending';

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
            pendingOrderList.clear();
            pendingOrderList = responseModel.payload!;
          }else{
            pendingOrderList.clear();
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
  void hitAcceptDeclineOrderApi(int primaryId, String orderId, String orderStatus, int customerId ) async{
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
        log(tag + "hitAcceptDeclineOrderApi Response : " + responseModel.toString());
        if(responseModel.status == 200){


          if(orderStatus == 'Accepted'){
            redirectToAccepted.call();

          }else{
            showDialog(
              context: Get.context!,
              builder: (BuildContext context1) =>
                  CustomDialog(
                      my_context: Get.context!,
                      img: /*orderStatus == 'Accepted' ? successImage :*/ declineIc,
                      title: /*orderStatus == 'Accepted'? "" : */'Sorry',
                      description: responseModel.msg!,
                      buttonText: 'Ok',
                      okBtnFunction: hitVendorOrdersApi
                  ),
            );
          }
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




}