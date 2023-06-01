import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:door_ap/common/controller/social_signup_controller.dart';
import 'package:door_ap/common/helperclass/ask_dialog.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/screen/social_login_screen.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sn_progress_dialog/progress_dialog.dart';


class SocialSignupScreen extends StatefulWidget {
  const SocialSignupScreen({Key? key}) : super(key: key);

  @override
  _SocialSignupScreenState createState() => _SocialSignupScreenState();
}

class _SocialSignupScreenState extends State<SocialSignupScreen> {

  SocialSignupController _getXController = Get.put(SocialSignupController());
  final _androidAppRetain = const MethodChannel("android_app_retain");

  late String fcmToken ;
  late ProgressDialog _progressDialog ;

  GoogleSignInAccount? googleCurrentUser;
  GoogleSignIn? googleSignIn;


  @override
  void initState() {
    // TODO: implement initState

    _getXController.isSocialSignIn = false;
    _getXController.loginType = "";
    _getXController.loginId = "";


    initSocialLogins();

    MySharedPreference.getInstance(); //get SharedPreference instance
    _getXController.refreshPage = refreshPage;
    _getXController.clearTextField();


    //get firebase instance to get FCM token
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance ;
    _firebaseMessaging.getToken().then((token){
      log("FCM_TOKEN :" + token!);
      fcmToken = token;
      MySharedPreference.setString(MyConstants.keyFcmToken, fcmToken);
    });

    //initialize progress dialog
    _progressDialog = ProgressDialog(context: context);
    super.initState();
  }

  ///*
  ///
  /// use to refresh page
  refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Container(
            child: Column(
              children: [

                // title
                Padding(
                  padding: const EdgeInsets.only(top: 20.0,),
                  child: Row(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: [
                      Image(image: appLogo, width: 54.0, height: 54.0,),
                      Padding(
                        padding: const EdgeInsets.only(left: 33.0),
                        child: Text(MyString.signupToDoorap!,
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
                  child: Container(
                    margin: const EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0,),
                    child: SingleChildScrollView(
                      child: Column(children: [

                        //full name
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: fullNameField(),
                        ),

                        //email
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: emailIdField(),
                        ),

                        //password
                        !_getXController.isSocialSignIn?
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: passwordField(),
                        ): SizedBox(),


                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: roleContainer(),
                        ),

                        //terms and conditions
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            children: [
                              InkWell(
                                  onTap:(){
                                    _getXController.isChecked = !_getXController.isChecked;
                                    refreshPage();
                                  },
                                  child: Icon(_getXController.isChecked? Icons.check_box_outlined :Icons.check_box_outline_blank)),

                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(MyString.iAcceptThe!, style: TextStyle(fontSize: MyDimens.textSize13, color: MyColor.labelGrey, fontFamily: 'sf_pro_regular'),),
                              ),

                              Text(MyString.termsAndConditions!, style: TextStyle(fontSize: MyDimens.textSize13, color: MyColor.fieldGrey, fontFamily: 'sf_pro_semibold'),),
                            ],
                          ),
                        ),

                        ///*
                        /// button
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 22.0),
                          child: ElevatedButton(
                              onPressed: (){
                                _getXController.isDataValid();
                                refreshPage();
                              },
                              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),),
                                  elevation: 5),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(MyString.createAnAccount!,
                                  style: const TextStyle(
                                      fontSize: MyDimens.textSize15,
                                      color: Colors.white,
                                      fontFamily: 'sf_pro_bold'
                                  ),),
                              )),
                        ),


                        //or login email
                        if(Platform.isAndroid)
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(height: 2, color: MyColor.lightBgGrey,)),
                              
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                                child: Text("Or Signup With", style: const TextStyle(fontSize: MyDimens.textSize11, color: MyColor.labelGrey, fontFamily: 'sf_pro_regular'),),
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
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              socialIconWidget(googleIcon, 'Google'),

