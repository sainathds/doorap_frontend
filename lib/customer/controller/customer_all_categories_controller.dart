import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/vendor/model/response/vendor_categories_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerAllCategoriesController extends GetxController{

  String tag = "CustomerAllCategoriesController";
  late Function refreshPage;
  List<Payload?>  categoriesData = <Payload?>[];

  ///*
  ///
  ///
  void hitCategoriesApi() async{
    final results = await Request().requestGetWithHeader(
        url: vendorCategoriesApi,
        context: Get.context);

    try{
      if(results != null){
        VendorCategoriesResponse responseModel = VendorCategoriesResponse.fromJson(results);
        log(tag + "hitCategoriesApi Response : " + json.encode(responseModel));
        if(responseModel.status == 200){
          if(responseModel.payload != null){
            categoriesData.clear();
            categoriesData = responseModel.payload!;
            refreshPage.call();
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
      log(tag + "hitCategoriesApi Exception " + exception.toString());
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