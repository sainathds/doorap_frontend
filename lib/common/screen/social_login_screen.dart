import 'dart:developer';
import 'dart:io';

import 'package:door_ap/common/controller/login_controller.dart';
import 'package:door_ap/common/controller/social_login_controller.dart';
import 'package:door_ap/common/helperclass/ask_dialog.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/screen/social_signup_screen.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import 'forgot_password_screen.dart';

class SocialLoginScreen extends StatefulWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);

  @override
  _SocialLoginScreenState createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> {

  SocialLoginController _getXController = Get.put(SocialLoginController());
  final _androidAppRetain = const MethodChannel("android_app_retain");
  GoogleSignIn? googleSignIn;
  late ProgressDialog _progressDialog ;



  @override
  void initState() {
    // TODO: implement initState

    _progressDialog = ProgressDialog(context: context);

    _getXController.loginType = "";
    _getXController.loginId = "";

    /// initialize GoogleSignIn
    /// https://www.googleapis.com/auth/userinfo.profile google api
    googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    );

    _getXController.refreshPage = refreshPage;
    _getXController.clearTextField();

    MySharedPreference.getInstance(); //get SharedPreference instance

    //get firebase instance to get FCM token
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance ;
    _firebaseMessaging.getToken().then((token){
      log("LOGIN_FCM_TOKEN :" + token!);
      _getXController.fcmToken = token;
    });
    super.initState();
  }

  ///*
  ///
  ///
  refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(left: 23.0, right: 23.0),
            child: Column(
              children: [

                // title
                Padding(
                  padding: const EdgeInsets.only(top: 42.0,),
                  child: Row(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: [
                      // Image(image: appLogo, width: 54.0, height: 54.0,),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Text(MyString.loginToDoorap!,
                          style: const TextStyle(
                              fontSize: MyDimens.textSize26,
                              color: MyColor.themeBlue,
                              fontFamily: 'roboto_bold'
                          ),),
                      )
                    ],
                  ),
                ),



                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: emailIdField(),
                        ),

                        //password
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: passwordField(),
                        ),

                        //forgot password text
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 17.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(MyString.forgotPassword!,
                                  style: const TextStyle(
                                      fontSize: MyDimens.textSize13,
                                      color: MyColor.labelGrey,
                                      fontFamily: 'sf_pro_regular'
                                  ),)
                              ],
                            ),
                          ),
                        ),

                        ///*
                        /// button
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 29.0),
                          child: ElevatedButton(
                              onPressed: (){
                                _getXController.email = _getXController.emailEditController.text.trim().toString();
                                _getXController.password = _getXController.passwordEditController.text.toString();;
                                _getXController.loginId = "";
                                _getXController.loginType = "";
                                _getXController.isDataValid();
                                refreshPage();
                              },
                              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),),
                                  elevation: 5),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(/*MyString.login!*/ "Log In",
                                  style: const TextStyle(
                                      fontSize: MyDimens.textSize16,
                                      color: Colors.white,
                                      fontFamily: 'sf_pro_bold'
                                  ),),
                              )),
                        ),


                        //or login email
                        if(Platform.isAndroid)
                        Padding(
                          padding: const EdgeInsets.only(top: 46.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(height: 2, color: MyColor.lightBgGrey,)),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                                child: Text("Or Login With", style: const TextStyle(fontSize: MyDimens.textSize11, color: MyColor.labelGrey, fontFamily: 'sf_pro_regular'), ),
                              ),

                              Expanded(
                                  flex: 1,
                                  child: Container(height: 2, color: MyColor.lightBgGrey,)),

                            ],
                          ),
                        ),

                        // icon
                        if(Platform.isAndroid)
                        Padding(
                          padding: const EdgeInsets.only(top: 34.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                socialIconWidget(googleIcon),
                              
                              /*Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: socialIconWidget(fbIcon),
                              ),

                              socialIconWidget(appleIcon),*/

                            ],
                          ),
                        )
                        else 
                          SizedBox(height: MediaQuery.of(context).size.height * 0.15),




                        //signup text
                        Padding(
                          padding: const EdgeInsets.only(top: 23.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(MyString.newToDoorap!,
                                style: const TextStyle(
                                    fontSize: MyDimens.textSize15,
                                    color: MyColor.fieldGrey,
                                    fontFamily: 'sf_pro_regular'
                                ),),


                              InkWell(
                                onTap: (){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SocialSignupScreen()), (route) => false);
                                  },
                                child: Text(MyString.signup!,
                                  style: TextStyle(
                                      fontSize: MyDimens.textSize15,
                                      color: MyColor.themeBlue,
                                      fontFamily: 'sf_pro_bold'
                                  ),),
                              )
                            ],
                          ),
                        ),


                        //bottom logo
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Image(image: bottomLogo, height: 70,),
                        )

                      ],),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  ///*
  ///
  Widget emailIdField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllErrorToFalse();
        });
      },
      controller: _getXController.emailEditController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: _getXController.emailFocus,
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        border: OutlineInputBorder(),
        labelText: "EMAIL",
        labelStyle: labelStyle(),
        hintText: MyString.enterYourEmail,
        errorText: _getXController.isEmailEmpty ? "Please Enter Email" : _getXController.isEmailValid ? "Please Enter Valid Email" : null ,

      ),
    );
  }

  ///*
  ///
  Widget passwordField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllErrorToFalse();
        });
      },
      controller: _getXController.passwordEditController,
      keyboardType: TextInputType.text,
      obscureText: _getXController.isPasswordObscure,
      textInputAction: TextInputAction.next,
      focusNode: _getXController.passwordFocus,
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        border: OutlineInputBorder(),
        labelText: "PASSWORD",
        labelStyle: labelStyle(),
        hintText: MyString.enterPassword,
        suffixIcon: IconButton(
          icon: Icon(
            _getXController.isPasswordObscure
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded,
          ),
          onPressed: () {
            setState(() {
              _getXController.isPasswordObscure = !_getXController.isPasswordObscure;
            });
          },
        ),
        errorText: _getXController.isPasswordEmpty ? "Please Enter Password" : null ,

      ),
    );
  }


  ///*
  ///
  TextStyle fieldStyle(){
    return const TextStyle(
        fontSize: MyDimens.textSize14,
        color: MyColor.fieldGrey,
        fontFamily: 'sf_pro_regular'
    );
  }

  ///*
  ///
  TextStyle labelStyle(){
    return const TextStyle(
        fontSize: MyDimens.textSize10,
        color: MyColor.labelGrey,
        fontFamily: 'sf_pro_semibold'
    );
  }

  ///*
  ///
  ///
  Widget socialIconWidget(AssetImage icon) {
    return InkWell(
      onTap: (){
        setState(() {
          _getXController.emailEditController.clear();
          _getXController.passwordEditController.clear();
        });
        googleLogin();
      },
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(34.0),
        ),
        child: Container(
            width: 68,
            height: 68,
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Image(image: icon,),
            )),
      ),
    );

  }

  ///*
  ///
  ///
  Future<bool> _onWillPop() async{

    showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => AskDialog(
            my_context: Get.context!,
            msg: "Do you want to Exit ?",
            yesFunction: yesFunction,
            noFunction: noFunction));

    return false;
  }


  ///*
  ///
  ///
  Future<bool> yesFunction(){
    if (Platform.isAndroid) {
      if (Navigator.of(context).canPop()) {
        return Future.value(true);
      } else {
        _androidAppRetain.invokeMethod("sendToBackground");
        return Future.value(false);
      }
    } else {
      return Future.value(true);
    }

  }


  ///*
  ///
  ///
  void noFunction(){
    Navigator.pop(Get.context!);
  }


  ///*
  ///
  /// get popup with all google accounts
  /// and after select one of them will get data of that account
  Future<void> googleLogin() async {
    try {
      showProgressBar();
      googleSignIn!.disconnect(); //use to signout

      GoogleSignInAccount? googleAccount = await googleSignIn!.signIn();
      if(googleAccount != null){
        hideProgressBar();

        log("Result : " + googleAccount.email.toString());
        log("Result : " + googleAccount.id.toString());
        log("Result : " + googleAccount.displayName.toString());
        log("Result : " + googleAccount.photoUrl.toString());

        _getXController.email = googleAccount.email.toString();
        _getXController.password = "";
        _getXController.loginId = googleAccount.id.toString();
        _getXController.loginType = "Google";
        
        _getXController.hitLoginApi();
      }else{
        hideProgressBar();
        log("googleLogin : googleAccount is empty");
      }
    } catch (error) {
      log("googleLogin Exception :" + error.toString());
    }
  }



  ///*
  ///
  ///
  showProgressBar(){
    _progressDialog.show(
      msg: "Please wait...",
      max: 100,
      progressBgColor: Colors.yellow,
      backgroundColor: MyColor.themeBlue,
      msgColor: Colors.white,
      msgFontSize: MyDimens.textSize18,
      msgFontWeight: FontWeight.bold,);

  }

  ///*
  ///
  ///
  hideProgressBar(){
    Navigator.pop(context);
  }

}
