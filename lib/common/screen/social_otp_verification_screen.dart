import 'package:door_ap/common/controller/otp_verification_controller.dart';
import 'package:door_ap/common/controller/social_otp_verification_controller.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SocialOtpVerificationScreen extends StatefulWidget {

  String callFrom;
  SocialOtpVerificationScreen({Key? key, required this.callFrom}) : super(key: key);

  @override
  _SocialOtpVerificationScreenState createState() => _SocialOtpVerificationScreenState();
}

class _SocialOtpVerificationScreenState extends State<SocialOtpVerificationScreen> {
  final SocialOtpVerificationController _getXController = Get.put(SocialOtpVerificationController());

  @override
  void initState() {
    // TODO: implement initState

    MySharedPreference.getInstance();
    _getXController.callFrom = widget.callFrom;
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

                  Text(MyString.verification!,
                    style: const TextStyle(
                        fontSize: MyDimens.textSize20,
                        color: MyColor.themeBlue,
                        fontFamily: 'roboto_bold'
                    ),),

                  const SizedBox(height: 16, width: 18,),

                ],),


              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(children: [
                    //Otp Image
                    Image(image: otpImage, height: 226.0, width: 195.0,),


                    //otp verification text
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(MyString.otpVerification!,
                        style: const TextStyle(
                          fontSize: MyDimens.textSize20,
                          color: MyColor.themeBlue,
                          fontFamily: 'montserrat_semiBold',
                        ),),
                    ),

                    //please enter text
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      margin: const EdgeInsets.only(top: 8.0,),
                      child: Text(MyString.pleaseEnterCode!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: MyDimens.textSize13,
                          color: MyColor.themeBlue,
                          fontFamily: 'montserrat_medium',
                        ),),
                    ),

                    ///*
                    ///pin field
                    Padding(
                      padding: const EdgeInsets.only(top: 31.0),
                      child: otpTextField(),
                    ),

                    ///*
                    ///didn't receive code
                    Padding(
                      padding: const EdgeInsets.only(top: 36.0, bottom: 8.0),
                      child: Text(MyString.didntReceiveCode!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: MyDimens.textSize13,
                          color: MyColor.fieldGrey,
                          fontFamily: 'sf_pro_regular',
                        ),),
                    ),

                    ///*
                    /// Re-send
                    InkWell(
                      onTap: (){
                        if(_getXController.callFrom == "signup"){
                          _getXController.hitGetOtpApi();
                        }else{
                          _getXController.hitForgotPasswordOtpApi();
                        }
                      },
                      child: Text(MyString.resend!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: MyDimens.textSize15,
                          color: MyColor.themeBlue,
                          fontFamily: 'sf_pro_bold',
                        ),),
                    ),

                    ///*
                    ///
                    ///
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
                            child: Text(MyString.verify!,
                              style: const TextStyle(
                                  fontSize: MyDimens.textSize15,
                                  color: Colors.white,
                                  fontFamily: 'sf_pro_bold'
                              ),),
                          )),
                    ),


                  ],),
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
  ///
  Widget otpTextField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: PinCodeTextField(
        appContext: context,
        textStyle: const TextStyle(
            fontSize: MyDimens.textSize20,
            color: Colors.white,
            fontFamily: 'montserrat_semiBold'
        ),
        length: 4,
        animationType: AnimationType.fade,
        validator: (v) {
          if (v!.length < 4) {
            return "";
          } else {
            return null;
          }
        },
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.circle,
          fieldHeight: 54,
          fieldWidth: 54,
          activeColor: MyColor.activeOtp,
          activeFillColor: MyColor.activeOtp,

          selectedColor: MyColor.selectedOtp,
          selectedFillColor: MyColor.selectedOtp,

          inactiveColor: MyColor.inactiveOtp,
          inactiveFillColor: MyColor.inactiveOtp,
        ),
        cursorColor: Colors.white,
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        onCompleted: (v) {
          _getXController.enteredOtp = v;
          print("DoctorOtpVerification Complete OTP: " + _getXController.enteredOtp);
        },

        onChanged: (v){
        },
      ),
    );
  }
}
