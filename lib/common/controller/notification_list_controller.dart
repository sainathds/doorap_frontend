import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/customdialog.dart';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/model/request/clear_notification_request.dart';
import 'package:door_ap/common/model/request/notification_list_request.dart';
import 'package:door_ap/common/model/request/seen_notification_request.dart';
import 'package:door_ap/common/model/response/clear_notification_response.dart';
import 'package:door_ap/common/model/response/notification_list_response.dart';
import 'package:door_ap/common/model/response/seen_notification_response.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/screen/customer_order_details_screen.dart';
import 'package:door_ap/vendor/screen/vendor_home_screen.dart';
import 'package:door_ap/vendor/screen/vendor_order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationListController extends GetxController{

  String tag = 'NotificationListController ';

  late String userType;
  late Function refreshPage;
  List<Payload> notificationList = <Payload>[];


  ///*
  ///
  /// get notification by calling show_notification/ Api
  void hitNotificationListApi() async{
    NotificationListRequest requestModel = NotificationListRequest(
      userId: MySharedPreference.getInt(MyConstants.keyUserId),
      userType: userType
    );


    final results = await Request().requestPostWithHeader(
        url: notificationListApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        NotificationListResponse responseModel = NotificationListResponse.fromJson(results);
        log(tag + "hitNotificationListApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          if(responseModel.payload != null && responseModel.payload!.isNotEmpty ){
            notificationList.clear();
            notificationList = responseModel.payload!;
            refreshPage.call();
          }else{
            notificationList.clear();
            refreshPage.call();
          }
        }else{   // if error occur then msg is "Something went wrong or validation msg"
          notificationList.clear();
          refreshPage.call();
        }
      }
    }catch(exception){
      log(tag + "hitNotificationListApi Exception : " + exception.toString() );
      notificationList.clear();
      refreshPage.call();
    }

  }

  ///*
  ///
  /// update seen status by caling notification_seen/ Api
  void hitSeenNotificationApi(int index) async{
    SeenNotificationRequest requestModel = SeenNotificationRequest(
      notificationId: notificationList[index].id
    );

    final results = await Request().requestPostHeaderNoProgressBar(
        url: seenNotificationApi,
        parameters: json.encode(requestModel),
        context: Get.context);


    try{
      if(results != null) {
        SeenNotificationResponse responseModel = SeenNotificationResponse.fromJson(results);
        log(tag + "hitSeenNotificationApi Response : " + json.encode(responseModel) );

        if (responseModel.status == 200) {
          notificationList[index].isSeen = true;
          refreshPage.call();

          //redirect on screen
          if(notificationList[index].fkOrderId == 0 && notificationList[index].userType == 'Vendor'){
            Navigator.pushAndRemoveUntil(
                Get.context!,
                MaterialPageRoute(
                    builder: (context) => VendorHomeScreen()),
                    (route) => false);

          }else if(notificationList[index].fkOrderId != 0 && notificationList[index].userType == 'Vendor'){
            Get.to(() => VendorOrderDetailsScreen(
                orderPrimaryKey: notificationList[index].fkOrderId!,
                orderUniqueId: notificationList[index].fkOrderOrderId!));

          }else if(notificationList[index].fkOrderId != 0 && notificationList[index].userType == 'Customer'){
            Get.to(() => CustomerOrderDetailsScreen(
                orderPrimaryKey: notificationList[index].fkOrderId!,
                orderUniqueId: notificationList[index].fkOrderOrderId!,
                callFrom: 'NotificationList',));

          }

        }
      }else{
        log(tag + "hitSeenNotificationApi Response : Null" );
      }
    }catch(exception){
      log(tag + "hitSeenNotificationApi Exception : " + exception.toString() );
    }
  }



  ///*
  ///
  /// clear all notification using delete_notification/ Api
  void hitClearNotificationApi() async{
    ClearNotificationRequest requestModel = ClearNotificationRequest(
        userId: MySharedPreference.getInt(MyConstants.keyUserId),
        userType: userType
    );


    final results = await Request().requestPostWithHeader(
        url: clearNotificationApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        ClearNotificationResponse responseModel = ClearNotificationResponse.fromJson(results);
        log(tag + "hitClearNotificationApi Response : " + responseModel.toString());

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
                    okBtnFunction: hitNotificationListApi
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
      log(tag + "hitClearNotificationApi Exception : " + exception.toString() );
      refreshPage.call();
    }

  }
}