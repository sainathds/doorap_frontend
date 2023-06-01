import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/controller/vendor_show_service_list_controller.dart';
import 'package:door_ap/vendor/screen/vendor_categories_screen.dart';
import 'package:door_ap/vendor/screen/vendor_edit_service_screen.dart';
import 'package:door_ap/vendor/screen/vendor_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorShowServiceListScreen extends StatefulWidget {
  const VendorShowServiceListScreen({Key? key}) : super(key: key);

  @override
  _VendorShowServiceListScreenState createState() => _VendorShowServiceListScreenState();
}

class _VendorShowServiceListScreenState extends State<VendorShowServiceListScreen> {

  VendorShowServicesController _getXController = Get.put(VendorShowServicesController());

  @override
  void initState() {
    // TODO: implement initState
    MySharedPreference.getInstance();
    _getXController.refreshPage = refreshPage;
    Future.delayed(Duration.zero, () async {

      //get vendor services
      _getXController.hitShowVendorServicesListApi();
    });
    super.initState();
  }

  ///*
  ///
  ///
  void refreshPage(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Container(
            color: MyColor.themeBlue,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 21.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      InkWell(
                          onTap: (){
                            // Get.back();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => VendorHomeScreen() ),
                                    (route) => false);
                          },
                          child: Image(image: backArrowIcon, height: 16.0, width: 18.0, color: Colors.white,)),

                      Text('Your Services',
                        style: const TextStyle(
                            fontSize: MyDimens.textSize20,
                            color: Colors.white,
                            fontFamily: 'roboto_medium'
                        ),),

                      const SizedBox(height: 16, width: 18,),
                    ],),
                ),

                Expanded(
                    flex: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
                        color: Colors.white,
                      ),
                      child:

                        Stack(
                          children: [
                            Container(
                              child: _getXController.vendorServiceList.isNotEmpty?
                              ListView.builder(
                                  itemCount: _getXController.vendorServiceList.length,
                                  itemBuilder: (BuildContext context, int index){
                                    return vendorServicesList(context, index);
                                  })
                                  :
                              Center(
                                child: Text("No services found in your account", style: TextStyle(fontSize: MyDimens.textSize14, color: MyColor.labelGrey, fontFamily: 'sf_pro_semibold'),),
                              ),
                            ),

                            Positioned(
                              bottom: 30,
                              right: 30,
                              child: InkWell(
                                onTap: (){
                                  Get.off(VendorCategoriesScreen());
                                  },
                                child: Icon(
                                  Icons.add_circle, size: 50, color: MyColor.themeBlue,),
                              ),
                            )
                          ],
                        )

                    ))

              ],
            ),
          ),
        ),
      ),

    );
  }

  ///*
  ///
  ///
  Widget vendorServicesList(BuildContext context, int index) {

    return Card(
      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
      elevation: 2,
      child: Row(
        children: [

          Expanded(
               flex: 1,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ClipRRect(
                     borderRadius: BorderRadius.all(Radius.circular(6)),
                     child:
                   _getXController.vendorServiceList[index].fkServiceServiceImage != null && _getXController.vendorServiceList[index].fkServiceServiceImage != "" ?
                   Image.network(baseImageUrl + _getXController.vendorServiceList[index].fkServiceServiceImage!,
                       width: 100, height: 100, fit: BoxFit.fill,
                         errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                           return Image(
                               image: noImage, width: 100, height: 100, fit: BoxFit.fill);
                         },)
                     :
                     Image(
                       image: noImage,
                       width: 70, height: 80, fit: BoxFit.fill)

                 ),
               )),

          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(_getXController.vendorServiceList[index].fkServiceServiceName!,
                    style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: MyColor.fieldGrey,
                      fontFamily: 'montserrat_semiBold'
                    ),),

                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        Text(_getXController.vendorServiceList[index].hour!,
                          style: TextStyle(
                              fontSize: MyDimens.textSize12,
                              color: MyColor.labelGrey,
                              fontFamily: 'montserrat_semiBold'
                          ),),

                        SizedBox(width: 10,),

                        Text(_getXController.vendorServiceList[index].price!.toString(),
                          style: TextStyle(
                              fontSize: MyDimens.textSize12,
                              color: MyColor.labelGrey,
                              fontFamily: 'montserrat_semiBold'
                          ),),
                      ],
                    ),
                  ),

                  Text(_getXController.vendorServiceList[index].fkCategoryCategoryName!,
                    style: TextStyle(
                        fontSize: MyDimens.textSize12,
                        color: MyColor.themeBlue,
                        fontFamily: 'montserrat_semiBold'
                    ),),

                ],
              ),
            ),
          ),


          Card(
            elevation: 5,
            margin: const EdgeInsets.only(left: 8.0, right: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InkWell(
                      onTap: () async{
                        var nav = await Get.to(() => VendorEditServiceScreen(vendorServiceData: _getXController.vendorServiceList[index]));
                        if (nav == true || nav == null) {
                          _getXController.hitShowVendorServicesListApi(); //call to get updated vendor service data
                        }},
                      child: Icon(Icons.read_more_outlined, color: MyColor.themeBlue, )),

                  SizedBox(height: 15,),

                  InkWell(
                      onTap: (){

                        //delete single service
                        _getXController.hitDeleteServiceApi(
                          _getXController.vendorServiceList[index].id,);
                      },
                      child: Icon(Icons.delete_outline_outlined, color: Colors.red,)),

                ],
              ),
            ),
          )
          ],
      ),
    );
  }


  ///*
  ///
  ///
  Future<bool> _onWillPop() async {
    // Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => VendorHomeScreen() ),
            (route) => false);
    return false;
  }

}
