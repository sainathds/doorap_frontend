import 'package:door_ap/common/helperclass/ask_dialog.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/screen/change_password_screen.dart';
import 'package:door_ap/common/screen/login_screen.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/controller/customer_account_controller.dart';
import 'package:door_ap/customer/screen/customer_my_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomerAccountScreen extends StatefulWidget {
  const CustomerAccountScreen({Key? key}) : super(key: key);

  @override
  _CustomerAccountScreenState createState() => _CustomerAccountScreenState();
}

class _CustomerAccountScreenState extends State<CustomerAccountScreen> {

  CustomerAccountController _getXController = Get.put(CustomerAccountController());


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

                      /*Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: ListTile(
                          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15,),
                          title: Text(MyString.myWishlist!, style: menuStyle()),
                          // onTap: () => Navigator.pop(context),
                        ),
                      ),*/

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
                          // onTap: () => Navigator.pop(context),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: ListTile(
                          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15,),
                          title: Text(MyString.termsOfService!, style: menuStyle()),
                          // onTap: () => Navigator.pop(context),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: ListTile(
                          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15,),
                          title: Text(MyString.refundPolicy!, style: menuStyle()),
                          // onTap: () => Navigator.pop(context),
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
    _getXController.hitLogoutApi();
  }

}
