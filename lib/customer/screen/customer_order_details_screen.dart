import 'dart:developer';

import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/screen/chat_screen.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/controller/customer_order_details_controller.dart';
import 'package:door_ap/customer/screen/customer_btm_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomerOrderDetailsScreen extends StatefulWidget {
  int orderPrimaryKey;
  String orderUniqueId;

  String callFrom;

  CustomerOrderDetailsScreen(
      {Key? key, required this.orderPrimaryKey, required this.orderUniqueId, required this.callFrom})
      : super(key: key);

  @override
  _CustomerOrderDetailsScreenState createState() =>
      _CustomerOrderDetailsScreenState();
}

class _CustomerOrderDetailsScreenState
    extends State<CustomerOrderDetailsScreen> {
  final CustomerOrderDetailsController _getXController =
      Get.put(CustomerOrderDetailsController());

  @override
  void initState() {
    // TODO: implement initState
    MySharedPreference.getInstance();
    _getXController.orderPrimaryKey = widget.orderPrimaryKey;
    _getXController.orderUniqueId = widget.orderUniqueId;

    _getXController.refreshPage = refreshPage;
    _getXController.clearData();
    Future.delayed(Duration.zero, () async {
      _getXController.hitGetOrderDetailsApi();
    });

    super.initState();
  }

  ///*
  ///
  ///
  void refreshPage() {
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
          body: Column(
            children: [
              headerWidget(),
              _getXController.orderPayload != null
                  ? Expanded(
                      child: Column(
                        children: [
                          orderDetailsWidget(),
                          Container(
                            margin: EdgeInsets.only(top: 0.0, bottom: 10.0),
                            height: 1,
                            color: MyColor.dividerColor,
                          ),

                          //vendor profile data
                          profileDataWidget(),

                          Container(
                            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            height: 1.0,
                            color: MyColor.dividerColor,
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              physics: ScrollPhysics(),
                              child: Column(
                                children: [
                                  cartDataWidget(), //add check later

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10.0),
                                          height: 1.0,
                                          color: MyColor.dividerColor,
                                        ),
                                      ),
                                      Text(
                                        'Payment Information',
                                        style: TextStyle(
                                            fontSize: MyDimens.textSize16,
                                            color: Colors.black,
                                            fontFamily: 'roboto_medium'),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10.0),
                                          height: 1.0,
                                          color: MyColor.dividerColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // paymentAndAddressDetails()

                                  paymentInformationWidget()
                                ],
                              ),
                            ),
                          ),


                          _getXController.reviewAndFeedback.isNotEmpty?
                          Container(
                            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            height: 1.0,
                            color: MyColor.dividerColor,
                          ):SizedBox(),

                          _getXController.reviewAndFeedback.isNotEmpty?
                          ratingAndReviewWidget()
                              : SizedBox(),

                          _getXController.status == "Started"
                              ? completeButtonWidget()
                              : _getXController.status == 'Completed' && _getXController.reviewAndFeedback.isEmpty
                                  ? leaveFeedbackButtonWidget()
                                  : _getXController.status == "Pending" ||
                                          _getXController.status == "Accepted"
                                      ? cancelOrderButton()
                                      : SizedBox()
                        ],
                      ),
                    )
                  : SizedBox()
            ],
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
      padding:
          const EdgeInsets.only(top: 15.0, left: 23.0, right: 23.0, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {

                    if(widget.callFrom == 'CheckoutScreen' || widget.callFrom == 'CurrentStartedOrder'){
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => CustomerBtmScreen() ),
                              (route) => false);

                    }else{
                      Get.back();
                    }
                    },

                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              Text(
                'Order Details',
                style: const TextStyle(
                    fontSize: MyDimens.textSize20,
                    color: Colors.white,
                    fontFamily: 'roboto_medium'),
              ),
              const SizedBox(
                height: 16,
                width: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///*
  ///
  /// order data
  orderDetailsWidget() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 10.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Order No:" + _getXController.orderId,
                  style: TextStyle(
                      fontSize: MyDimens.textSize18,
                      color: Colors.black,
                      fontFamily: 'roboto_bold'),
                ),
              ),
              Text(
                _getXController.status,
                style: TextStyle(
                    fontSize: MyDimens.textSize16,
                    color: getColor(_getXController.status),
                    fontFamily: 'montserrat_medium'),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            getFormattedDateTime(
                _getXController.bookingDate, _getXController.bookingTime),
            style: TextStyle(
                fontSize: MyDimens.textSize14,
                color: MyColor.black50,
                fontFamily: 'montserrat_medium'),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 3.0),
                          child: Image(
                            image: locationIcon,
                            color: MyColor.greenColor,
                            width: 15,
                            height: 18,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: _getXController.address,
                        style: TextStyle(
                            fontSize: MyDimens.textSize14,
                            color: MyColor.black50,
                            fontFamily: 'montserrat_medium'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  cartDataWidget() {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return Divider();
        },
        shrinkWrap: true,
        itemCount: _getXController.orderService.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: _getXController.orderService[index]
                                  .fkServiceFkServiceServiceImage ==
                              ""
                          ? Image(
                              image: noImage,
                              width: 70.0,
                              height: 70.0,
                              fit: BoxFit.fill,
                            )
                          : Image.network(
                              baseImageUrl +
                                  _getXController.orderService[index]
                                      .fkServiceFkServiceServiceImage!,
                              width: 70.0,
                              height: 70.0,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Image(
                                    image: noImage,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.fill);
                              },
                            ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _getXController.orderService[index]
                                        .fkServiceFkServiceServiceName!,
                                    style: TextStyle(
                                        fontSize: MyDimens.textSize16,
                                        color: Colors.black,
                                        fontFamily: 'roboto_bold'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Hour : ' +
                                  _getXController
                                      .orderService[index].fkServiceHour!,
                              style: TextStyle(
                                  fontSize: MyDimens.textSize12,
                                  color: Colors.black,
                                  fontFamily: 'montserrat_medium'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        '\$' +
                            _getXController.orderService[index].fkServicePrice
                                .toString(),
                        style: TextStyle(
                            fontSize: MyDimens.textSize16,
                            color: Colors.black,
                            fontFamily: 'roboto_bold'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  //
  ///
  ///
  /// Vendor profile data
  profileDataWidget() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _getXController.vendorName,
                  style: TextStyle(
                      fontSize: MyDimens.textSize20,
                      color: Colors.black,
                      fontFamily: 'roboto_bold'),
                ),
              ),

              SizedBox(width: 15,),

              _getXController.status == 'Accepted' || _getXController.status == 'Started'?
              InkWell(
                  onTap: (){
                    Get.to(() => ChatScreen(receiverId: _getXController.vendorUserId,
                                            receiverName: _getXController.vendorName,
                                            callFrom: "",));
                  },
                  child: Image(image: messageIcon, color: MyColor.orangeColor, width: 20, height: 20))
                  : SizedBox()

            ],
          ),
          Text(
            _getXController.categoryName,
            style: TextStyle(
                fontSize: MyDimens.textSize14,
                color: MyColor.black50,
                fontFamily: 'montserrat_medium'),
          )
        ],
      ),
    );
  }

  ///*
  ///
  ///
