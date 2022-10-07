import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:door_ap/common/controller/signup_controller.dart';
import 'package:door_ap/common/helperclass/ask_dialog.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/screen/login_screen.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sn_progress_dialog/progress_dialog.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  SignupController _getXController = Get.put(SignupController());
  late String fcmToken ;
  GoogleSignInAccount? googleCurrentUser;
  GoogleSignIn? googleSignIn;

  late ProgressDialog _progressDialog ;

  final _androidAppRetain = const MethodChannel("android_app_retain");

  @override
  void initState() {
    // TODO: implement initState

    googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        // 'https://www.googleapis.com/auth/contacts.readonly',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    );
    // initGoogleSignIn();

    MySharedPreference.getInstance();
    _getXController.refreshPage = refreshPage;
    _getXController.clearTextField();
    MySharedPreference.setString(MyConstants.keyLoginId, "");
    MySharedPreference.setString(MyConstants.keyLoginType, "");


    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance ;
    _firebaseMessaging.getToken().then((token){
      log("FCM_TOKEN :" + token!);
      fcmToken = token;
      MySharedPreference.setString(MyConstants.keyFcmToken, fcmToken);
    });


    _progressDialog = ProgressDialog(context: context);
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
           body: Container(
             child: Column(
               children: [

                 // title
                 Padding(
                   padding: const EdgeInsets.only(top: 20.0,),
                   child: Row(
                     mainAxisAlignment:  MainAxisAlignment.center,
                     children: [
                       // Image(image: appLogo, width: 54.0, height: 54.0,),
                       Padding(
                         padding: const EdgeInsets.only(left: 0.0),
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

                /* // icon
                 Padding(
                   padding: const EdgeInsets.only(top: 20.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       socialIconWidget(googleIcon),

                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 24.0),
                         child: socialIconWidget(fbIcon),
                       ),

                       socialIconWidget(appleIcon),

                     ],
                   ),
                 ),


                 //or login email
                 Padding(
                   padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                   child: Row(
                     children: [
                       Expanded(
                           flex: 1,
                           child: Container(height: 2, color: MyColor.lightBgGrey,)),

                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 7.0),
                         child: Text(MyString.orSignupUsingEmail!, style: const TextStyle(fontSize: MyDimens.textSize11, color: MyColor.labelGrey, fontFamily: 'sf_pro_regular'),),
                       ),

                       Expanded(
                           flex: 1,
                           child: Container(height: 2, color: MyColor.lightBgGrey,)),

                     ],
                   ),
                 ),
*/
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
                         !_getXController.isGoogleSignIn?
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
                         Padding(
                           padding: const EdgeInsets.only(top: 20.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               socialIconWidget(googleIcon),

                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                 child: socialIconWidget(fbIcon),
                               ),

                               socialIconWidget(appleIcon),

                             ],
                           ),
                         ),




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
                                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen() ), (route) => false);
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
  Widget socialIconWidget(AssetImage icon) {
    return InkWell(
      onTap: (){
        /*setState(() {
          _getXController.isGoogleSignIn = true;
        });
        googleLogin();*/
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

        MySharedPreference.setString(MyConstants.keyLoginId, googleAccount.id.toString());
        MySharedPreference.setString(MyConstants.keyLoginType, "Google");

        hideProgressBar();
      }
    } catch (error) {
      print(error);
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
      msqFontWeight: FontWeight.bold,);

  }

  ///*
  ///
  ///
  hideProgressBar(){
    _progressDialog.close();
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


}
