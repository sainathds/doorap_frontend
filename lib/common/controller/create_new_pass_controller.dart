import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/customdialog.dart';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/model/request/forgot_password_request.dart';
import 'package:door_ap/common/model/response/forgot_password_response.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/screen/social_login_screen.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewPassController extends GetxController{

  String tag = 'CreateNewPassController';
  late Function refreshPage;

  ///*
 ///
  TextEditingController passwordEditController = TextEditingController();
  TextEditingController confirmPassEditController = TextEditingController();

  bool isPasswordEmpty = false;
  bool isPasswordValid = false;

  bool isConfirmPassEmpty = false;
  bool isConfirmPassValid = false;

  bool isPasswordObscure = true;
  bool isConfirmPassObscure = true;

  ///*
  ///
  /// check validations for all field
  void isDataValid(){

    if(passwordEditController.text.isEmpty){
      isPasswordEmpty = true;

    }else if(passwordEditController.text.length < 6){
      isPasswordValid = true;
      isPasswordEmpty = false;

    }else if(confirmPassEditController.text.isEmpty){
      isConfirmPassEmpty = true;
      isPasswordValid = false;
      isPasswordEmpty = false;

    }else if(confirmPassEditController.text != passwordEditController.text){
      isConfirmPassValid = true;
      isConfirmPassEmpty = false;
      isPasswordValid = false;
      isPasswordEmpty = false;

    }else{
      hitForgotPasswordApi();
    }
  }

  ///*
  ///
  /// create New password using forgot_password/ Api
  void hitForgotPasswordApi() async{
    ForgotPasswordRequest requestModel = ForgotPasswordRequest();
    requestModel.id = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.password = passwordEditController.text;

    final results = await Request().requestPost(
        url: forgotPasswordApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try {
      if (results != null) {
        ForgotPasswordResponse responseModel = ForgotPasswordResponse.fromJson(results);
        log(tag + "hitForgotPasswordApi Response : " + json.encode(responseModel));
        if (responseModel.status == 200) {
          if (responseModel.payload != null) {
            showDialog(
                context: Get.context!,
                builder: (BuildContext context1) => CustomDialog(
                    title: "Success",
                    description: responseModel.msg!,
                    my_context: Get.context!,
                    okBtnFunction: navigateToLoginScreen, //if password successfully changed then navigate to SocialLoginScreen
                    buttonText: "OK",
                    img: successImage
                ));
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
      log(tag + "hitForgotPasswordApi Exception " + exception.toString());
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
  navigateToLoginScreen() {
    Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (context) => SocialLoginScreen()), (route) => false);
  }

  ///*
  ///
  /// set All validations field to false
  void setAllErrorToFalse() {
    isPasswordEmpty = false;
    isPasswordValid = false;
    isConfirmPassEmpty = false;
    isConfirmPassValid = false;

  }

  ///*
  /// clear all editController
  void clearTextField() {
    passwordEditController.clear();
    confirmPassEditController.clear();
  }

}