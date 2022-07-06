import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/customer/controller/customer_vendor_profile_controller.dart';
import 'package:door_ap/customer/controller/customer_vendors_controller.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:door_ap/customer/screen/customer_vendor_services_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:get/get.dart';

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

            profileDataWidget(),

            _getXController.reviewAndFeedbackData != null && _getXController.reviewAndFeedbackData!.isNotEmpty?
            reviewsAndFeedbackWidget()
                : SizedBox(),


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
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 23.0),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            InkWell(
                onTap: (){
                  Get.back();
                },
                child: Icon(Icons.arrow_back_ios, color: Colors.white,)),

            Text(MyString.profile!,
              style: const TextStyle(
                  fontSize: MyDimens.textSize20,
                  color: Colors.white,
                  fontFamily: 'roboto_medium'
              ),),

            const SizedBox(height: 16, width: 18,),

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
                        Icon(Icons.star, size: 15.0, color: MyColor.orangeColor,),
                        Icon(Icons.star, size: 15.0, color: MyColor.orangeColor),
                        Icon(Icons.star, size: 15.0, color: MyColor.orangeColor),
                        Icon(Icons.star, size: 15.0, color: MyColor.orangeColor),
                        Icon(Icons.star_border, size: 15.0, color: MyColor.orangeColor),

                        Text(_getXController.ratings,
                          style: TextStyle(
                              fontSize: MyDimens.textSize16,
                              color: Colors.black26,
                              fontFamily: 'roboto_bold'
                          ),
                        )

                      ],
                    ),
                  ),

                ],
              ),

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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

/*
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            children: [
                              Icon(Icons.star, size: 15.0, color: MyColor.orangeColor,),
                              Icon(Icons.star, size: 15.0, color: MyColor.orangeColor),
                              Icon(Icons.star, size: 15.0, color: MyColor.orangeColor),
                              Icon(Icons.star, size: 15.0, color: MyColor.orangeColor),
                              Icon(Icons.star_border, size: 15.0, color: MyColor.orangeColor),

                              Text("4.1",
                                style: TextStyle(
                                    fontSize: MyDimens.textSize16,
                                    color: Colors.black26,
                                    fontFamily: 'roboto_bold'
                                ),
                              )

                            ],
                          ),
                        ),
*/

                        Text(_getXController.reviewAndFeedbackData![index].date!,
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
                          child: Text(_getXController.reviewAndFeedbackData![index].serviceName!,
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


                    SizedBox(height: 20.0,),
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
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: _getXController.reviewAndFeedbackData!.length,
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: new FractionPaginationBuilder(
               activeFontSize: MyDimens.textSize18,
               color: MyColor.textGrey,
               activeColor: MyColor.themeBlue,
               fontSize: MyDimens.textSize18),
        ),
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
        margin: const EdgeInsets.only(top: 22.0, left: 23.0, right: 23.0),
        child: ElevatedButton(
            onPressed: (){
              Get.to(() => CustomerVendorServicesScreen(
                  vendorId: int.parse(_getXController.vendorId),
                  categoryId: _getXController.categoryId,
                  customerAddressModel: widget.customerAddressModel
                  ));
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



}
