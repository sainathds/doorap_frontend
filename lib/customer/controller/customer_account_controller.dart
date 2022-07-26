import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/model/request/logout_request.dart';
import 'package:door_ap/common/model/response/logout_response.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/screen/login_screen.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerAccountController extends GetxController{


  String tag = 'CustomerAccountController';
  ///*
  ///
  ///
  void hitLogoutApi() async{
    LogoutRequest requestModel = LogoutRequest();
    requestModel.id = MySharedPreference.getInt(MyConstants.keyUserId);
    final results = await Request().requestPostWithHeader(
        url: logoutApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try {
      if (results != null) {
        LogoutResponse responseModel = LogoutResponse.fromJson(results);
        log(tag + "hitLoginApi Response : " + json.encode(responseModel));
        if (responseModel.status == 200) {
          MySharedPreference.logout();
          Navigator.pushAndRemoveUntil(
              Get.context!, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false );
        } else { // if error occur then msg is "Something went wrong or validation msg"
          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) =>
                OKDialog(
                  title: "",
                  descriptions: responseModel.msg!,
                  img: errorImage,
                  text: '',
                  key: null,
                ),
          );
        }
      }
    } catch (exception) {
      log(tag + "hitLogoutApi Exception " + exception.toString());
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            OKDialog(
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