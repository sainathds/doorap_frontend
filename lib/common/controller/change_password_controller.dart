import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/customdialog.dart';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/model/request/change_password_request.dart';
import 'package:door_ap/common/model/response/change_password_response.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController{
  String tag = 'ChangePasswordController';
  late Function refreshPage;

  ///*
  ///
  TextEditingController passwordEditController = TextEditingController();
  TextEditingController confirmPassEditController = TextEditingController();
  TextEditingController oldPassEditController = TextEditingController();


  bool isOldPassEmpty = false;
  bool isOldPassValid = false;

  bool isPasswordEmpty = false;
  bool isPasswordValid = false;
  bool isOldNewPassMatch = false;

  bool isConfirmPassEmpty = false;
  bool isConfirmPassValid = false;

  bool isPasswordObscure = true;
  bool isConfirmPassObscure = true;
  bool isOldPassObscure = true;

  ///*
  ///
  /// check validations for all field
  void isDataValid(){
    if(oldPassEditController.text.isEmpty){
      isOldPassEmpty = true;

    }else if(oldPassEditController.text.length < 6){
      isOldPassValid = true;
      isOldPassEmpty = false;

    } else if(passwordEditController.text.isEmpty){
      isPasswordEmpty = true;
      isOldPassEmpty = false;
      isOldPassValid = false;

    }else if(passwordEditController.text.length < 6) {
      isPasswordValid = true;
      isPasswordEmpty = false;
      isOldPassEmpty = false;
      isOldPassValid = false;

    }else if(oldPassEditController.text == passwordEditController.text){
      isOldNewPassMatch = true;
      isPasswordValid = false;
      isPasswordEmpty = false;
      isOldPassEmpty = false;
      isOldPassValid = false;

    }else if(confirmPassEditController.text.isEmpty){
      isConfirmPassEmpty = true;
      isPasswordValid = false;
      isPasswordEmpty = false;
      isOldNewPassMatch = false;
      isPasswordValid = false;
      isPasswordEmpty = false;
      isOldPassEmpty = false;
      isOldPassValid = false;


    }else if(confirmPassEditController.text != passwordEditController.text){
      isConfirmPassValid = true;
      isConfirmPassEmpty = false;
      isPasswordValid = false;
      isPasswordEmpty = false;
      isOldNewPassMatch = false;
      isPasswordValid = false;
      isPasswordEmpty = false;
      isOldPassEmpty = false;
      isOldPassValid = false;

    }else{
      hitChangePasswordApi();
    }
  }

  ///*
  ///
  /// use change_password/ Api to change Password
  void hitChangePasswordApi() async{
    ChangePasswordRequest requestModel = ChangePasswordRequest();
    requestModel.id = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.oldPassword = oldPassEditController.text;
    requestModel.newPassword = passwordEditController.text;


    final results = await Request().requestPostWithHeader(
        url: changePasswordApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try {
      if (results != null) {
        ChangePasswordResponse responseModel = ChangePasswordResponse.fromJson(results);
        log(tag + "hitChangePasswordApi Response : " + json.encode(responseModel));
        if (responseModel.status == 200) {
          if (responseModel.payload != null) {
            showDialog(
                context: Get.context!,
                builder: (BuildContext context1) => CustomDialog(
                    title: "Success",
                    description: responseModel.msg!,
                    my_context: Get.context!,
                    okBtnFunction: dismissDialog,
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
      log(tag + "hitChangePasswordApi Exception " + exception.toString());
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
  /// set all validations field to false
  void setAllErrorToFalse() {
    isOldPassEmpty = false;
    isOldPassValid = false;
    isPasswordEmpty = false;
    isPasswordValid = false;
    isOldNewPassMatch = false;
    isConfirmPassEmpty = false;
    isConfirmPassValid = false;

  }

  ///*
  ///clear all editController
  void clearTextField() {
    passwordEditController.clear();
    confirmPassEditController.clear();
    oldPassEditController.clear();
  }



   ///*
  /// dismiss success dialog
  dismissDialog() {
    Navigator.pop(Get.context!);
  }
}