import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/model/request/notification_count_request.dart';
import 'package:door_ap/common/model/response/notification_count_response.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/global_data.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/model/request/customer_cart_count_request.dart';
import 'package:door_ap/customer/model/response/customer_banner_response.dart' as customerBannerResponse;
import 'package:door_ap/customer/model/response/customer_cart_count_response.dart';
import 'package:door_ap/vendor/model/response/vendor_categories_response.dart' as vendorCategoriesResponse;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerHomeController extends GetxController{

  String tag = 'CustomerHomeController';
  TextEditingController searchEditController = TextEditingController();
  List<vendorCategoriesResponse.Payload?>  categoriesData = <vendorCategoriesResponse.Payload?>[];
  List<customerBannerResponse.Payload?>  bannerData = <customerBannerResponse.Payload?>[];
  late Function refreshPage;

  int notificationCount = 0;


  // int cartCount = 0;
  // int categoryId = 0;
  // int vendorId = 0;

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
          refreshPage.call();
        }else{// if error occur then msg is "Something went wrong or validation msg"
          log('hitCartCountApi Error: ');

        }
      }
    }catch(exception){
      log('hitCartCountApi Exception: ' + exception.toString() );
    }


  }

  ///*
  ///
  ///
  void hitNotificationCountApi() async{
    NotificationCountRequest requestModel = NotificationCountRequest();
    requestModel.userId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.userType = 'Customer';

    final results = await Request().requestPostHeaderNoProgressBar(
        url: notificationCountApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){

        NotificationCountResponse responseModel = NotificationCountResponse.fromJson(results);
        log(tag + "hitNotificationCountApi Response : " + json.encode(responseModel));

        if(responseModel.status == 200){
          notificationCount = responseModel.notificationCount!;
          refreshPage.call();
        }else{// if error occur then msg is "Something went wrong or validation msg"
          log('hitNotificationCountApi Error: ');
          notificationCount = 0;
          refreshPage.call();
        }
      }
    }catch(exception){
      log('hitNotificationCountApi Exception: ' + exception.toString() );
      notificationCount = 0;
      refreshPage.call();
    }

  }



  ///*
  ///
  ///
  void hitCategoriesApi() async{
    final results = await Request().requestGetWithHeader(
        url: vendorCategoriesApi,
        context: Get.context);

    try{
      if(results != null){
        vendorCategoriesResponse.VendorCategoriesResponse responseModel = vendorCategoriesResponse.VendorCategoriesResponse.fromJson(results);
        log(tag + "hitCategoriesApi Response : " + json.encode(responseModel));
        if(responseModel.status == 200){
          if(responseModel.payload != null){
            categoriesData.clear();
            categoriesData = responseModel.payload!;
            hitBannerListApi();
            refreshPage.call();
          }

        }else{   // if error occur then msg is "Something went wrong or validation msg"
          /*showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: responseModel.msg!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );*/

        }
      }
    }catch(exception){
      /*log(tag + "hitCategoriesApi Exception " + exception.toString());
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: MyString.errorMessage!,
          img: errorImage,
          text: '',
          key: null,
        ),
      );*/
    }

  }

  ///*
  ///
  ///
  void hitBannerListApi() async{
    final results = await Request().requestGetWithHeader(
        url: customerBannerApi,
        context: Get.context);

    try{
      if(results != null){
        customerBannerResponse.CustomerBannerResponse responseModel = customerBannerResponse.CustomerBannerResponse.fromJson(results);
        log(tag + "hitBannerListApi Response : " + json.encode(responseModel));
        if(responseModel.status == 200){
          if(responseModel.payload != null){
            bannerData.clear();
            bannerData = responseModel.payload!;
            hitCartCountApi();
            refreshPage.call();
          }

        }else{   // if error occur then msg is "Something went wrong or validation msg"
          /*showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: responseModel.msg!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );*/

        }
      }
    }catch(exception){
      /*log(tag + "hitBannerListApi Exception " + exception.toString());
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: MyString.errorMessage!,
          img: errorImage,
          text: '',
          key: null,
        ),
      );*/
    }

  }

}