import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/model/request/forgot_password_otp_request.dart';
import 'package:door_ap/common/model/response/forgot_password_otp_response.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/screen/otp_verification_screen.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController{

  String tag = "ForgotPasswordController";
  TextEditingController emailEditController = TextEditingController();
  bool isEmailEmpty = false;
  bool isEmailValid = false;

  ///*
  ///
  void isDataValid(){
    if(emailEditController.text.isEmpty){
      isEmailEmpty = true;

    }else if(!EmailValidator.validate(emailEditController.text.trim())){
      isEmailValid = true;
      isEmailEmpty = false;

    }else {
      hitForgotPasswordOtpApi();
    }
  }


  ///*
  ///
  ///
  void hitForgotPasswordOtpApi() async{
    ForgotPasswordOtpRequest requestModel = ForgotPasswordOtpRequest();
    requestModel.email = emailEditController.text.trim();

    final results = await Request().requestPost(
        url: forgotPasswordOtpApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        ForgotPasswordOtpResponse responseModel = ForgotPasswordOtpResponse.fromJson(results);
        log(tag + "hitForgotPasswordOtpApi Response : " + json.encode(responseModel));
        if(responseModel.status == 200){
          if(responseModel.payload != null){
            MySharedPreference.setString(MyConstants.keyResponseOtp, responseModel.payload!.otp.toString());
            MySharedPreference.setString(MyConstants.keyEmail, emailEditController.text.trim());
            MySharedPreference.setInt(MyConstants.keyUserId, responseModel.payload!.id);
            navigateToOtpScreen();
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
      log(tag + "hitForgotPasswordOtpApi Exception " + exception.toString());
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
  void navigateToOtpScreen() {
    Navigator.push(Get.context!, MaterialPageRoute(builder: (context) => OtpVerificationScreen(callFrom: 'forgotPassword')));
  }

  ///*
  ///
  void setAllErrorToFalse() {
    isEmailEmpty = false;
    isEmailValid = false;

  }

  ///*
  ///
  void clearField() {
    emailEditController.clear();
  }

}