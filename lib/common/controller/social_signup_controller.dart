import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_ap/common/helperclass/ask_dialog.dart';
import 'package:door_ap/common/helperclass/customdialog.dart';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/model/other/firestore_user_model.dart';
import 'package:door_ap/common/model/request/get_otp_request.dart';
import 'package:door_ap/common/model/request/signup_request.dart';
import 'package:door_ap/common/model/request/social_get_otp_request.dart';
import 'package:door_ap/common/model/request/social_signup_request.dart';
import 'package:door_ap/common/model/response/signup_response.dart';
import 'package:door_ap/common/model/response/social_get_otp_response.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/screen/otp_verification_screen.dart';
import 'package:door_ap/common/screen/social_otp_verification_screen.dart';
import 'package:door_ap/common/utils/firestore_constants.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/screen/customer_btm_screen.dart';
import 'package:door_ap/customer/screen/customer_main_screen.dart';
import 'package:door_ap/vendor/screen/venodr_profile_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialSignupController extends GetxController{

  String tag = "SocialSignupController";
  late Function refreshPage;

  ///*
  ///User Details
  TextEditingController nameEditController = TextEditingController();
  TextEditingController emailEditController = TextEditingController();
  TextEditingController passwordEditController = TextEditingController();
  String isCustomer = "True";
  String isVendor = "False";

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool isNameEmpty = false;
  bool isEmailEmpty = false;
  bool isEmailValid = false;
  bool isPasswordEmpty = false;
  bool isPasswordValid = false;

  bool isPasswordObscure = true;
  bool isChecked = false;

  bool isSocialSignIn = false;
  String loginId = "";
  String loginType = "";

  ///*
  ///
  ///
  void isDataValid(){
    if(nameEditController.text.isEmpty){
      isNameEmpty = true;

    }else if(emailEditController.text.isEmpty){
      isEmailEmpty = true;
      isNameEmpty = false;

    }else if(!EmailValidator.validate(emailEditController.text.trim())){
      isEmailValid = true;
      isEmailEmpty = false;
      isNameEmpty = false;

    }else if(!isSocialSignIn && passwordEditController.text.isEmpty){
      isPasswordEmpty = true;
      isEmailValid = false;
      isEmailEmpty = false;
      isNameEmpty = false;

    }else if(!isSocialSignIn && passwordEditController.text.length < 6){
      isPasswordValid = true;
      isPasswordEmpty = false;
      isEmailValid = false;
      isEmailEmpty = false;
      isNameEmpty = false;

    }else{
      hitGetOtpApi();
    }
  }


  ///*
  ///
  navigateToOtpScreen() {
    Navigator.push(Get.context!, MaterialPageRoute(builder: (context){
      return SocialOtpVerificationScreen(callFrom: 'signup');
    }));
  }



  ///*
  ///
  ///
  void setAllErrorToFalse() {
    isNameEmpty = false;
    isEmailEmpty = false;
    isEmailValid = false;
    isPasswordEmpty = false;
    isPasswordValid = false;

  }

  ///*
  ///
  ///
  void clearTextField() {
    nameEditController.clear();
    emailEditController.clear();
    passwordEditController.clear();
  }

  ///*
  ///
  ///
  void hitGetOtpApi() async{
    SocialGetOtpRequest requestModel = SocialGetOtpRequest();
    requestModel.email = emailEditController.text.trim();

    final results = await Request().requestPost(
        url: getOtpApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        SocialGetOtpResponse responseModel = SocialGetOtpResponse.fromJson(results);
        log(tag + "hitGetOtpApi Response : " + responseModel.toString());
        if(responseModel.status == 200){
          if(responseModel.payload != null){
            MySharedPreference.setString(MyConstants.keyName, nameEditController.text);
            MySharedPreference.setString(MyConstants.keyEmail, emailEditController.text.trim());

            if(responseModel.payload!.otp != 0){
              MySharedPreference.setString(MyConstants.keyPassword, passwordEditController.text);
              MySharedPreference.setString(MyConstants.keyResponseOtp, responseModel.payload!.otp.toString());
              MySharedPreference.setString(MyConstants.keyVendor, isVendor);
              MySharedPreference.setString(MyConstants.keyCustomer, isCustomer);
              MySharedPreference.setString(MyConstants.keyLoginId, loginId);
              MySharedPreference.setString(MyConstants.keyLoginType, loginType);

              clearTextField();
              navigateToOtpScreen();
            }else{
              MySharedPreference.setString(MyConstants.keyPassword, "");
              MySharedPreference.setString(MyConstants.keyResponseOtp, "");
              MySharedPreference.setString(MyConstants.keyVendor, responseModel.payload!.isVendor);
              MySharedPreference.setString(MyConstants.keyCustomer, responseModel.payload!.isCustomer);
              MySharedPreference.setString(MyConstants.keyLoginId, responseModel.payload!.loginId);
              MySharedPreference.setString(MyConstants.keyLoginType, responseModel.payload!.loginType);
              log('Otp_Response Otp : ' + responseModel.payload!.otp.toString());
              log('Otp_Response LoginType : ' + responseModel.payload!.loginType.toString());

              showDialog(
                  context: Get.context!,
                  builder: (BuildContext context1) => AskDialog(
                      my_context: Get.context!,
                      msg: responseModel.payload!.signupMsg!,
                      yesFunction: yesFunction,
                      noFunction: noFunction));
            }
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


  ///*
  ///
  ///
  noFunction() {
    Navigator.pop(Get.context!);
  }

  ///*
  ///
  ///
  yesFunction() {
    if(MySharedPreference.getString(MyConstants.keyVendor) == "True"){
      MySharedPreference.setString(MyConstants.keyVendor, "False");
      MySharedPreference.setString(MyConstants.keyCustomer, "True");
    }else{
      MySharedPreference.setString(MyConstants.keyVendor, "True");
      MySharedPreference.setString(MyConstants.keyCustomer, "False");
    }
    hitSignupApi();
  }

  ///*
  ///
  ///
  void hitSignupApi() async {
    SocialSignupRequest requestModel = SocialSignupRequest();
    requestModel.name = MySharedPreference.getString(MyConstants.keyName);
    requestModel.email = MySharedPreference.getString(MyConstants.keyEmail);
    requestModel.password = MySharedPreference.getString(MyConstants.keyPassword);
    requestModel.firebaseToken = MySharedPreference.getString(MyConstants.keyFcmToken);
    requestModel.isVendor = MySharedPreference.getString(MyConstants.keyVendor);
    requestModel.isCustomer = MySharedPreference.getString(MyConstants.keyCustomer);
    requestModel.loginId = MySharedPreference.getString(MyConstants.keyLoginId);
    requestModel.loginType = MySharedPreference.getString(MyConstants.keyLoginType);


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
            updateFirebaseUser();
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
  ///
  Future<String?> getFirebaseUserData() async{
    String? fbUserId;

    //get user
    QuerySnapshot userData = await FirebaseFirestore.instance
        .collection('Users')
        .where(FirestoreConstants.email, isEqualTo: MySharedPreference.getString(MyConstants.keyEmail))
        .get();

    if(userData != null){
      for (QueryDocumentSnapshot document in userData.docs) {
        fbUserId = document.id;
      }
    }
    return fbUserId;
  }

  ///*
  ///
  ///
  void updateFirebaseUser() async{
    String? fbUserId = await getFirebaseUserData();

    if(fbUserId != null){
      FirebaseFirestore.instance
          .collection(FirestoreConstants.pathUsersCollection)
          .doc(fbUserId)
          .update({
        FirestoreConstants.fcmToken  : MySharedPreference.getString(MyConstants.keyFcmToken),
        FirestoreConstants.isVendor  : MySharedPreference.getString(MyConstants.keyVendor),
        FirestoreConstants.isCustomer  : MySharedPreference.getString(MyConstants.keyCustomer),

      }).whenComplete(() {
        log(tag + ' Firestore updateFirebaseUser Updated');
        if(MySharedPreference.getString(MyConstants.keyVendor) == "True"){
          navigateToProfile(); //vendorProfile
        }else{
          navigateToCustHome();
        }
      }).catchError((onError) => log(tag + ' Firestore updateFirebaseUser Exception : ' + onError.toString()));
    }
  }

}