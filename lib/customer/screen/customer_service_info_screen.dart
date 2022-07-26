import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/utils/global_data.dart';
import 'package:door_ap/customer/controller/customer_service_info_controller.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'cuatomer_cart_summary_screen.dart';
import 'customer_vendor_services_screen.dart';

class CustomerServiceInfoScreen extends StatefulWidget {

  int vendorId;
  int categoryId;
  int serviceId;
  int vendorServiceId; //sevice provided by vendor

  CustomerAddressModel customerAddressModel;

  CustomerServiceInfoScreen({Key? key, required this.vendorId, required this.categoryId, required this.serviceId, required this.vendorServiceId,
                            required this.customerAddressModel,}) : super(key: key);

  @override
  _CustomerServiceInfoScreenState createState() => _CustomerServiceInfoScreenState();
}

class _CustomerServiceInfoScreenState extends State<CustomerServiceInfoScreen> {

  CustomerServiceInfoController _getXController = Get.put(CustomerServiceInfoController());

  @override
  void initState() {
    // TODO: implement initState
    _getXController.vendorId = widget.vendorId;
    _getXController.categoryId = widget.categoryId;
    _getXController.serviceId = widget.serviceId;
    _getXController.vendorServiceId = widget.vendorServiceId;
    _getXController.customerAddressModel = widget.customerAddressModel;

    _getXController.includeFacility.clear();
    _getXController.excludeFacility.clear();
    _getXController.refreshPage = refreshPage;
    Future.delayed(Duration.zero, () async {
      _getXController.hitServiceInfoApi();
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
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [

                headerWidget(),

                serviceDataWidget(),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 23.0, right: 23.0, top: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // includeFacilityWidget(),

                          Text(
                            'Services Included',
                            style: TextStyle(
                                fontSize: MyDimens.textSize18,
                                color: Colors.black,
                                fontFamily: 'roboto_bold'
                            ),
                          ),

                          _getXController.includeFacility.isNotEmpty?
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _getXController.includeFacility.length,
                              itemBuilder: (BuildContext context, int index){
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.check, color: MyColor.themeBlue, size: 15,),
                                      SizedBox(width: 10.0,),
                                      Expanded(
                                        child: Text(
                                            _getXController.includeFacility[index].fkVenderFacilityFacilityName!,
                                          style: TextStyle(
                                              fontSize: MyDimens.textSize14,
                                              color: Colors.black,
                                              fontFamily: 'montserrat_regular'
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }) :
                          Text(
                            'Services are not Included',
                            style: TextStyle(
                                fontSize: MyDimens.textSize16,
                                color: Colors.grey,
                                fontFamily: 'roboto_bold'
                            ),
                          ),

                          // excludeFacilityWidget(),

                          SizedBox(height: 20.0,),
                          Text(
                            'Services Excluded',
                            style: TextStyle(
                                fontSize: MyDimens.textSize18,
                                color: Colors.black,
                                fontFamily: 'roboto_bold'
                            ),
                          ),

                          _getXController.excludeFacility.isNotEmpty?
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _getXController.excludeFacility.length,
                              itemBuilder: (BuildContext context, int index){
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.clear, color: MyColor.themeBlue, size: 15,),
                                      SizedBox(width: 10.0,),
                                      Expanded(
                                        child: Text(
                                          _getXController.excludeFacility[index].facilityName!,
                                          style: TextStyle(
                                              fontSize: MyDimens.textSize14,
                                              color: Colors.black,
                                              fontFamily: 'montserrat_regular'
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }):
                          Text(
                            'Excluded Services are not found',
                            style: TextStyle(
                                fontSize: MyDimens.textSize16,
                                color: Colors.grey,
                                fontFamily: 'roboto_bold'
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                addToCartButton(),

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
  Widget headerWidget() {

    return Container(
      width: double.infinity,
      color: MyColor.themeBlue,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          InkWell(
              onTap: (){
                Navigator.pushReplacement(Get.context!,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CustomerVendorServicesScreen(
                            vendorId: _getXController.vendorId,
                            categoryId: _getXController.categoryId,
                            customerAddressModel: _getXController.customerAddressModel
                        )));
              },
              child: Container(
                  height: 40,
                  width: 50,
                  child: Icon(Icons.arrow_back_ios, color: Colors.white,))),

          Expanded(
            child: Center(
              child: Text(_getXController.serviceName,
                style: const TextStyle(
                    fontSize: MyDimens.textSize20,
                    color: Colors.white,
                    fontFamily: 'roboto_medium'
                ),),
            ),
          ),

          // const Icon( Icons.shopping_cart, size: 18.0, color: Colors.white,),

          cartIconWidget()
        ],
      ),
    );

  }

  ///*
  ///
  ///
  serviceDataWidget() {
    return Container(
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
              child: _getXController.serviceImage == "" ?
               Image(image: noImage,
                width: double.infinity,height: 200.0, fit: BoxFit.fill,)

                  : Image.network(baseImageUrl +
                  _getXController.serviceImage,
                width: double.infinity,height: 200.0, fit: BoxFit.fill,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Image(
                      image: noImage, width: double.infinity,height: 200.0, fit: BoxFit.fill);
                },)
          ),


          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Avg. Time Duration:  ${_getXController.hours}',
                  style: TextStyle(
                    fontSize: MyDimens.textSize14,
                    color: Colors.white,
                    fontFamily: 'roboto_bold'
                  ),
                ),

                Text(
                  'Price:  \$${_getXController.price}',
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: Colors.white,
                      fontFamily: 'roboto_bold'
                  ),
                )
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
  excludeFacilityWidget() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 23.0, right: 23.0, top: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Services Included',
              style: TextStyle(
                  fontSize: MyDimens.textSize18,
                  color: Colors.black,
                  fontFamily: 'roboto_bold'
              ),
            ),

            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          Icon(Icons.check),
                          SizedBox(width: 5.0,),
                          Expanded(
                            child: Text(
                              'Single knob/inlet tap rapair (kitchen sink, wash basin, bathroom)',
                              style: TextStyle(
                                  fontSize: MyDimens.textSize14,
                                  color: Colors.black,
                                  fontFamily: 'montserrat_regular'
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );

  }

  ///*
  ///
  ///
  includeFacilityWidget() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 23.0, right: 23.0, top: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Services Included',
              style: TextStyle(
                  fontSize: MyDimens.textSize18,
                  color: Colors.black,
                  fontFamily: 'roboto_bold'
              ),
            ),

            Expanded(
              child: ListView.builder(
                 shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          Icon(Icons.check),
                          SizedBox(width: 5.0,),
                          Expanded(
                            child: Text(
                              'Single knob/inlet tap rapair (kitchen sink, wash basin, bathroom)',
                              style: TextStyle(
                                  fontSize: MyDimens.textSize14,
                                  color: Colors.black,
                                  fontFamily: 'montserrat_regular'
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  ///*
  ///
  ///
  addToCartButton() {
    return
      Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 20.0, left: 23.0, right: 23.0),
        child: Row(
          children: [
            Expanded(child: Card(
              elevation: 10,
              child: Container(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          if(_getXController.quantity > 1){
                            _getXController.quantity = _getXController.quantity - 1;
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.remove, color: MyColor.themeBlue,),
                      ),
                    ),

                    Text(_getXController.quantity.toString(),
                    style: TextStyle(
                      fontSize: MyDimens.textSize18,
                      color: MyColor.textGrey,
                      fontFamily: 'roboto_bold'
                    ),),


                    InkWell(
                      onTap: (){
                        setState(() {
                          _getXController.quantity = _getXController.quantity + 0001;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.add, color: MyColor.themeBlue,),
                      ),
                    )

                  ],
                ),
              ),
            )),

            SizedBox(width: 20,),

            Expanded(
              child: Container(
                height: 50,
                // margin: const EdgeInsets.only(top: 22.0, left: 23.0, right: 23.0, bottom: 30.0),
                child: ElevatedButton(
                    onPressed: (){
                      _getXController.hitAddToCartApi();
                    },
                    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),),
                        elevation: 5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text("Add to cart",
                        style: const TextStyle(
                            fontSize: MyDimens.textSize15,
                            color: Colors.white,
                            fontFamily: 'sf_pro_bold'
                        ),),
                    )),
              ),
            ),
          ],
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


  ///*
  ///
  ///
  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(Get.context!,
        MaterialPageRoute(
            builder: (BuildContext context) => CustomerVendorServicesScreen(
                vendorId: _getXController.vendorId,
                categoryId: _getXController.categoryId,
                customerAddressModel: _getXController.customerAddressModel
            )));
    return false;
  }

}
