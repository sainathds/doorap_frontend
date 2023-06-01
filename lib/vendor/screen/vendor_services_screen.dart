import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/vendor/controller/vendor_services_controller.dart';
import 'package:door_ap/vendor/model/response/vendor_categories_response.dart';
import 'package:door_ap/vendor/screen/vendor_custom_service_screen.dart';
import 'package:door_ap/vendor/screen/vendor_set_services_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';

class VendorServicesScreen extends StatefulWidget {

  Payload? selectedCategData;

  VendorServicesScreen({Key? key, required this.selectedCategData}) : super(key: key);

  @override
  _VendorServicesScreenState createState() => _VendorServicesScreenState();
}

class _VendorServicesScreenState extends State<VendorServicesScreen> {

  VendorServicesController _getXController = Get.put(VendorServicesController());
  @override
  void initState() {
    // TODO: implement initState

    _getXController.refreshPage = refreshPage;
    _getXController.selectedCategoryId = widget.selectedCategData!.id!;
    Future.delayed(Duration.zero, () async {
      _getXController.hitServicesApi();
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
                          Get.back();
                        },
                        child: Image(image: backArrowIcon, height: 16.0, width: 18.0, color: Colors.white,)),

                    Text(MyString.services!,
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
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [

                      Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.selectedCategData!.categoryName!,
                              style: TextStyle(
                                color: MyColor.themeBlue,
                                fontSize: MyDimens.textSize20,
                                fontFamily: 'montserrat_semiBold'
                              ),
                            ),
                          ],
                        ),
                      ),

                      _getXController.servicesData.isNotEmpty?
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: getCustomGridLayout(),
                        ),
                      )
                          : InkWell(
                        onTap: (){
                          Get.off( () => VendorCustomServiceScreen(categoryId: _getXController.selectedCategoryId));
                        },
                        child: Column(
                          children: [
                            Container(
                                width: 80.0, height: 80.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: MyColor.lightBgGrey)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Image(image:  addImage,),
                                )
                            )],
                        ),
                      )
                      ,
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  ///*
  ///
  ///
  getGridLayout() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 20),
        itemCount: _getXController.servicesData.length + 1,
        itemBuilder: (BuildContext context, int index){
          return index == _getXController.servicesData.length?
          InkWell(
            onTap: (){
              Get.off( () => VendorCustomServiceScreen(categoryId: _getXController.selectedCategoryId));
            },
            child: Column(
              children: [
                Container(
                    width: 80.0, height: 80.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: MyColor.lightBgGrey)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image(image:  addImage,),
                    )
                )],
            ),
          )

              : Expanded(
            child: InkWell(
              onTap: (){
                Get.off( () => VendorSetServicesScreen(selectedServiceData: _getXController.servicesData[index]));
              },
              child: Container(
                color: Colors.pink,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: _getXController.servicesData[index].serviceImage == "" ?
                        Image(image:  noProfileImg,
                          width: 90.0, height: 100.0, fit: BoxFit.fill,)

                            : Image(image:
                        NetworkImage(baseImageUrl + _getXController.servicesData[index].serviceImage!),
                            width: 90, height: 100, fit: BoxFit.fill)),

                    SizedBox(height: 5.0,),

                    Text(_getXController.servicesData[index].serviceName! + "mkilopj uyhgtrfbh yuiijn bhgvfrtgb ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: MyDimens.textSize13,
                          color: MyColor.themeBlue,
                          fontFamily: 'montserrat_medium'
                      ),),
                  ],
                ),
              ),
            ),
          );
        });
  }

  ///*
  ///
  ///
  getCustomGridLayout() {
    return SingleChildScrollView(
      child: LayoutGrid(
        // set some flexible track sizes based on the crossAxisCount
        columnSizes: [1.fr, 1.fr, 1.fr],
        // set all the row sizes to auto (self-sizing height)
        rowSizes: List<IntrinsicContentTrackSize>.generate(
            (_getXController.servicesData.length / 2).round(),
                (int index) => auto),
        rowGap: 20,
        // note: there's no childAspectRatio
        children: [
          // render all the cards with *automatic child placement*
          for (var index = 0; index <= _getXController.servicesData.length; index++)
            index == _getXController.servicesData.length?
            InkWell(
              onTap: (){

                //Add your custom service
                Get.off( () => VendorCustomServiceScreen(categoryId: _getXController.selectedCategoryId));
              },
              child: Center(
                child: Column(
                  children: [
                    Container(
                        width: 80.0, height: 80.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: MyColor.lightBgGrey)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image(image:  addImage,),
                        )
                    )],
                ),
              ),
            )
            :InkWell(
              onTap: (){

                //select Service and redirect to VendorSetServicesScreen()
                Get.off( () => VendorSetServicesScreen(selectedServiceData: _getXController.servicesData[index]));
              },
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: _getXController.servicesData[index].serviceImage == ""
                          ?
                      Image(image: noProfileImg,
                        width: 90.0, height: 100.0, fit: BoxFit.fill,)

                          : Image.network(baseImageUrl +
                          _getXController.servicesData[index].serviceImage!,
                          width: 90, height: 100, fit: BoxFit.fill,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Image(
                              image: noImage, width: 90, height: 100, fit: BoxFit.fill);
                        },)),

                  SizedBox(height: 5.0,),

                  Text(_getXController.servicesData[index].serviceName!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MyDimens.textSize13,
                        color: MyColor.themeBlue,
                        fontFamily: 'montserrat_medium'
                    ),),
                ],
              ),
            )
        ],
      ),
    );
  }
}
