import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/controller/vendor_home_controller.dart';
import 'package:door_ap/vendor/screen/vendor_show_service_list_screen.dart';
import 'package:door_ap/vendor/screen/vendor_side_nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class VendorHomeScreen extends StatefulWidget {
  const
  VendorHomeScreen({Key? key}) : super(key: key);

  @override
  _VendorHomeScreenState createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {

  VendorHomeController _getXController = Get.put(VendorHomeController());

  @override
  void initState() {
    // TODO: implement initState
    MySharedPreference.getInstance();
    _getXController.refreshPage = refreshPage;
    Future.delayed(Duration.zero, () async {
      _getXController.hitViewProfileApi();
    });
    super.initState();
  }

  ///*
  ///
  void refreshPage(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          endDrawer: VendorSideNavDrawer(profileData: _getXController.payload, getXController: _getXController),
       appBar: PreferredSize(
         preferredSize: Size.fromHeight(70.0),
         child: AppBar(
           // leadingWidth: MediaQuery.of(context).size.width,
           title: Row(
             children: [
               Image(image: homeLocIcon, height: 25.0, width: 25.0,),
               SizedBox(width: 5.0,),
               Expanded(
                 flex: 1,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,

                   children: [
                     Text(_getXController.cityName,
                       style:  TextStyle(color: Colors.white, fontSize: MyDimens.textSize13, fontFamily: "montserrat_medium",), textAlign: TextAlign.left,),

                     Padding(
                       padding: EdgeInsets.only(top: 3.0),
                       child: Text(_getXController.fullAddress , maxLines: 1,
                         style:  TextStyle(color: Colors.white, fontSize: MyDimens.textSize12, fontFamily: "montserrat_regular",), textAlign: TextAlign.left,),
                     ),
                   ],
                 ),
               ),
             ],
           ),
           elevation: 0,
           backgroundColor: MyColor.themeBlue,
         ),
       ),

        body: Container(
          height: MediaQuery.of(context).size.height,
          color: MyColor.themeBlue,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getXController.isApproved! == "true"?
                    SizedBox()
                    :notApprovedContainer(),


                _getXController.isServiceCreated!?
                SizedBox()
                :Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 22.0, left: 30, right: 30),
                  child: ElevatedButton(
                      onPressed: (){
                        Get.to(VendorShowServiceListScreen());
                        },
                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),),
                          elevation: 5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text("Create Your Service",
                          style: const TextStyle(
                              fontSize: 17.0,
                              color: Colors.white,
                              fontFamily: 'montserrat_medium'
                          ),),
                      )),
                ),

              ],
            ),
          ),
        )
      ),
    );
  }


  ///*
  ///
  ///
  Widget notApprovedContainer() {
    return Center(
      child: Column(
        children: [

          Image(image: underApprovalImg, width: 150.0, height: 150.0,),
            SizedBox(height: 10.0, ),
          Text("Your account is under approval", style: TextStyle(fontSize: 15.0, color: MyColor.themeBlue, fontFamily: 'montserrat_semiBold' ),),
          Text("Pease contact Admin", style: TextStyle(fontSize: 15.0, color: MyColor.themeBlue, fontFamily: 'montserrat_semiBold' ),),
        ],
      ),
    );
  }
}
