import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/controller/vendor_past_order_controller.dart';
import 'package:door_ap/vendor/screen/vendor_cancel_order_screen.dart';
import 'package:door_ap/vendor/screen/vendor_completed_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorPastOrderScreen extends StatefulWidget {


  VendorPastOrderScreen({Key? key,}) : super(key: key);

  @override
  _VendorPastOrderScreenState createState() => _VendorPastOrderScreenState();
}

class _VendorPastOrderScreenState extends State<VendorPastOrderScreen> {

  VendorPastOrderController _getXController  = Get.put(VendorPastOrderController());


  @override
  void initState() {
    // TODO: implement initState
    MySharedPreference.getInstance();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: MyColor.themeBlue,
          child: Column(
            children:[
              //header section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 21.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Image(image: backArrowIcon, height: 16.0, width: 18.0, color: Colors.white,)),

                    const Text('Past Orders',
                      style: TextStyle(
                          fontSize: MyDimens.textSize20,
                          color: Colors.white,
                          fontFamily: 'roboto_medium'
                      ),),

                    const SizedBox(height: 16, width: 18,),

                  ],),
              ),


              Expanded(child: customTabWidget())

            ],
          ),
        ),
      ),

    );
  }

  ///*
  ///
  ///
  Widget customTabWidget() {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
              /*shape: Border(
                  bottom: BorderSide(
                      color: Colors.black26,
                      width: 0.2
                  )),*/
              backgroundColor: Colors.transparent,
              elevation: 0,
              bottom: TabBar(
                padding:
                EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                indicatorPadding: EdgeInsets.zero,
                unselectedLabelColor: MyColor.black50,
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(
                    text: "Completed",
                  ),
                  Tab(
                    text: "Cancelled",
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            // controller: _tabController,
            children: [
              VendorCompletedOrderScreen(pastOrderController: _getXController),
              VendorCancelOrderScreen(pastOrderController: _getXController)
            ],
          ),
        ));
  }

}