/*
  paymentAndAddressDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0, bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Service Address :',
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: MyColor.black50,
                      fontFamily: 'montserrat_medium'),
                ),
              ),

              Expanded(
                child: Text(
                  _getXController.address,
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: MyColor.black50,
                      fontFamily: 'montserrat_medium'),
                ),
              )
            ],
          ),

          SizedBox(height: 10.0,),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Payment Method :',
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: MyColor.black50,
                      fontFamily: 'montserrat_medium'),
                ),
              ),

              Expanded(
                child: Text(
                  '*** **** *** 027', //pending
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: MyColor.black50,
                      fontFamily: 'montserrat_medium'),
                ),
              )
            ],
          ),


          SizedBox(height: 10.0,),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Average Time :',
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: MyColor.black50,
                      fontFamily: 'montserrat_medium'),
                ),
              ),

              Expanded(
                child: Text(
                  _getXController.duration.toString() + " hr",
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: MyColor.black50,
                      fontFamily: 'montserrat_medium'),
                ),
              )
            ],
          ),


          SizedBox(height: 10.0,),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Total Amount :',
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: MyColor.black50,
                      fontFamily: 'montserrat_medium'),
                ),
              ),

              Expanded(
                child: Text(
                  '\$' + _getXController.totalAmount.toString(),
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: MyColor.black50,
                      fontFamily: 'montserrat_medium'),
                ),
              )
            ],
          )

        ],
      ),
    );
  }
*/

  ///*
  ///
  ///
  completeButtonWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0,),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              // margin: const EdgeInsets.only(top: 22.0, left: 23.0, right: 23.0, bottom: 30.0),
              child: ElevatedButton(
                  onPressed: () {
                    _getXController.hitCompleteOrderApi();
                  },
                  style: ElevatedButton.styleFrom(
                      // primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        // side: BorderSide(color: MyColor.themeBlue),
                      ),
                      elevation: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "Mark as Completed",
                      style: const TextStyle(
                          fontSize: MyDimens.textSize15,
                          color: Colors.white,
                          fontFamily: 'sf_pro_bold'),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }

  ///*
  ///
  ///
  leaveFeedbackButtonWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              // margin: const EdgeInsets.only(top: 22.0, left: 23.0, right: 23.0, bottom: 30.0),
              child: ElevatedButton(
                  onPressed: () {
                    showFeedBackModal();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      elevation: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "Leave Feedback",
                      style: const TextStyle(
                          fontSize: MyDimens.textSize15,
                          color: Colors.white,
                          fontFamily: 'sf_pro_bold'),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }

  ///*
  ///
  ///
  buttonsWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Row(
        children: [
          _getXController.status == 'Started'
              ? Expanded(
                  child: Container(
                    height: 45,
                    // margin: const EdgeInsets.only(top: 22.0, left: 23.0, right: 23.0, bottom: 30.0),
                    child: ElevatedButton(
                        onPressed: () {
                          _getXController.hitCompleteOrderApi();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: BorderSide(color: MyColor.themeBlue),
                            ),
                            elevation: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            "Complete",
                            style: const TextStyle(
                                fontSize: MyDimens.textSize15,
                                color: MyColor.themeBlue,
                                fontFamily: 'sf_pro_bold'),
                          ),
                        )),
                  ),
                )
              : SizedBox(),
          SizedBox(width: _getXController.status == 'Started' ? 20 : 0),
          Expanded(
            child: Container(
              height: 45,
              // margin: const EdgeInsets.only(top: 22.0, left: 23.0, right: 23.0, bottom: 30.0),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      elevation: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "Leave Feedback",
                      style: const TextStyle(
                          fontSize: MyDimens.textSize15,
                          color: Colors.white,
                          fontFamily: 'sf_pro_bold'),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }

  ///*
  ///
  ///
  cancelOrderButton() {
    return Container(
      height: 45,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: ElevatedButton(
          onPressed: () {
            _getXController.hitCancelOrderApi();
          },
          style: ElevatedButton.styleFrom(
              // primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                // side: BorderSide(color: MyColor.themeBlue),
              ),
              elevation: 5),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              "Cancel",
              style: const TextStyle(
                  fontSize: MyDimens.textSize15,
                  color: Colors.white,
                  fontFamily: 'sf_pro_bold'),
            ),
          )),
    );
  }

  ///*
  ///
  ///
  Future<bool> _onWillPop() async {
    // Navigator.of(context).popUntil((route) => route.isFirst);
    if(widget.callFrom == 'CheckoutScreen' || widget.callFrom == 'CurrentStartedOrder'){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => CustomerBtmScreen() ),
              (route) => false);

    }else{
      Get.back();
    }
    return false;
  }

  ///*
  ///
  ///
  String getFormattedDateTime(String bookDate, String? bookTime) {
    String bookDateTime = bookDate + " " + bookTime!;
    String formattedDateTime = '';
    formattedDateTime = DateFormat("MMM dd HH:mm")
        .format(DateTime.parse(bookDateTime.toString()));
    return formattedDateTime;
  }

  ///*
  ///
  ///
  getColor(String status) {
    if (status == 'Pending') {
      return Colors.orange;
    } else if (status == 'Completed' || status == 'Started') {
      return Colors.green;
    } else if (status == 'Rejected' || status == 'Cancelled') {
      return Colors.red;
    } else if (status == 'Accepted') {
      return MyColor.themeBlue;
    }
  }

  ///*
  ///
  ///
  paymentInformationWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /*Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Text('Payment Summary :',
               style: TextStyle(
                   fontSize: MyDimens.textSize18,
                   color: MyColor.themeBlue,
                   fontFamily: 'roboto_bold'
               ),),
           ],
         ),
*/
          //total Item
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Total Item',
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: Colors.black,
                      fontFamily: 'roboto_medium'),
                ),
              ),
              Text(
                _getXController.totalItem.toString(),
                style: TextStyle(
                    fontSize: MyDimens.textSize14,
                    color: Colors.black,
                    fontFamily: 'roboto_bold'),
              ),
            ],
          ),

          //total price
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Total Price ',
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: Colors.black,
                      fontFamily: 'roboto_medium'),
                ),
              ),
              Text(
                '\$' + _getXController.totalPrice.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: MyDimens.textSize14,
                    color: Colors.black,
                    fontFamily: 'roboto_bold'),
              ),
            ],
          ),

          SizedBox(
            height: _getXController.discount == 0? 0 : 5.0,),

          _getXController.discount == 0?
          SizedBox():
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Discount ',
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: Colors.black,
                      fontFamily: 'roboto_medium'),
                ),
              ),
              Text(
                '\$' + _getXController.discount.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: MyDimens.textSize14,
                    color: Colors.black,
                    fontFamily: 'roboto_bold'),
              ),
            ],
          ),

          //convenience fees
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Convenience Fees ',
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: Colors.black,
                      fontFamily: 'roboto_medium'),
                ),
              ),
              Text(
                '\$' + _getXController.convenienceFees.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: MyDimens.textSize14,
                    color: Colors.black,
                    fontFamily: 'roboto_bold'),
              ),
            ],
          ),

          //grand total
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Total Amount',
                  style: TextStyle(
                      fontSize: MyDimens.textSize16,
                      color: Colors.black,
                      fontFamily: 'roboto_bold'),
                ),
              ),
              Text(
                '\$' + _getXController.totalAmount.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: MyDimens.textSize16,
                    color: Colors.black,
                    fontFamily: 'roboto_bold'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  void showFeedBackModal() {

    showDialog(
        context: context, builder: (BuildContext buildContext){
        // return FeedbackDialog(getXController: _getXController,);
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('FEEDBACK',
                  style: TextStyle(
                      fontSize: MyDimens.textSize16,
                      color: MyColor.themeBlue,
                      fontFamily: 'montserrat_semiBold'
                  ),),


                SizedBox(height: 20,),

                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child:

                     _getXController.vendorImage == ""?
                    Image(image: noProfileImg, width: 100, height: 100, fit: BoxFit.fill)
                         :
                     Image.network(baseImageUrl + _getXController.vendorImage,
                       width: 100.0, height: 100.0, fit: BoxFit.fill,
                       errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                         return Image(
                             image: noProfileImg, width: 100, height: 100, fit: BoxFit.fill);
                       },
                     ),
                ),



                SizedBox(height: 20.0,),

                Text('Rate to ' + _getXController.vendorName,
                  style: TextStyle(
                      fontSize: MyDimens.textSize16,
                      color: MyColor.textGrey,
                      fontFamily: 'roboto_bold'
                  ),),


                SizedBox(height: 5.0,),
                RatingBar.builder(
                  tapOnlyMode: true,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _getXController.ratingValue = rating;
                    });
                    log('RATING COUNT ' + rating.toString());
                  },
                ),



                SizedBox(height: 20.0,),
                Text('Your Review is valuable for our service',
                  style: TextStyle(
                      fontSize: MyDimens.textSize16,
                      color: MyColor.textGrey,
                      fontFamily: 'roboto_bold'
                  ),),


                //review
                SizedBox(height: 20.0,),
                TextFormField(
                  onTap: () {
                    /*setState(() {
                    // _getXController.setAllErrorToFalse();
                  });*/
                  },
                  controller: _getXController.reviewEditController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                      fontSize:   MyDimens.textSize14,
                      color: Colors.black,
                      fontFamily: 'montserrat_medium'
                  ),
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    contentPadding:
                    const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10.0),
                    // labelText: 'Review',
                    hintText: 'Your Review',
                    // errorText: _getXController.isAboutMeEmpty ? "Please Enter about your self" : null ,
                  ),
                ),

                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: MyColor.themeBlue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),),),
                      child: const Text('Submit', style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        _getXController.hitFeedbackApi();
                      },
                    ),

                    SizedBox(width: 20,),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black12,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),),),
                      child: const Text('Dismiss', style: TextStyle(color: MyColor.themeBlue),),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),


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
  ratingAndReviewWidget() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                Text('Rating and Review',
                    style: TextStyle(
                      color: MyColor.themeBlue,
                      fontSize: MyDimens.textSize18,
                      fontFamily: 'roboto_bold'
                    ),),
              ],
            ),

            SizedBox(height: 5.0,),
            RatingBar.builder(
              initialRating: _getXController.rating,
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

            Row(
              children: [
                Expanded(
                  child: Text(_getXController.feedback,
                    style: TextStyle(
                        color: MyColor.textGrey,
                        fontSize: MyDimens.textSize13,
                        fontFamily: 'roboto_medium'
                    ),),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}