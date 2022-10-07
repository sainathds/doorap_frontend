import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_ap/common/helperclass/ask_dialog.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/screen/change_password_screen.dart';
import 'package:door_ap/common/screen/login_screen.dart';
import 'package:door_ap/common/screen/recent_chat_list_screen.dart';
import 'package:door_ap/common/screen/test_recent_chat.dart';
import 'package:door_ap/common/utils/firestore_constants.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/controller/vendor_home_controller.dart';
import 'package:door_ap/vendor/model/response/vendor_view_profile_response.dart';
import 'package:door_ap/vendor/screen/vendor_bank_account_screen.dart';
import 'package:door_ap/vendor/screen/vendor_custom_service_screen.dart';
import 'package:door_ap/vendor/screen/vendor_past_order_screen.dart';
import 'package:door_ap/vendor/screen/vendor_payment_screen.dart';
import 'package:door_ap/vendor/screen/vendor_set_schedule_screen.dart';
import 'package:door_ap/vendor/screen/vendor_categories_screen.dart';
import 'package:door_ap/vendor/screen/vendor_show_edit_profile_screen.dart';
import 'package:door_ap/vendor/screen/vendor_show_service_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';


class VendorSideNavDrawer extends StatefulWidget {

  Payload? profileData;
  VendorHomeController getXController;

  VendorSideNavDrawer({Key? key, required this.profileData, required this.getXController}) : super(key: key);

  @override
  _VendorSideNavDrawerState createState() => _VendorSideNavDrawerState();
}

class _VendorSideNavDrawerState extends State<VendorSideNavDrawer> {


  String tag = 'VendorSideNavDrawer';

  @override
  void initState() {
    // TODO: implement initState
    MySharedPreference.getInstance();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: MyColor.themeBlue,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20.0),
              child: Row(
                children: [

                Expanded(
                  flex: 2,
                  child: Text(MyString.areYouAvailable!,
                      style: TextStyle(fontSize: MyDimens.textSize18,
                          color: Colors.white,
                          fontFamily: 'montserrat_regular')),
                ),

                SizedBox(width: 5.0,),

                Expanded(
                  child: FlutterSwitch(
                    width: 70.0,
                    height: 30.0,
                    valueFontSize: 16.0,
                    value: widget.getXController.isAvailable,
                    borderRadius: 32.0,
                    padding: 5.0,
                    showOnOff: true,
                    activeText: 'Yes',
                    inactiveText: 'No',
                    activeTextColor: Colors.white,
                    inactiveTextColor: Colors.white,
                    activeColor: Colors.green,
                    inactiveColor: Colors.orangeAccent,
                    activeTextFontWeight: FontWeight.normal,
                    inactiveTextFontWeight: FontWeight.normal,
                    onToggle: (val) {
                      setState(() {
                        widget.getXController.isAvailable = val;
                        log("IS_AVAILABLE :" + widget.getXController.isAvailable.toString());
                        widget.getXController.hitSetAvailabilityApi();
                      });
                    },
                  ),
                ),
              ],),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: ListTile.divideTiles(
                      color: Colors.white30,
                      context: context,
                      tiles: [

                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, top: 20),
                          child: ListTile(
                            leading: Image(image: homeIcon, width: 22.0, height: 22.0, color: Colors.white, alignment: Alignment.bottomCenter,),
                            title: Text(MyString.home!, style: menuStyle()),
                            onTap: () => Navigator.pop(context),
                          ),
                        ),


