import 'dart:developer';

import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/controller/customer_cart_summary_controller.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:door_ap/customer/model/response/customer_add_to_cart_response.dart';
import 'package:door_ap/customer/screen/customer_book_slot_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'customer_vendor_services_screen.dart';

class CustomerCartSummaryScreen extends StatefulWidget {
  int categoryId;
  int vendorId;
  CustomerAddressModel customerAddressModel;
  String callFrom;

  CustomerCartSummaryScreen({Key? key, required this.vendorId, required this.categoryId, required this.customerAddressModel, required this.callFrom}) : super(key: key);

  @override
  _CustomerCartSummaryScreenState createState() => _CustomerCartSummaryScreenState();
}

class _CustomerCartSummaryScreenState extends State<CustomerCartSummaryScreen> {
  CustomerCartSummaryController _getXController = Get.put(CustomerCartSummaryController());

  @override
  void initState() {
    // TODO: implement initState

    MySharedPreference.getInstance();
    MySharedPreference.setString(MyConstants.keyPromoCode, "");
    _getXController.categoryId = widget.categoryId;
    _getXController.countryName = widget.customerAddressModel.countryName;
    _getXController.vendorId    = widget.vendorId;
    _getXController.customerAddressModel = widget.customerAddressModel;
    _getXController.callFrom = widget.callFrom;
    _getXController.refreshPage = refreshPage;
    _getXController.cartData!.clear();

    Future.delayed(Duration.zero, () async{
      _getXController.hitCartCountApi();
    });
    Future.delayed(Duration.zero, () async{
      _getXController.hitGetCartItemApi();
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

                  SizedBox(height: 10.0,),

                  _getXController.cartData != null && _getXController.cartData!.isNotEmpty?
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [

                        Expanded(
                            child: cartDataWidget(),),


                        Padding(
                            padding: EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                              bottom: 20.0
                            ),
                            child: calculationWidget())
                      ],
                    ),
                  )
                  :Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image : emptyCartImg
                          ),

                          SizedBox(height: 10,),
                          Text('Cart is Empty',
                            style: TextStyle(
                                color: MyColor.themeBlue,
                                fontSize: MyDimens.textSize14,
                                fontFamily: 'roboto_bold'
                            ),),
                        ],
                      ),
                    ))



                ],
              ),
            ),
          ),
        ));
  }

  ///*
  ///
  ///
  cartDataWidget() {
    return
      ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: _getXController.cartData!.length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [

                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: _getXController
                              .cartData![index].fkVenderServiceFkServiceServiceImage ==
                              ""
                              ? Image(
                            image: noImage,
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.fill,
                          )
                              : Image.network(
                            baseImageUrl +
                                _getXController
                                    .cartData![index].fkVenderServiceFkServiceServiceImage!,
                            width: 100.0,
                            height: 100.0,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Image(
                                  image: noImage,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill);
                            },
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0 , right: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Text(
                                _getXController.cartData![index].fkVenderServiceFkServiceServiceName!,
                                style: TextStyle(
                                  fontSize: MyDimens.textSize18,
                                  color: Colors.black,
                                  fontFamily: 'roboto_medium'
                                ),
                              ),

                              SizedBox(height: 5,),
                              Text(
                                'Price : \$' + _getXController.cartData![index].price!.toString(),
                                style: TextStyle(
                                    fontSize: MyDimens.textSize12,
                                    color: Colors.black,
                                    fontFamily: 'roboto_medium'
                                ),
                              ),

                              SizedBox(height: 5,),
                              Text(
                                'Qty : ' + _getXController.cartData![index].quantity!.toString(),
                                style: TextStyle(
                                    fontSize: MyDimens.textSize12,
                                    color: Colors.black,
                                    fontFamily: 'roboto_medium'
                                ),
                              ),

                              SizedBox(height: 5,),
                              Text(
                                'Hours : ' + _getXController.cartData![index].hour! + 'hrs',
                                style: TextStyle(
                                    fontSize: MyDimens.textSize12,
                                    color: Colors.black,
                                    fontFamily: 'montserrat_regular'
                                ),
                              ),

                              Card(
                                child: Container(
                                  height: 40.0,
                                  width: 110.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          setState(() {
                                            if(_getXController.cartData![index].quantity! > 1){
                                              _getXController.cartData![index].quantity = _getXController.cartData![index].quantity! - 1;
                                              log('Cart summary Decrease Item : ' +  _getXController.cartData![index].quantity.toString());
                                              _getXController.hitUpdateCartItemApi(_getXController.cartData![index]);
                                            }
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Icon(Icons.remove, color: MyColor.themeBlue,),
                                        ),
                                      ),
                                      Text(_getXController.cartData![index].quantity!.toString(),
                                        style: TextStyle(
                                            fontSize: MyDimens.textSize14,
                                            color: MyColor.textGrey,
                                            fontFamily: 'montserrat_medium'
                                        ),),
                                      InkWell(
                                        onTap: (){
                                          setState(() {
                                            _getXController.cartData![index].quantity = _getXController.cartData![index].quantity! + 1;
                                            log('Cart summary Decrease Item : ' +  _getXController.cartData![index].quantity.toString());
                                            _getXController.hitUpdateCartItemApi(_getXController.cartData![index]);

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
                              ),

                            ],),
                        ),
                      ),

                      InkWell(
                          onTap: (){
                            _getXController.hitRemoveFromCartApi(_getXController.cartData![index].id!);
                          },
                          child: Icon(Icons.delete, color: MyColor.textGrey,))
                    ],
                  ),

                ],
              ),
            );
          });
  }

  ///*
  ///
  ///
  calculationWidget() {
    return Column(
      children: [
        Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Price Details :',
                      style: TextStyle(
                          fontSize: MyDimens.textSize16,
                          color: MyColor.themeBlue,
                          fontFamily: 'roboto_bold'
                      ),),
                  ],
                ),
                SizedBox(height: 10,),

                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text('Total Item',
                      style: TextStyle(
                        fontSize: MyDimens.textSize14,
                        color: Colors.black,
                        fontFamily: 'roboto_medium'
                      ),),
                    ),

                    Text(_getXController.itemCount.toString() ,
                      style: TextStyle(
                          fontSize: MyDimens.textSize14,
                          color: Colors.black,
                          fontFamily: 'roboto_bold'
                      ),),
                  ],
                ),

                SizedBox(height: 5.0,),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text('Total Price ',
                        style: TextStyle(
                            fontSize: MyDimens.textSize14,
                            color: Colors.black,
                            fontFamily: 'roboto_medium'
                        ),),
                    ),

                    Text('\$' +_getXController.subTotalPrice.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: MyDimens.textSize14,
                          color: Colors.black,
                          fontFamily: 'roboto_bold'
                      ),),
                  ],
                ),

                _getXController.isPromoCodeApplied?
                Column(children: [
                  SizedBox(height: 5.0,),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text('Discount ',
                          style: TextStyle(
                              fontSize: MyDimens.textSize14,
                              color: Colors.black,
                              fontFamily: 'roboto_medium'
                          ),),
                      ),

                      Text('\$' + _getXController.discount.toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: MyDimens.textSize14,
                            color: Colors.black,
                            fontFamily: 'roboto_bold'
                        ),),
                    ],
                  ),

                ],): SizedBox(),

                SizedBox(height: 5.0,),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text('Convenience Fees ',
                        style: TextStyle(
                            fontSize: MyDimens.textSize14,
                            color: Colors.black,
                            fontFamily: 'roboto_medium'
                        ),),
                    ),

                    Text('\$' +_getXController.convenienceFees.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: MyDimens.textSize14,
                          color: Colors.black,
                          fontFamily: 'roboto_bold'
                      ),),
                  ],
                ),

                SizedBox(height: 5.0,),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text('Total Amount',
                        style: TextStyle(
                            fontSize: MyDimens.textSize14,
                            color: Colors.black,
                            fontFamily: 'roboto_medium'
                        ),),
                    ),

                    Text( '\$' + _getXController.totalAmount.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: MyDimens.textSize14,
                          color: Colors.black,
                          fontFamily: 'roboto_bold'
                      ),),
                  ],
                ),

                //Promo code container
                SizedBox(height: 10.0,),
                _getXController.isPromoCodeApplied?
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(_getXController.promoCodeMsg,
                          style: TextStyle(
                              fontSize: MyDimens.textSize14,
                              color: Colors.green,
                              fontFamily: 'roboto_medium'
                          ),),
                      ),

                      InkWell(
                        onTap: (){
                          setState(() {
                            _getXController.isCodeDataValid('CancelCode');
                            _getXController.isPromoCodeClick = false;
                          });
                        },
                        child: Text('Remove',
                          style: TextStyle(
                              fontSize: MyDimens.textSize14,
                              color: Colors.red,
                              fontFamily: 'roboto_bold'
                          ),),
                      ),
                    ],
                  )
                :Row(
                  children: [
                    !_getXController.isPromoCodeClick?
                    Expanded(
                      child: InkWell(
                        onTap:(){
                          setState(() {
                            _getXController.isPromoCodeClick = !_getXController.isPromoCodeClick;
                          });
                        },
                        child: Text('Apply promo code',
                          style: TextStyle(
                              fontSize: MyDimens.textSize14,
                              color: Colors.red,
                              fontFamily: 'roboto_medium'
                          ),),
                      ),
                    ):
                    Expanded(
                      child: TextFormField(
                        controller: _getXController.promoCodeController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                            fontSize: MyDimens.textSize14,
                            color: Colors.black,
                            fontFamily: 'roboto_bold'
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                          const EdgeInsets.symmetric(
                              vertical: 0.0,
                              horizontal: 10.0),
                          border: OutlineInputBorder(),
                          hintText: 'Enter Promo Code',
                          errorText: _getXController.isPromoCodeEmpty? 'Please enter promo code' : null,
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              InkWell(
                                 onTap: (){
                                   setState(() {
                                     _getXController.isCodeDataValid('ApplyCode');
                                   });
                                 },
                                  child: Icon(Icons.check, color: Colors.green,)),
                              SizedBox(width: 20.0,),
                              InkWell(
                                  onTap: (){
                                    setState(() {
                                      _getXController.promoCodeController.clear();
                                      _getXController.isPromoCodeClick = !_getXController.isPromoCodeClick;
                                    });
                                  },
                                  child: Icon(Icons.clear, color: Colors.red,)),
                              SizedBox(width: 10.0,),

                            ],
                          )
                        ),
                      ),
                    )

                  ],
                )

              ],
            ),
          ),
        ),

        SizedBox(height: 10.0,),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 45,
                // margin: const EdgeInsets.only(top: 22.0, left: 23.0, right: 23.0, bottom: 30.0),
                child: ElevatedButton(
                    onPressed: (){
                      if(_getXController.callFrom == 'ServiceInfo'){
                        Navigator.pushReplacement(Get.context!,
                            MaterialPageRoute(
                                builder: (BuildContext context) => CustomerVendorServicesScreen(
                                    vendorId: _getXController.vendorId,
                                    categoryId: _getXController.categoryId,
                                    customerAddressModel: _getXController.customerAddressModel
                                )));
                      }else{
                        Get.back();
                      }
                      },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                        side: BorderSide(color: MyColor.themeBlue),),
                        elevation: 5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text("Add more",
                        style: const TextStyle(
                            fontSize: MyDimens.textSize15,
                            color: MyColor.themeBlue,
                            fontFamily: 'sf_pro_bold'
                        ),),
                    )),
              ),
            ),
            SizedBox(width: 20,),

            Expanded(
              child: Container(
                height: 45,
                // margin: const EdgeInsets.only(top: 22.0, left: 23.0, right: 23.0, bottom: 30.0),
                child: ElevatedButton(
                    onPressed: (){
                      if(_getXController.cartData!.isNotEmpty) {
                        Get.to(
                                () =>
                                CustomerBookSlotScreen(
                                    customerAddressModel: widget.customerAddressModel,
                                    vendorId: widget.vendorId,
                                    categoryId: widget.categoryId,
                                    cartData: _getXController.cartData!,
                                    calculation: _getXController.calculation
                                ));
                      }
                    },
                    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),),
                        elevation: 5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text("Book now",
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
      ],
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

              if(_getXController.callFrom == 'ServiceInfo'){
                Navigator.pushReplacement(Get.context!,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CustomerVendorServicesScreen(
                            vendorId: _getXController.vendorId,
                            categoryId: _getXController.categoryId,
                            customerAddressModel: _getXController.customerAddressModel
                        )));
              }else{
                Get.back();
              }

            },
            child: Icon(Icons.arrow_back_ios, color: Colors.white,)),

        Text('Summary',
          style: const TextStyle(
              fontSize: MyDimens.textSize20,
              color: Colors.white,
              fontFamily: 'roboto_medium'
          ),),

        SizedBox(height: 18 , width: 18,)
      ],
    ),
  );
}

  ///*
  ///
  ///
  Future<bool> _onWillPop() async {
    if(_getXController.callFrom == 'ServiceInfo'){
      Navigator.pushReplacement(Get.context!,
          MaterialPageRoute(
              builder: (BuildContext context) => CustomerVendorServicesScreen(
                  vendorId: _getXController.vendorId,
                  categoryId: _getXController.categoryId,
                  customerAddressModel: _getXController.customerAddressModel
              )));
    }else{
      Get.back();
    }
    return false;
  }


}

