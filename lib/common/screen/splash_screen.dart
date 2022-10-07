import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/screen/signup_screen.dart';
import 'package:door_ap/common/screen/welcom_screen.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/screen/customer_btm_screen.dart';
import 'package:door_ap/customer/screen/customer_main_screen.dart';
import 'package:door_ap/vendor/screen/vendor_home_screen.dart';
import 'package:door_ap/vendor/screen/venodr_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState

    MySharedPreference.getInstance();
    handleSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: MyColor.themeBlue,
      child: Center(child: Image(image: splashLogoImg,),),);
  }

  ///*
  ///
  ///
  void handleSession() {
      Future.delayed(Duration(seconds: 5), (){
        if(MySharedPreference.getInt(MyConstants.keyUserId) != null) {
          if (MySharedPreference.getString(MyConstants.keyVendor) == "True") {
            if(!MySharedPreference.getBool(MyConstants.keyIsProfileCompleted)){
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => VendorProfileScreen(),
                  ),
                      (route) => false);
            }else{
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => VendorHomeScreen(),
                  ),
                      (route) => false);
            }

          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => CustomerBtmScreen(),
                ),
                    (route) => false);
          }
        }  else{
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>  WelcomeScreen(),
              ),
                  (route) => false);
        }
      });
  }
}
