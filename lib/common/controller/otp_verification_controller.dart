import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/model/other/firebase_user_model.dart';
import 'package:door_ap/common/model/request/get_otp_request.dart';
import 'package:door_ap/common/model/request/signup_request.dart';
import 'package:door_ap/common/model/response/get_otp_response.dart';
import 'package:door_ap/common/model/response/signup_response.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/screen/create_new_pass_screen.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/screen/customer_btm_screen.dart';
import 'package:door_ap/customer/screen/customer_main_screen.dart';
import 'package:door_ap/vendor/screen/venodr_profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController {

  String tag = "OtpVerificationController";
  String callFrom = '';
  String enteredOtp = "";

  ///*
  ///
  void isDataValid() {
    if (MySharedPreference.getString(MyConstants.keyResponseOtp) !=
        enteredOtp) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            OKDialog(
              title: "",
              descriptions: "Enter Valid Otp",
              img: errorImage,
              text: '',
              key: null,
            ),
      );
    } else {
      if (callFrom == "signup") {
        hitSignupApi();
      } else {
        navigateToCreateNewPass();
      }
    }
  }

  ///*
  ///
  ///
  void hitSignupApi() async {
    SignupRequest requestModel = SignupRequest();
    requestModel.name = MySharedPreference.getString(MyConstants.keyName);
    requestModel.email = MySharedPreference.getString(MyConstants.keyEmail);
    requestModel.password = MySharedPreference.getString(MyConstants.keyPassword);
    requestModel.firebaseToken = MySharedPreference.getString(MyConstants.keyFcmToken);
    requestModel.isVendor = MySharedPreference.getString(MyConstants.keyVendor);
    requestModel.isCustomer = MySharedPreference.getString(MyConstants.keyCustomer);

    final results = await Request().requestPost(
        url: signupApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try {
      if (results != null) {
        SignupResponse responseModel = SignupResponse.fromJson(results);
        log(tag + "hitSignupApi Response : " + json.encode(responseModel));
        if (responseModel.status == 200) {
          if (responseModel.payload != null) {
            MySharedPreference.setInt(MyConstants.keyUserId, responseModel.payload!.id);
            MySharedPreference.setString(MyConstants.keyAccessToken, responseModel.payload!.apiToken!.access);

            //create user in firebase
            createFirebaseUser();

            // if(MySharedPreference.getString(MyConstants.keyVendor) == "True"){
            //   navigateToProfile(); //vendorProfile
            // }else{
            //   navigateToCustHome();
            // }
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
      log(tag + "hitSignupApi Exception " + exception.toString());
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
  /// use to resend otp for signup
  void hitGetOtpApi() async {
    GetOtpRequest requestModel = GetOtpRequest();
    requestModel.email = MySharedPreference.getString(MyConstants.keyEmail);

    final results = await Request().requestPost(
        url: getOtpApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try {
      if (results != null) {
        GetOtpResponse responseModel = GetOtpResponse.fromJson(results);
        log(tag + "hitGetOtpApi Response : " + responseModel.toString());
        if (responseModel.status == 200) {
          if (responseModel.payload != null) {
            MySharedPreference.setString(MyConstants.keyResponseOtp,
                responseModel.payload!.otp.toString());
            showDialog(
              context: Get.context!,
              builder: (BuildContext context1) =>
                  OKDialog(
                    title: "Success",
                    descriptions: responseModel.msg!,
                    img: successImage,
                    text: '',
                    key: null,
                  ),
            );
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
      log(tag + "hitGetOtpApi Exception " + exception.toString());
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
  /// use to resend otp for ForgotPassword
  void hitForgotPasswordOtpApi() async {
    GetOtpRequest requestModel = GetOtpRequest();
    requestModel.email = MySharedPreference.getString(MyConstants.keyEmail);

    final results = await Request().requestPost(
        url: forgotPasswordOtpApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try {
      if (results != null) {
        GetOtpResponse responseModel = GetOtpResponse.fromJson(results);
        log(tag + "hitForgotPasswordOtpApi Response : " + responseModel.toString());
        if (responseModel.status == 200) {
          if (responseModel.payload != null) {
            MySharedPreference.setString(MyConstants.keyResponseOtp, responseModel.payload!.otp.toString());
            showDialog(
              context: Get.context!,
              builder: (BuildContext context1) =>
                  OKDialog(
                    title: "Success",
                    descriptions: responseModel.msg!,
                    img: successImage,
                    text: '',
                    key: null,
                  ),
            );
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
      log(tag + "hitForgotPasswordOtpApi Exception " + exception.toString());
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
  void navigateToCreateNewPass() {
    Navigator.push(Get.context!,
        MaterialPageRoute(builder: (context) => CreateNewPassScreen()));
  }


  ///*
  ///
  ///
  void navigateToProfile() {
    Navigator.pushAndRemoveUntil(Get.context!,
        MaterialPageRoute(builder: (context) => VendorProfileScreen()), (
            route) => false);
  }

  ///*
  ///
  ///
  void navigateToCustHome() {
    Navigator.pushAndRemoveUntil(Get.context!,
        MaterialPageRoute(builder: (context) => CustomerBtmScreen()), (
            route) => false);
  }

  void dismissDialog() {
    Navigator.pop(Get.context!);
  }

  ///*
  ///
  ///
  void createFirebaseUser() async{
    FirebaseFirestore.instance
        .collection(MyConstants.pathUsers)
        .doc()
        .set({
         MyConstants.userId : MySharedPreference.getInt(MyConstants.keyUserId).toString(),
         MyConstants.email : MySharedPreference.getString(MyConstants.keyEmail),
         MyConstants.name  : MySharedPreference.getString(MyConstants.keyName),
         MyConstants.fcmToken  : MySharedPreference.getString(MyConstants.fcmToken),
         MyConstants.isVendor  : MySharedPreference.getString(MyConstants.keyVendor),
         MyConstants.isCustomer  : MySharedPreference.getString(MyConstants.keyCustomer),

    }).then((value) {
      log(tag + 'Firestore createFirebaseUser Success');
      if(MySharedPreference.getString(MyConstants.keyVendor) == "True"){
        navigateToProfile(); //vendorProfile
      }else{
        navigateToCustHome();
      }

    }).catchError((onError) => log(tag + 'Firestore createFirebaseUser Exception : ' + onError.toString()) );


  }

  ///*
  ///
  ///
  Future<FirebaseUserModel?> getFirebaseUserData() async{
    FirebaseUserModel? fbUserModel;

    //get user
    QuerySnapshot userData = await FirebaseFirestore.instance
        .collection('Users')
        .where('Email', isEqualTo: MySharedPreference.getString(MyConstants.keyEmail))
        .get();

    if(userData != null){
      for (QueryDocumentSnapshot document in userData.docs) {
        fbUserModel = FirebaseUserModel();
        fbUserModel.firebaseUserId = document.id;
      }
    }

    return fbUserModel;
  }

}