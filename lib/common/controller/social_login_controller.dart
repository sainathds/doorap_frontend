import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_ap/common/helperclass/login_ask_dialog.dart';
import 'package:door_ap/common/helperclass/customdialog.dart';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/model/other/firestore_user_model.dart';
import 'package:door_ap/common/model/request/login_request.dart';
import 'package:door_ap/common/model/request/social_login_request.dart';
import 'package:door_ap/common/model/response/login_response.dart';
import 'package:door_ap/common/model/response/social_login_response.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/firestore_constants.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/screen/customer_btm_screen.dart';
import 'package:door_ap/vendor/screen/vendor_home_screen.dart';
import 'package:door_ap/vendor/screen/venodr_profile_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class SocialLoginController extends GetxController{

  String tag = 'SocialLoginController';
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
  String loginId = "";
  String loginType = "";
  String email = "";
  String password = "";


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
  /// clear all editingController
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
  /// logIn user using social_login/ Api
  void hitLoginApi() async{
    SocialLoginRequest requestModel = SocialLoginRequest();
    requestModel.email = email;
    requestModel.password = password;
    requestModel.firebaseToken = fcmToken;
    requestModel.loginId = loginId;
    requestModel.loginType = loginType;

    final results = await Request().requestPost(
        url: loginApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try {
      if (results != null) {
        SocialLoginResponse responseModel = SocialLoginResponse.fromJson(results);
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


            //if user registered as Vendor AND customer then
            //ask user to select UserRole either Vendor Or Customer
            //vendorFunction call navigateVendorHome()
            //customerFunction call navigateCustomerHome()
            if(responseModel.payload!.isVendor! && responseModel.payload!.isCustomer! ){
              showDialog(
                  context: Get.context!,
                  builder: (BuildContext context1) => LoginAskDialog(
                      my_context: Get.context!,
                      vendorFunction: navigateVendorHome,
                      customerFunction: navigateCustomerHome) );

            }else if(responseModel.payload!.isVendor!){
              //if user only registered as vendor
              navigateVendorHome();
            }else{
              //else user only registered as customer
              navigateCustomerHome();
            }
          }
        } else { 
          // Navigator.pop(Get.context!);
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
      // Navigator.pop(Get.context!);
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
  /// update user Role status in sharedPreference
  navigateVendorHome() {
    MySharedPreference.setString(MyConstants.keyVendor, "True");
    MySharedPreference.setString(MyConstants.keyCustomer, "False");
    updateFirebaseUser();
  }

  ///*
  ///
  /// update user Role status in sharedPreference
  navigateCustomerHome() {
    MySharedPreference.setString(MyConstants.keyVendor, "False");
    MySharedPreference.setString(MyConstants.keyCustomer, "True");
    updateFirebaseUser();
  }


  ///*
  ///
  ///get userData against registered email
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
  /// update UserData against userId in firebase
  void updateFirebaseUser() async{
    final ProgressDialog _progressDialog = ProgressDialog(context: Get.context);

    _progressDialog.show(
      msg: "Please wait...",
      max: 100,
      progressBgColor: Colors.yellow,
      backgroundColor: MyColor.themeBlue,
      msgColor: Colors.white,
      msgFontSize: MyDimens.textSize18,
      msgFontWeight: FontWeight.bold,);


    String? fbUserId = await getFirebaseUserData(); //get firebaseUserId against registered email

    if(fbUserId != null){
      FirebaseFirestore.instance
          .collection(FirestoreConstants.pathUsersCollection)
          .doc(fbUserId)
          .update({
        FirestoreConstants.fcmToken  : fcmToken,
        FirestoreConstants.isVendor  : MySharedPreference.getString(MyConstants.keyVendor),
        FirestoreConstants.isCustomer  : MySharedPreference.getString(MyConstants.keyCustomer),

      }).whenComplete(() {
        Navigator.pop(Get.context!);
        log(tag + ' Firestore updateFirebaseUser Updated');

        if(MySharedPreference.getString(MyConstants.keyVendor) == "True"){
          if(!MySharedPreference.getBool(MyConstants.keyIsProfileCompleted)){
            Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (context) => VendorProfileScreen()), (route) => false);
          }else{
            Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (context) => VendorHomeScreen()), (route) => false);
          }
        }else{

          Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (context) => CustomerBtmScreen()), (route) => false);

        }
      }).catchError((onError) => log(tag + ' Firestore updateFirebaseUser Exception : ' + onError.toString()));
    }
  }

}