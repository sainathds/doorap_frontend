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
import 'package:door_ap/vendor/model/request/vendor_balance_payment_request.dart';
import 'package:door_ap/vendor/model/request/vendor_received_payment_request.dart';
import 'package:door_ap/vendor/model/request/vendor_withdraw_pament_request.dart';
import 'package:door_ap/vendor/model/response/vendor_balance_payment_response.dart';
import 'package:door_ap/vendor/model/response/vendor_received_payment_response.dart' as receivedPayment;
import 'package:door_ap/vendor/model/response/vendor_withdraw_payment_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorPaymentController extends GetxController{

  String tag = "VendorPaymentController";
  late Function refreshPage;

  double totalBalance = 0.0;
  String pendingAmount = "";
  bool pendingStatus = false;


  List<receivedPayment.Payload> receivedPaymentList = <receivedPayment.Payload>[];

  ///*
  ///
  ///
  void hitToGetBalanceApi() async{
    VendorBalancePaymentRequest requestModel = VendorBalancePaymentRequest();
    requestModel.vendorId = MySharedPreference.getInt(MyConstants.keyUserId);

    final results = await Request().requestPostWithHeader(
        url: vendorBalancePaymentApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        VendorBalancePaymentResponse responseModel = VendorBalancePaymentResponse.fromJson(results);
        log(tag + "hitToGetBalanceApi Response : " + json.encode(responseModel));

        if(responseModel.status == 200){
          if(responseModel.payload != null){
            totalBalance = responseModel.payload!.totalBalance!;
            pendingStatus = responseModel.payload!.withdrawRequestStatus!;
            if(pendingStatus){
              pendingAmount = responseModel.payload!.withdrawMsg!;
            }
            refreshPage.call();
          }else{
            refreshPage.call();
          }
        }else{   // if error occur then msg is "Something went wrong or validation msg"
          refreshPage.call();
        }
      }
    }catch(exception){
      log(tag + "hitToGetBalanceApi Exception " + exception.toString());
    }


  }


  ///*
  ///
  ///
  void hitToWithdrawPayment()async{
    VendorWithdrawPaymentRequest requestModel = VendorWithdrawPaymentRequest();
    requestModel.vendorId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.withdrawAmount = totalBalance;


    final results = await Request().requestPostWithHeader(
        url: vendorWithdrawPaymentApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        VendorWithdrawPaymentResponse responseModel = VendorWithdrawPaymentResponse.fromJson(results);
        log(tag + "hitToWithdrawPayment Response : " + json.encode(responseModel));

        if(responseModel.status == 200){
          showDialog(
              context: Get.context!,
              builder: (BuildContext context1) => CustomDialog(
                  title: "Success",
                  description: responseModel.msg!,
                  my_context: Get.context!,
                  okBtnFunction: hitToGetBalanceApi,
                  buttonText: "OK",
                  img: successImage
              ));

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
      log(tag + "hitToWithdrawPayment Exception " + exception.toString());
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
  void hitGetReceivedPayment() async{
    VendorReceivedPaymentRequest requestModel = VendorReceivedPaymentRequest();
    requestModel.vendorId = MySharedPreference.getInt(MyConstants.keyUserId);

    final results = await Request().requestPostWithHeader(
        url: vendorReceivedPaymentApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        receivedPayment.VendorReceivedPaymentResponse responseModel = receivedPayment.VendorReceivedPaymentResponse.fromJson(results);
        log(tag + "hitGetReceivedPayment Response : " + json.encode(responseModel));

        if(responseModel.status == 200){
          if(responseModel.payload!.isNotEmpty){
            receivedPaymentList = responseModel.payload!;
            refreshPage.call();
          }else{
            receivedPaymentList.clear();
            refreshPage.call();
          }
        }else{   // if error occur then msg is "Something went wrong or validation msg"
          receivedPaymentList.clear();
          refreshPage.call();
        }
      }
    }catch(exception){
      receivedPaymentList.clear();
      log(tag + "hitGetReceivedPayment Exception " + exception.toString());
    }



  }

}