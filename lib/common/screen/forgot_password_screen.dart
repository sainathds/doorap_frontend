import 'package:door_ap/common/controller/forgot_password_controller.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  ForgotPasswordController _getXController = Get.put(ForgotPasswordController());


  @override
  void initState() {
    // TODO: implement initState
    _getXController.clearField();
    MySharedPreference.getInstance();
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
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 33.0),
          child: Column(
            children: [
              //title and back arrow
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Image(image: backArrowIcon, height: 16.0, width: 18.0,)),

                  Text(MyString.forgotPasswordTitle!,
                    style: const TextStyle(
                        fontSize: MyDimens.textSize20,
                        color: MyColor.themeBlue,
                        fontFamily: 'roboto_bold'
                    ),),

                  const SizedBox(height: 16, width: 18,),

                ],),


              ///*
              ///
              ///
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image(image: forgotPassImage, height: 265.0, width: 237.0,),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        margin: const EdgeInsets.only(top: 33.0,),
                        child: Text(MyString.enterRegEmail!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: MyDimens.textSize13,
                            color: MyColor.themeBlue,
                            fontFamily: 'montserrat_medium',
                          ),),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: emailIdField(),
                      ),

                      ///*
                      /// button
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 30.0),
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
                              child: Text(MyString.proceed!,
                                  style: const TextStyle(
                                      fontSize: MyDimens.textSize16,
                                      color: Colors.white,
                                      fontFamily: 'sf_pro_bold'
                                  ),),
                            )),
                      ),


                    ],
                  ),
                ),
              ),


            ],
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
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        border: OutlineInputBorder(),
        labelText: MyString.emailId,
        labelStyle: labelStyle(),
        hintText: MyString.enterYourEmail,
        errorText: _getXController.isEmailEmpty ? "Please Enter Email" : _getXController.isEmailValid ? "Please Enter Valid Email" : null ,

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

}
