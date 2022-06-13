import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/model/request/vendor_availability_request.dart';
import 'package:door_ap/vendor/model/request/vendor_view_profile_request.dart';
import 'package:door_ap/vendor/model/response/vendor_availability_response.dart';
import 'package:door_ap/vendor/model/response/vendor_view_profile_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorHomeController extends GetxController{

  String tag = "VendorHomeController";
  late Payload payload = Payload();
  late Function refreshPage;
  String cityName = "";
  String fullAddress = "";
  bool isAvailable = false;
  String? isApproved = "false";
  bool? isServiceCreated = false;


  ///*
  ///
  ///
  void hitViewProfileApi() async{

    log("EMAIL_ID: " +  MySharedPreference.getString(MyConstants.keyEmail));
    log("USER_ID: " +  MySharedPreference.getInt(MyConstants.keyUserId).toString());

    VendorViewProfileRequest requestModel = VendorViewProfileRequest();
    requestModel.id = MySharedPreference.getInt(MyConstants.keyUserId);

    final results = await Request().requestPostWithHeader(
        url: vendorViewProfileApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{

      if(results != null){
        VendorViewProfileResponse responseModel = VendorViewProfileResponse.fromJson(results);
        log(tag + "hitViewProfileApi Response : " + json.encode(responseModel));

        if(responseModel.status == 200){
          if(responseModel.payload != null){
            payload = responseModel.payload![0];
            cityName = payload.fkCityCityName!;
            fullAddress = payload.googleAddress!.toString();
            isAvailable = payload.isAvailable!;
            isServiceCreated = payload.isServiceCreated!;
            isApproved = responseModel.isApprove!;
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
      log(tag + "hitGetOtpApi Exception " + exception.toString());
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
  void hitSetAvailabilityApi() async{
    VendorAvailabilityRequest requestModel = VendorAvailabilityRequest();
    requestModel.id = MySharedPreference.getInt(MyConstants.keyUserId);
    if(isAvailable){
      requestModel.isAvailable = "True";
    }else{
      requestModel.isAvailable = "False";
    }

    final results = await Request().requestPostWithHeader(
        url: vendorSetAvailabilityApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        VendorAvailabilityResponse responseModel = VendorAvailabilityResponse.fromJson(results);
        log(tag + "hitSetAvailabilityApi Response : " + json.encode(responseModel));

        if(responseModel.status == 200){
          hitViewProfileApi();
          refreshPage.call();

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
      log(tag + "hitSetAvailabilityApi Exception " + exception.toString());
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