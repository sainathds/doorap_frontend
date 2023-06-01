import 'dart:developer';

import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/screen/chat_screen.dart';
import 'package:door_ap/common/utils/global_data.dart';
import 'package:door_ap/customer/controller/customer_vendors_controller.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:door_ap/customer/screen/cuatomer_cart_summary_screen.dart';
import 'package:door_ap/customer/screen/customer_vendor_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CustomerVendorsScreen extends StatefulWidget {

  // Payload serviceData;

  String serviceOrCategoryName;
  String categoryId;
  CustomerAddressModel customerAddressModel;

  CustomerVendorsScreen({Key? key, required this.serviceOrCategoryName, required this.categoryId, required this.customerAddressModel,}) : super(key: key);

  @override
  _CustomerVendorsScreenState createState() => _CustomerVendorsScreenState();
}

class _CustomerVendorsScreenState extends State<CustomerVendorsScreen> {
  CustomerVendorsController _getXController = Get.put(CustomerVendorsController());

  @override
  void initState() {
    // TODO: implement initState
    _getXController.categoryId = widget.categoryId;
    _getXController.serviceOrCategoryName = widget.serviceOrCategoryName;
    _getXController.customerAddressModel = widget.customerAddressModel;

    _getXController.refreshPage = refreshPage;
    _getXController.vendorsData!.clear();

    //get near by vendors of selected category
    Future.delayed(Duration.zero, () async {
      _getXController.hitCustomerVendorsApi();
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


            _getXController.vendorsData != null && _getXController.vendorsData!.isNotEmpty?
            vendorsListWidget()
                : Expanded(
                  child: Center(
              child: Text("No vendors are found",
              style: TextStyle(fontSize: MyDimens.textSize14, color: MyColor.labelGrey, fontFamily: 'sf_pro_semibold'),),),
                )
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
      padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0, bottom: 10),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                      height: 40,
                      width: 50,
                      child: Icon(Icons.arrow_back_ios, color: Colors.white,))),

              Expanded(
                child: Center(
                  child: Text(_getXController.serviceOrCategoryName,
                    style: const TextStyle(
                        fontSize: MyDimens.textSize20,
                        color: Colors.white,
                        fontFamily: 'roboto_medium'
                    ),),
                ),
              ),

              cartIconWidget()
            ],
          ),

          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(widget.customerAddressModel.address,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: MyDimens.textSize12,
                      color: Colors.white,
                      fontFamily: 'roboto_medium'
                  ),),
              ),

            ],
          )
        ],
      ),


    );

  }

  ///*
  ///
  ///
  vendorsListWidget() {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: SingleChildScrollView(
        child: LayoutGrid(
            gridFit : GridFit.loose,
            columnSizes: [1.fr, 1.fr,],
            rowSizes: List<IntrinsicContentTrackSize>.generate(
                (_getXController.vendorsData!.length / 2).round(),
                    (int index) => auto),
            rowGap: 10,
            columnGap: 5,
            children: [
            for (var index = 0; index < _getXController.vendorsData!.length; index++)
              InkWell(
                onTap: () async{

                  //by selecting vendor redirect to that vendor profile screen
                var nav = await Get.to(() => CustomerVendorProfileScreen(vendorId: _getXController.vendorsData![index].fkVendorId.toString(),
                                                          categoryId: int.parse(_getXController.categoryId),
                                                          customerAddressModel: widget.customerAddressModel));

                if(nav == null){
                  setState(() {});
                }
                },
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: MyColor.themeBlue
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 175,
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    child: _getXController.vendorsData![index].fkVendorProfileImage == "" ?
                                    Image(image:  noProfileImg,
                                      height: 150.0, fit: BoxFit.fill,)
                                        :
                                    Image.network(baseImageUrl + _getXController.vendorsData![index].fkVendorProfileImage!,
                                      height: 150.0, fit: BoxFit.fill,
                                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                        return Image(
                                            image: noProfileImg, height: 150, fit: BoxFit.fill);
                                      },)),
                              ),

                              /*Positioned(
                                bottom: 5,
                                  right: 15,
                                  child: InkWell(
                                    onTap: (){
                                      Get.to(() => ChatScreen(
                                          receiverId: _getXController.vendorsData![index].fkVendorFkUserId!,
                                          receiverName: _getXController.vendorsData![index].fkVendorFullName!,
                                          callFrom: "",));
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50), ),
                                elevation: 5,
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: MyColor.inactiveOtp
                                    ),
                                    child: Image(image: messageIcon,),
                                ),
                              ),
                                  )),
*/
                              //like dislike
                              Positioned(
                                top: 10,
                                right: 10,
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      _getXController.vendorsData![index].likeDislike = !_getXController.vendorsData![index].likeDislike!;
                                      _getXController.hitLikeDislikeApi(_getXController.vendorsData![index].fkVendorId!,
                                          _getXController.vendorsData![index].likeDislike.toString().capitalizeFirst!);
                                    });
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50),),
                                    elevation: 5,
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: MyColor.inactiveOtp
                                      ),
                                      child: Icon(
                                        Icons.favorite,
                                        color: _getXController.vendorsData![index].likeDislike! ? Colors.red : Colors.black26),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),

                        //rating
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, ),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.white, size: 20.0,),

                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  _getXController.vendorsData![index].rating!.toStringAsFixed(1),
                                  style: TextStyle(
                                    fontSize: MyDimens.textSize12,
                                    color: Colors.white,
                                    fontFamily: 'sf_pro_regular'
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        //vendor name
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  _getXController.vendorsData![index].fkVendorFullName!,
                                  style: TextStyle(
                                    fontSize: MyDimens.textSize14,
                                    color: Colors.white,
                                    fontFamily: 'roboto_bold'
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              )
          ]
        ),
      ),
    ),
  );
  }

  ///*
  ///
  ///
  Widget cartIconWidget() {
    return InkWell(
      onTap: () async{
        if(GlobalData.cartCount != 0){

         var nav = await Get.to(() => CustomerCartSummaryScreen(
              categoryId: GlobalData.cartCategoryId,
              vendorId: GlobalData.vendorId,
              customerAddressModel: widget.customerAddressModel,
              callFrom: 'CartCount'
          ));

          if(nav == null){
            setState(() {});
          }
        }else{
          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) =>
                OKDialog(
                  title: "",
                  descriptions: 'Cart is empty',
                  img: emptyCartImg,
                  text: '',
                  key: null,
                ),
          );
        }


      },
      child: Container(
        width: 50,
        height: 40,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 5,
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
            ),

            GlobalData.cartCount != 0?

            Positioned(
              top: 2,
              right: 15,
              child: Container(
                height: 18,
                width: 18,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyColor.orangeColor,
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Text(
                  GlobalData.cartCount.toString(),
                  style: TextStyle(
                      color: MyColor.themeBlue,
                      fontFamily: 'roboto_bold',
                      fontSize: MyDimens.textSize10),
                ),
              ),
            ):
            SizedBox()
          ],
        ),
      ),
    );

  }

}
