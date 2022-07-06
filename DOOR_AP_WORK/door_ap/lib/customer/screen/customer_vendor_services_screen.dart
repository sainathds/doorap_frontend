import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/customer/controller/customer_vendor_services_controller.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'cuatomer_cart_summary_screen.dart';
import 'customer_service_info_screen.dart';

class CustomerVendorServicesScreen extends StatefulWidget {
  int vendorId;
  int categoryId;
  CustomerAddressModel customerAddressModel;

  CustomerVendorServicesScreen({Key? key, required this.vendorId, required this.categoryId, required this.customerAddressModel,
                               }) : super(key: key);

  @override
  _CustomerVendorServicesScreenState createState() => _CustomerVendorServicesScreenState();
}

class _CustomerVendorServicesScreenState extends State<CustomerVendorServicesScreen> {

  CustomerVendorServicesController _getXController = Get.put(CustomerVendorServicesController());

  @override
  void initState() {
    // TODO: implement initState
    _getXController.vendorId = widget.vendorId;
    _getXController.categoryId = widget.categoryId;
    _getXController.refreshPage = refreshPage;
    _getXController.serviceData!.clear();

    Future.delayed(Duration.zero, () async {
      _getXController.hitVendorServicesApi();
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColor.themeBlue,
    ));

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [

            headerWidget(),

            profileDataWidget(),

            _getXController.serviceData!.isNotEmpty?
            servicesWidget()
                :SizedBox()
          ],
        ),
      ),
    );
  }


  ///*
  ///
  ///
  Widget headerWidget() {

    return Container(
      width: double.infinity,
      color: MyColor.themeBlue,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 23.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          InkWell(
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.white,)),

          Text('Services',
            style: const TextStyle(
                fontSize: MyDimens.textSize20,
                color: Colors.white,
                fontFamily: 'roboto_medium'
            ),),

          /*InkWell(
              onTap: (){
                Get.to(() => CustomerCartSummaryScreen(
                    categoryId: _getXController.categoryId,
                    currentAddress: widget.currentAddress,
                    vendorId: _getXController.vendorId,
                    country: widget.country,
                     ));
                },
              child: const Icon( Icons.shopping_cart, size: 18.0, color: Colors.white,)),*/

          SizedBox(height: 18.0, width: 18.0,)
        ],
      ),
    );

  }

  ///*
  ///
  ///
  ///
  profileDataWidget() {
    return  Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: _getXController.profileImage == "" ?
              Image(image:  noProfileImg,
                width: 80.0 ,height: 80.0, fit: BoxFit.fill,)
                  :
              Image.network(baseImageUrl + _getXController.profileImage,
                width: 80.0,height: 80.0, fit: BoxFit.fill,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                  return Image(
                      image: noImage, width: 80.0,height: 80.0, fit: BoxFit.fill);
                },)),

          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_getXController.vendorName,
                  style: TextStyle(
                      fontSize: MyDimens.textSize22,
                      color: Colors.black,
                      fontFamily: 'roboto_bold'
                  ),),

                Text(_getXController.categoryName,
                  style: TextStyle(
                      fontSize: MyDimens.textSize16,
                      color: MyColor.textGrey,
                      fontFamily: 'roboto_medium'
                  ),)
              ],
            ),
          )
        ],
      ),
    );
  }

  ///*
  ///
  ///
  servicesWidget() {
    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Row(
            children: [
              Text('Select services you need',
                style: TextStyle(
                    fontSize: MyDimens.textSize18,
                    color: Colors.black,
                    fontFamily: 'roboto_bold'
                ),),
            ],
          ),
        ),


        SizedBox(height: 10.0,),
        SingleChildScrollView(
          child: LayoutGrid(
            gridFit : GridFit.loose,
            // set some flexible track sizes based on the crossAxisCount
            columnSizes: [1.fr, 1.fr, 1.fr],
            // set all the row sizes to auto (self-sizing height)
            rowSizes: List<IntrinsicContentTrackSize>.generate(
                (_getXController.serviceData!.length / 2).round(),
                    (int index) => auto),
            rowGap: 15,
            columnGap: 5,
            // note: there's no childAspectRatio
            children: [
              // render all the cards with *automatic child placement*
              for (var index = 0; index < _getXController.serviceData!.length; index++)

                InkWell(
                  onTap: (){
                    Get.to(() => CustomerServiceInfoScreen(
                        vendorId: _getXController.vendorId,
                      categoryId: _getXController.categoryId,
                      serviceId: _getXController.serviceData![index].fkServiceId!,
                      vendorServiceId: _getXController.serviceData![index].id!,
                        customerAddressModel: widget.customerAddressModel
                       ));
                  },
                  child: Center(
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: _getXController.serviceData![index].fkServiceServiceImage == ""
                                ?
                            Image(image: noImage,
                              /*width: 90.0,*/ height: 114.0, fit: BoxFit.fill,)

                                : Image.network(baseImageUrl +
                                _getXController.serviceData![index].fkServiceServiceImage!,
                              /*width: 90,*/ height: 114, fit: BoxFit.fill,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return Image(
                                    image: noImage, /*width: 90,*/ height: 114, fit: BoxFit.fill);
                              },)),

                        SizedBox(height: 5.0,),

                        Text(_getXController.serviceData![index].fkServiceServiceName!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MyDimens.textSize13,
                              color: MyColor.themeBlue,
                              fontFamily: 'montserrat_medium'
                          ),),
                      ],
                    ),
                  ),
                )
            ],
          ),
        )

      ],
    );
  }

}
