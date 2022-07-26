import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/login_ask_dialog.dart';
import 'package:door_ap/common/helperclass/customdialog.dart';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/model/request/login_request.dart';
import 'package:door_ap/common/model/response/login_response.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/screen/customer_btm_screen.dart';
import 'package:door_ap/customer/screen/customer_main_screen.dart';
import 'package:door_ap/vendor/screen/vendor_home_screen.dart';
import 'package:door_ap/vendor/screen/venodr_profile_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  String tag = 'LoginController';
  late Function refreshPage;


  ///*
  ///
  TextEditingController emailEditController = TextEditingController();
  TextEditingController passwordEditController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool isEmailEmpty = false;
  bool isEmailValid = false;
  bool isPasswordEmpty = false;
  bool isPasswordObscure = true;

  String fcmToken = "";

  ///*
  ///
  ///
  void isDataValid(){
    if(emailEditController.text.isEmpty){
      isEmailEmpty = true;

    }else if(!EmailValidator.validate(emailEditController.text.trim())){
      isEmailValid = true;
      isEmailEmpty = false;

    }else if(passwordEditController.text.isEmpty){
      isPasswordEmpty = true;
      isEmailValid = false;
      isEmailEmpty = false;

    }else {
      hitLoginApi();
    }
  }

  ///*
  ///
  navigateToHomeScreen() {
    Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (context) => VendorHomeScreen()), (route) => false);
  }

  ///*
  ///
  void clearTextField() {
    emailEditController.clear();
    passwordEditController.clear();
    fcmToken = "";
  }


  ///*
  ///
  ///
  void setAllErrorToFalse() {
    isEmailEmpty = false;
    isEmailValid = false;
    isPasswordEmpty = false;
  }

  ///*
  ///
  ///
  void hitLoginApi() async{
    LoginRequest requestModel = LoginRequest();
    requestModel.email = emailEditController.text.trim();
    requestModel.password = passwordEditController.text;
    requestModel.firebaseToken = fcmToken;

    final results = await Request().requestPost(
        url: loginApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try {
      if (results != null) {
        LoginResponse responseModel = LoginResponse.fromJson(results);
        log(tag + "hitLoginApi Response : " + json.encode(responseModel));
        if (responseModel.status == 200) {
          if (responseModel.payload != null) {
            MySharedPreference.setString(MyConstants.keyName, responseModel.payload!.name);
            MySharedPreference.setString(MyConstants.keyEmail, responseModel.payload!.email);
            MySharedPreference.setInt(MyConstants.keyUserId, responseModel.payload!.id);
            MySharedPreference.setString(MyConstants.keyAccessToken, responseModel.payload!.apiToken!.access);
            MySharedPreference.setBool(MyConstants.keyIsProfileCompleted, responseModel.payload!.isProfileCreate!);

            if(responseModel.payload!.isVendor!){
              MySharedPreference.setString(MyConstants.keyVendor, "True");
            }else{
              MySharedPreference.setString(MyConstants.keyVendor, "False");
            }
            if(responseModel.payload!.isCustomer!){
              MySharedPreference.setString(MyConstants.keyCustomer, "True");
            }else{
              MySharedPreference.setString(MyConstants.keyCustomer, "False");
            }

            if(responseModel.payload!.isVendor! && responseModel.payload!.isCustomer! ){
              showDialog(
                  context: Get.context!,
                  builder: (BuildContext context1) => LoginAskDialog(
                      my_context: Get.context!,
                      vendorFunction: navigateVendorHome,
                      customerFunction: navigateCustomerHome) );

            }else if(responseModel.payload!.isVendor!){
              navigateVendorHome();
            }else{
              navigateCustomerHome();
            }
          }
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
      log(tag + "hitLoginApi Exception " + exception.toString());
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

  ///*
  ///
  ///
  navigateVendorHome() {
    MySharedPreference.setString(MyConstants.keyVendor, "True");
    MySharedPreference.setString(MyConstants.keyCustomer, "False");

    if(!MySharedPreference.getBool(MyConstants.keyIsProfileCompleted)){
      Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (context) => VendorProfileScreen()), (route) => false);
    }else{
      Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (context) => VendorHomeScreen()), (route) => false);
    }
  }

  ///*
  ///
  ///
  navigateCustomerHome() {
    MySharedPreference.setString(MyConstants.keyVendor, "False");
    MySharedPreference.setString(MyConstants.keyCustomer, "True");
    Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (context) => CustomerBtmScreen()), (route) => false);

  }
}