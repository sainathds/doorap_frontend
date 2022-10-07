import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_ap/common/helperclass/ask_dialog.dart';
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
import 'package:door_ap/customer/controller/customer_account_controller.dart';
import 'package:door_ap/customer/screen/customer_my_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerAccountScreen extends StatefulWidget {
  const CustomerAccountScreen({Key? key}) : super(key: key);

  @override
  _CustomerAccountScreenState createState() => _CustomerAccountScreenState();
}

class _CustomerAccountScreenState extends State<CustomerAccountScreen> {

  CustomerAccountController _getXController = Get.put(CustomerAccountController());

  String tag = 'CustomerAccountScreen';

  @override
  void initState() {
    // TODO: implement initState
    MySharedPreference.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
          appBar: AppBar(
        elevation: 5,
        shadowColor: MyColor.textGrey,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: MyColor.themeBlue, // Navigation bar
          statusBarColor: MyColor.themeBlue, // Status bar
        ),
        centerTitle: true,
        title: const Text(
          "Account",
          style: TextStyle(
              fontSize: MyDimens.textSize20,
              color: Colors.white,
              fontFamily: 'roboto_medium'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Text(MySharedPreference.getString(MyConstants.keyName), style: TextStyle(fontSize: MyDimens.textSize20, color: Colors.black, fontFamily: 'roboto_bold'),),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0, bottom: 20.0),
            child: Text(MySharedPreference.getString(MyConstants.keyEmail), style: TextStyle(fontSize: MyDimens.textSize14, color: Colors.black, fontFamily: 'montserrat_regular'),),
          ),

          Expanded(
            flex: 1,
            child: ListView(
              children:
                ListTile.divideTiles(
                    color: Colors.black26,
                    context: context,
                    tiles: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: ListTile(
                            trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15,),
                          title: Text(MyString.myOrders!, style: menuStyle()),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerMyOrderScreen() )),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: ListTile(
                          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15,),
                          title: Text('Messages', style: menuStyle()),
                          // onTap: () => Get.to(() => RecentChatListScreen()),

                          onTap: () => Get.to(() => TestRecentChat()),

                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: ListTile(
                          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15,),
                          title: Text(MyString.addressDetails!, style: menuStyle()),
                          // onTap: () => Navigator.pop(context),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: ListTile(
                          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15,),
                          title: Text(MyString.privacyPolicy!, style: menuStyle()),
                          onTap: () => redirectToWeb(MyString.privacyPolicyUrl)
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: ListTile(
                          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15,),
                          title: Text(MyString.termsOfService!, style: menuStyle()),
                            onTap: () => redirectToWeb(MyString.termsOfServiceUrl)
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: ListTile(
                          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15,),
                          title: Text(MyString.refundPolicy!, style: menuStyle()),
                            onTap: () => redirectToWeb(MyString.refundPolicyUrl)
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: ListTile(
                          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15,),
                          title: Text(MyString.changePassword!, style: menuStyle()),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen() )),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: ListTile(
                          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15,),
                          title: Text(MyString.logout!, style: menuStyle()),
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
                    ]).toList(),
            ),
          )

        ],
      ),),
    );
  }

  ///*
  ///
  ///
  TextStyle menuStyle(){
    return const TextStyle(
        fontSize: MyDimens.textSize17,
        color: Colors.black,
        fontFamily: 'roboto_bold'
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
    _getXController.hitLogoutApi();

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


  ///*
  ///
  ///
  void redirectToWeb(String url) async{
    if (await launchUrl(Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }


}