/*
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: socialIconWidget(fbIcon, 'Facebook'),
                              ),

                              socialIconWidget(appleIcon, 'Apple'),
*/

                            ],
                          ),
                        )
                        else 
                          SizedBox(height: MediaQuery.of(context).size.height * 0.11),




                        Padding(
                          padding: const EdgeInsets.only(top: 22.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                MyString.existingMember!,
                                style: const TextStyle(
                                  fontSize: MyDimens.textSize15,
                                  color: MyColor.fieldGrey,
                                  fontFamily: 'sf_pro_regular',
                                ),),

                              InkWell(
                                onTap: (){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SocialLoginScreen() ), (route) => false);
                                  },
                                child: Padding(

                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    MyString.signin!,
                                    style: const TextStyle(
                                      fontSize: MyDimens.textSize15,
                                      color: MyColor.themeBlue,
                                      fontFamily: 'sf_pro_bold',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //bottom logo
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                          child: Image(image: bottomLogo, height: 70,),
                        )

                      ],),
                    ),
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
  Widget fullNameField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllErrorToFalse();
        });
      },
      controller: _getXController.nameEditController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: _getXController.nameFocus,
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        border: OutlineInputBorder(),
        labelText: MyString.fullName!.toUpperCase(),
        labelStyle: labelStyle(),
        hintText: MyString.enterYourName,
        errorText: _getXController.isNameEmpty ? "Please Enter Name" : null ,

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
        labelText: MyString.password!.toUpperCase(),
        labelStyle: labelStyle(),
        hintText: MyString.enterPassword,
        suffixIcon: IconButton(
          icon: Icon(
            _getXController.isPasswordObscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              _getXController.isPasswordObscure = !_getXController.isPasswordObscure;
            });
          },
        ),
        errorText: _getXController.isPasswordEmpty ? "Please Enter Password" : _getXController.isPasswordValid ? "Required minimum 6 character of Password" : null ,

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
  Widget socialIconWidget(AssetImage icon, String socialType) {
    return InkWell(
      onTap: (){
        setState(() {
          _getXController.isSocialSignIn = true;
        });

        if(socialType == 'Google'){
          googleLogin();

        } else {
          appleLogin();
        }
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
  Widget roleContainer() {

    return Row(
      children: [

        Text("Signup as :       ", style: TextStyle(
            fontSize: MyDimens.textSize12,
            color: MyColor.labelGrey,
            fontFamily: 'sf_pro_semibold'
        ),),


        Row(
          children: [
            Container(
              height:20.0,
              width:20.0,
              child: Radio<String>(
                value: 'True',
                groupValue: _getXController.isCustomer,
                onChanged: (value) {
                  setState(() {
                    _getXController.isCustomer = value!;
                    _getXController.isVendor = "False";
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left : 5.0),
              child: Text('Customer',
                  style: fieldStyle()),
            ),
          ],
        ),

        SizedBox(width: 10.0,),

        Row(
          children: [
            Container(
              height: 20.0,
              width:20.0,
              child: Radio<String>(
                value: "True",
                groupValue: _getXController.isVendor,
                onChanged: (value) {
                  setState(() {
                    _getXController.isVendor = value!;
                    _getXController.isCustomer = "False";
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left : 5.0),
              child: Text('Vendor', style: fieldStyle(),),
            ),

          ],
        ),



      ],
    );

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


  ///*
  ///
  /// call on device back button
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
  /// call if user agree to exit from app by pressing system back button
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
  /// exit from app dialog will dismiss
  void noFunction(){
    Navigator.pop(Get.context!);
  }

  ///*
  ///
  /// initialize GoogleSignIn
  /// https://www.googleapis.com/auth/userinfo.profile google api
  void initSocialLogins() async{
    //google login
    googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    );



    /*//facebook login
    facebookLogin = FacebookLogin();
    facebookLoginResult = await facebookLogin!.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
*/
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
        log("Result : " + googleAccount.email.toString());
        log("Result : " + googleAccount.id.toString());
        log("Result : " + googleAccount.displayName.toString());
        log("Result : " + googleAccount.photoUrl.toString());

        _getXController.nameEditController.text = googleAccount.displayName.toString();
        _getXController.emailEditController.text = googleAccount.email.toString();
        _getXController.passwordEditController.text = "";

        _getXController.loginId = googleAccount.id.toString();
        _getXController.loginType = "Google";

        hideProgressBar();
      }else{
        hideProgressBar();
        log("googleLogin : googleAccount is empty");
      }
    } catch (error) {
      log("googleLogin Exception : " + error.toString());
    }
  }
  

  ///*
  ///
  ///
  void appleLogin() {}


}
