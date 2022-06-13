import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/customdialog.dart';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/screen/otp_verification_screen.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/model/request/venor_add_account_request.dart';
import 'package:door_ap/vendor/model/response/vendor_add_account_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorBankAccountController extends GetxController{

  String tag = "VendorBankAccountController";
  TextEditingController accountNoEditController = TextEditingController();
  TextEditingController confirmAccNoEditController = TextEditingController();
  TextEditingController holderNameEditController = TextEditingController();
  TextEditingController ifscCodeEditController = TextEditingController();

  FocusNode accountNoFocus = FocusNode();
  FocusNode confirmAccNoFocus = FocusNode();
  FocusNode holderNameFocus = FocusNode();
  FocusNode ifscCodeFocus = FocusNode();

  bool isAccountNoEmpty = false;
  bool isConfirmAccNoEmpty = false;
  bool isConfirmAccNoValid = false;
  bool isHolderNameEmpty = false;
  bool isIfscCodeEmpty = false;


  ///*
  ///
  void clearTextField(){
    accountNoEditController.clear();
    confirmAccNoEditController.clear();
    holderNameEditController.clear();
    ifscCodeEditController.clear();
  }

  ///*
  ///
  void setAllFieldToFalse(){
     isAccountNoEmpty = false;
     isConfirmAccNoEmpty = false;
     isConfirmAccNoValid = false;
     isHolderNameEmpty = false;
     isIfscCodeEmpty = false;
  }

  ///*
  ///
  void isBankDataValid(){
    if(accountNoEditController.text.isEmpty){
      isAccountNoEmpty = true;

    }else if(confirmAccNoEditController.text.isEmpty){
      isConfirmAccNoEmpty = true;
      isAccountNoEmpty = false;

    }else if(confirmAccNoEditController.text != accountNoEditController.text){
      isConfirmAccNoValid = true;
      isConfirmAccNoEmpty = false;
      isAccountNoEmpty = false;

    }else if(holderNameEditController.text.isEmpty){
      isHolderNameEmpty = true;
      isConfirmAccNoValid = false;
      isConfirmAccNoEmpty = false;
      isAccountNoEmpty = false;

    }else if(ifscCodeEditController.text.isEmpty){
      isIfscCodeEmpty = true;
      isHolderNameEmpty = false;
      isConfirmAccNoValid = false;
      isConfirmAccNoEmpty = false;
      isAccountNoEmpty = false;

    }else{
      hitAddAccountApi();
    }
  }


  ///*
  ///
  ///
  void hitAddAccountApi() async{
    VendorAddAccountRequest requestModel = VendorAddAccountRequest();
    requestModel.id = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.accountNo = int.parse(accountNoEditController.text);
    requestModel.accountHolderName = holderNameEditController.text;
    requestModel.ifscCode = ifscCodeEditController.text;

    final results = await Request().requestPostWithHeader(
        url: vendorAddBankAccountApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        VendorAddAccountResponse responseModel = VendorAddAccountResponse.fromJson(results);
        log(tag + "hitAddAccountApi Response : " + json.encode(responseModel));

        if(responseModel.status == 200){
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => CustomDialog(
              title: "Success",
              description: responseModel.msg!,
              my_context: Get.context!,
              okBtnFunction: navigateToHomeScreen,
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
      log(tag + "hitAddAccountApi Exception " + exception.toString());
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
  void navigateToHomeScreen() {
    Navigator.pop(Get.context!);
  }



}