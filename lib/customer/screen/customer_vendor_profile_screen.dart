import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/global_data.dart';
import 'package:door_ap/customer/controller/customer_vendor_profile_controller.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:door_ap/customer/screen/customer_vendor_services_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'cuatomer_cart_summary_screen.dart';

class CustomerVendorProfileScreen extends StatefulWidget {
  String vendorId;
  int categoryId;
  CustomerAddressModel customerAddressModel;

  CustomerVendorProfileScreen({Key? key, required this.vendorId, required this.categoryId, required this.customerAddressModel,
                              }) : super(key: key);

  @override
  _CustomerVendorProfileScreenState createState() => _CustomerVendorProfileScreenState();
}

class _CustomerVendorProfileScreenState extends State<CustomerVendorProfileScreen> {

    CustomerVendorProfileController _getXController = Get.put(CustomerVendorProfileController());

  @override
  void initState() {
    // TODO: implement initState
    _getXController.vendorId = widget.vendorId;
    _getXController.categoryId = widget.categoryId;
    _getXController.refreshPage = refreshPage;
    _getXController.clearData();
    Future.delayed(Duration.zero, () async {
      _getXController.hitVendorProfileApi();
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

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                  profileDataWidget(),

                  _getXController.reviewAndFeedbackData != null && _getXController.reviewAndFeedbackData!.isNotEmpty?
                  reviewsAndFeedbackWidget()
                      : SizedBox(),


                ],),
              ),
            ),

            continueButtonWidget()

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
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),

        child: Row(
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
                child: Text(MyString.profile!,
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
      );

    }


    ///*
    ///
    ///
    profileDataWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 23.0, right: 23.0),
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
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
          ),

          //About me
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MyString.aboutMe!,
                    style: TextStyle(
                        fontSize: MyDimens.textSize16,
                        color: Colors.black,
                        fontFamily: 'roboto_bold'
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      _getXController.aboutVendor,
                      style: TextStyle(
                          fontSize: MyDimens.textSize14,
                          color: MyColor.textGrey,
                          fontFamily: 'roboto_medium'
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),

          //ratings
          SizedBox(height: 15.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getXController.ratings != 0?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ratings',
                    style: TextStyle(
                        fontSize: MyDimens.textSize16,
                        color: Colors.black,
                        fontFamily: 'roboto_bold'
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: [

                        RatingBar.builder(
                          initialRating: _getXController.ratings,
                          ignoreGestures : true,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 15,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                          },
                        ),

                        SizedBox(width: 5,),
                        Text(_getXController.ratings.toStringAsFixed(1),
                          style: TextStyle(
                              fontSize: MyDimens.textSize14,
                              color: MyColor.textGrey,
                              fontFamily: 'roboto_bold'
                          ),
                        ),

                        SizedBox(width: 5,),
                        Text( '(' + getFormatedAvgRating(_getXController.avgRatingCount) + ')',
                          style: TextStyle(
                              fontSize: MyDimens.textSize14,
                              color: MyColor.textGrey,
                              fontFamily: 'roboto_bold'
                          ),
                        )


                      ],
                    ),
                  ),

                ],
              ): SizedBox()

              /*Image(
                image: blueChatIcon,
                color: Colors.indigoAccent,
                height: 32.0,
                width: 32.0,
              )*/
            ],
          )


        ],
      ),
    );
  }


    ///*
    ///
    ///
   reviewsAndFeedbackWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 23.0, right: 23.0, top: 20.0),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                MyString.reviewsAndFeedback!,
                style: TextStyle(
                    fontSize: MyDimens.textSize22,
                    color: Colors.black,
                    fontFamily: 'roboto_bold'),
              ),
              InkWell(
                onTap: (){
                  // Get.to(const CustomerAllCategoryScreen());
                },

                child: Text(
                  "View all",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: MyDimens.textSize14,
                      color: MyColor.labelGrey,
                      fontFamily: 'roboto_bold'),
                ),
              ),
            ],
          ),

          SizedBox(height: 5.0,),
          reviewSlider(),
        ],
      ),
    );
   }

    ///*
    ///
    ///
  reviewSlider() {
    return Container(
      height: 200,
      child: Swiper(
        containerHeight: 200,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              child: Container(
                height: 200,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),

                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            children: [
                              RatingBar.builder(
                                initialRating: _getXController.reviewAndFeedbackData![index].rating!,
                                ignoreGestures : true,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 15,
                                itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                },
                              ),

                              SizedBox(width: 5.0,),
                              Text(_getXController.reviewAndFeedbackData![index].rating.toString(),
                                style: TextStyle(
                                    fontSize: MyDimens.textSize16,
                                    color: MyColor.textGrey,
                                    fontFamily: 'roboto_bold'
                                ),
                              )

                            ],
                          ),
                        ),

                        Text(getDate(_getXController.reviewAndFeedbackData![index].reviewDate!),
                             style: TextStyle(
                               color: MyColor.textGrey,
                               fontSize: MyDimens.textSize12,
                               fontFamily: 'montserrat_semiBold'
                             ),),
                      ],
                    ),


                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Expanded(
                          child: Text(_getXController.reviewAndFeedbackData![index].fkOrderdetailsFkCategoryCategoryName!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: MyDimens.textSize18,
                                fontFamily: 'roboto_bold'
                            ),),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Expanded(
                          child: Text(_getXController.reviewAndFeedbackData![index].feedback!,
                            style: TextStyle(
                                color: MyColor.textGrey,
                                fontSize: MyDimens.textSize14,
                                fontFamily: 'roboto_medium'
                            ),),
                        ),
                      ],
                    ),


                    /*SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_getXController.reviewAndFeedbackData![index].totalPrice!.toString() ,
                          style: TextStyle(
                              color: MyColor.themeBlue,
                              fontSize: MyDimens.textSize12,
                              fontFamily: 'roboto_bold'
                          ),),

                        Text(_getXController.reviewAndFeedbackData![index].pricePerHour!.toString() ,
                          style: TextStyle(
                              color: MyColor.themeBlue,
                              fontSize: MyDimens.textSize12,
                              fontFamily: 'roboto_bold'
                          ),),

                        Text(_getXController.reviewAndFeedbackData![index].hour!.toString() ,
                          style: TextStyle(
                              color: MyColor.themeBlue,
                              fontSize: MyDimens.textSize12,
                              fontFamily: 'roboto_bold'
                          ),),
                      ],
                    )*/
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: _getXController.reviewAndFeedbackData!.length,
        pagination: _getXController.reviewAndFeedbackData!.length != 1 ? SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: new FractionPaginationBuilder(
               activeFontSize: MyDimens.textSize18,
               color: MyColor.textGrey,
               activeColor: MyColor.themeBlue,
               fontSize: MyDimens.textSize18),
        ) : null,
      ),
    );

  }

  ///*
    ///
    ///
  continueButtonWidget() {
    return
      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 10.0, left: 23.0, right: 23.0, bottom: 10),
        child: ElevatedButton(
            onPressed: () async{
              var nav = await Get.to(() => CustomerVendorServicesScreen(
                  vendorId: int.parse(_getXController.vendorId),
                  categoryId: _getXController.categoryId,
                  customerAddressModel: widget.customerAddressModel
                  ));

              if(nav == null){
                setState(() {});
              }
            },
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),),
                elevation: 5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text("Continue",
                style: const TextStyle(
                    fontSize: MyDimens.textSize15,
                    color: Colors.white,
                    fontFamily: 'sf_pro_bold'
                ),),
            )),
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
  String getDate(String date) {
    String weekday = DateFormat("dd MMMM yyyy").format(DateTime.parse(date.toString()));
    return weekday;

  }

  ///*
    ///
    ///
  String getFormatedAvgRating(String avgRatingCount) {
    String avgRating = '';
    var _formattedNumber = NumberFormat.compact().format(int.parse(avgRatingCount));
    avgRating = _formattedNumber;
    return avgRating;
  }



}