                        //Profile
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0,),
                          child: ListTile(
                              leading: Image(image: profileIcon, width: 22.0, height: 22.0, color: Colors.white, alignment: Alignment.bottomCenter,),
                              title: Text(MyString.profile!, style: menuStyle()),
                              onTap: () async{
                                Navigator.pop(context);
                                Route route = MaterialPageRoute(builder: (context) => VendorShowEditProfileScreen(profileData: widget.profileData!));
                                var nav = await Navigator.of(context).push(route);
                                if (nav == true || nav == null) {
                                  widget.getXController.hitViewProfileApi();
                                }
                              }
                          ),
                        ),


                        //Messages
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0,),
                          child: ListTile(
                              leading: Image(image: messageIcon, width: 22.0, height: 22.0, color: Colors.white, alignment: Alignment.bottomCenter,),
                              title: Text('Messages', style: menuStyle()),
                              onTap: () async{
                                Navigator.pop(context);
                                Route route = MaterialPageRoute(builder: (context) => TestRecentChat());
                                var nav = await Navigator.of(context).push(route);
                                if (nav == true || nav == null) {
                                  widget.getXController.hitViewProfileApi();
                                }
                              }
                          ),
                        ),


                        //Vendor Services
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0,),
                          child: ListTile(
                              leading: Image(image: serviceIcon, width: 22.0, height: 22.0, color: Colors.white, alignment: Alignment.bottomCenter,),
                              title: Text('Your Services', style: menuStyle()),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const VendorShowServiceListScreen()));
                              }
                          ),
                        ),


                        //Set Schedule
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0,),
                          child: ListTile(
                              leading: Image(image: timeIcon, width: 22.0, height: 22.0,color: Colors.white, alignment: Alignment.bottomCenter,),
                              title: Text(MyString.setSchedule!, style: menuStyle()),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const VendorSetScheduleScreen()));
                              }
                          ),
                        ),

                        //Payment
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0,),
                          child: ListTile(
                              leading: Image(image: paymentIcon, width: 22.0, height: 22.0, color: Colors.white, alignment: Alignment.bottomCenter,),
                              title: Text(MyString.payment!, style: menuStyle()),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const VendorPaymentScreen()));
                              }
                          ),
                        ),

                        //Bank Account
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0,),
                          child: ListTile(
                              leading: Image(image: bankIcon, width: 22.0, height: 22.0, color: Colors.white, alignment: Alignment.bottomCenter,),
                              title: Text(MyString.bankAccount!, style: menuStyle()),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => VendorBankAccountScreen()));
                              }
                          ),
                        ),

                        //Past order
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0,),
                          child: ListTile(
                              // leading: Image(image: bankIcon, width: 22.0, height: 22.0, color: Colors.white, alignment: Alignment.bottomCenter,),
                              leading: Icon(Icons.reorder_sharp, size: 22.0, color: Colors.white,),
                              title: Text('Past Orders', style: menuStyle()),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => VendorPastOrderScreen()));
                              }
                          ),
                        ),


                        //Change Password
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0,),
                          child: ListTile(
                              leading: Image(image: changePassIcon, width: 22.0, height: 22.0, color: Colors.white, alignment: Alignment.bottomCenter,),
                              title: Text(MyString.changePassword!, style: menuStyle()),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
                              }
                          ),
                        ),


                        // Logout
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0,),
                          child: ListTile(
                              leading: Image(image: logoutIcon, width: 22.0, height: 22.0, color: Colors.white, alignment: Alignment.bottomCenter,),
                              title: Text(MyString.logout!, style: menuStyle(),),
                              onTap: () {
                                showDialog(
                                    context: Get.context!,
                                    builder: (BuildContext context1) => AskDialog(
                                        my_context: Get.context!,
                                        msg: "Do you want to logout ?",
                                        yesFunction: yesFunction,
                                        noFunction: noFunction));
                              }
                          ),
                        ),

                      ]
                    ).toList(),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///*
  ///
  ///
  TextStyle menuStyle(){
    return const TextStyle(
      fontSize: MyDimens.textSize17,
      color: Colors.white,
      fontFamily: 'montserrat_regular'
    );
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
    String userId = MySharedPreference.getInt(MyConstants.keyUserId).toString();
    widget.getXController.hitLogoutApi();

    logoutFirebaseUser(userId);
  }


  ///*
  ///
  ///
  Future<String?> logoutFirebaseUser(String userId) async {
    String? fbUserId = await getFirebaseUserData(userId);

    if (fbUserId != null) {
      FirebaseFirestore.instance
          .collection(FirestoreConstants.pathUsersCollection)
          .doc(fbUserId)
          .update({
        FirestoreConstants.fcmToken: "",
      }).whenComplete(() {

      }).catchError((onError) =>
          log(tag + ' Firestore updateFirebaseUser Exception : ' +
              onError.toString()));
    }
  }


  ///*
  ///
  ///
  Future<String?> getFirebaseUserData(String userId) async{
    String? fbUserId;

    //get user
    QuerySnapshot userData = await FirebaseFirestore.instance
        .collection('Users')
        .where(FirestoreConstants.userId, isEqualTo: userId)
        .get();

    if(userData != null){
      for (QueryDocumentSnapshot document in userData.docs) {
        fbUserId = document.id;
      }
    }
    return fbUserId;
  }



}
