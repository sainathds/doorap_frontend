import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/vendor/controller/vendor_order_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VendorOrderDetailsScreen extends StatefulWidget {

  int orderPrimaryKey;
  String orderUniqueId;

  VendorOrderDetailsScreen({Key? key, required this.orderPrimaryKey, required this.orderUniqueId}) : super(key: key);



  @override
  _VendorOrderDetailsScreenState createState() => _VendorOrderDetailsScreenState();
}

class _VendorOrderDetailsScreenState extends State<VendorOrderDetailsScreen> {

  final VendorOrderDetailsController _getXController = Get.put(VendorOrderDetailsController());

  @override
  void initState() {
    // TODO: implement initState
    _getXController.orderPrimaryKey = widget.orderPrimaryKey;
    _getXController.orderUniqueId = widget.orderUniqueId;
    _getXController.refreshPage = refreshPage;
    _getXController.clearData();
    Future.delayed(Duration.zero, () async{
      _getXController.hitGetOrderDetailsApi();
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

            _getXController.orderPayload != null ?
            Expanded(
              child: Column(
                children: [
                  orderDetailsWidget(),
                  Container(
                    margin: EdgeInsets.only( top: 0.0, bottom: 10.0),
                    height: 1,
                    color: MyColor.dividerColor,
                  ),


                  ///*
                  ///
                  ///
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

                        ],),
                    ),
                  ),


                  _getXController.status == 'Pending'?
                      pendingOrdersButton()
                      :_getXController.status == 'Accepted'?
                      acceptedOrderButton()
                      :SizedBox()

                ],
              ),
            ): SizedBox()
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
      padding:
      const EdgeInsets.only(top: 15.0, left: 23.0, right: 23.0, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
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
  /// order data and customer name
  orderDetailsWidget() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 10.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [

          Row(children: [
            Expanded(
              child: Text(
                _getXController.customerName,
                style: TextStyle(
                    fontSize: MyDimens.textSize18,
                    color: Colors.black,
                    fontFamily: 'roboto_bold'),
              ),
            ),
          ],),

          SizedBox(height: 5.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Order No: " + _getXController.orderId,
                  style: TextStyle(
                      fontSize: MyDimens.textSize16,
                      color: Colors.black,
                      fontFamily: 'roboto_medium'),
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

          SizedBox(height: 5.0,),
          Text(
            getFormattedDateTime(_getXController.bookingDate, _getXController.bookingTime),
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
                        text: _getXController.serviceAddress,
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
                  _getXController.serviceAddress,
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
                  'Total Time :',
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
                  '\$' + _getXController.totalAmount.toStringAsFixed(2),
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
  cartDataWidget() {
    return
      ListView.separated(
          physics: NeverScrollableScrollPhysics(),

          separatorBuilder: (context, index) {
            return Divider();
          },
          shrinkWrap: true,
          itemCount: _getXController.orderService.length,
          itemBuilder: (BuildContext context, int index){
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
                        child: _getXController
                            .orderService[index].fkServiceFkServiceServiceImage ==
                            ""
                            ? Image(
                          image: noImage,
                          width: 70.0,
                          height: 70.0,
                          fit: BoxFit.fill,
                        )
                            : Image.network(
                          baseImageUrl +
                              _getXController
                                  .orderService[index].fkServiceFkServiceServiceImage!,
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
                          padding: const EdgeInsets.only(left: 20.0 , right: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _getXController.orderService[index].fkServiceFkServiceServiceName!,
                                      style: TextStyle(
                                          fontSize: MyDimens.textSize16,
                                          color: Colors.black,
                                          fontFamily: 'roboto_bold'
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 5,),
                              Text(
                                'Hour : ' + _getXController.orderService[index].fkServiceHour!,
                                style: TextStyle(
                                    fontSize: MyDimens.textSize12,
                                    color: Colors.black,
                                    fontFamily: 'montserrat_medium'
                                ),
                              ),

                            ],),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          '\$' + _getXController.orderService[index].fkServicePrice!.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: MyDimens.textSize16,
                              color: Colors.black,
                              fontFamily: 'roboto_bold'
                          ),
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            );
          });
  }



  ///*
  ///
  ///Pending Order Button
  pendingOrdersButton(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10, top: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              // margin: const EdgeInsets.only(top: 22.0, left: 23.0, right: 23.0, bottom: 30.0),
              child: ElevatedButton(
                  onPressed: (){
                    _getXController.hitAcceptDeclineOrderApi('Accepted');
                  },
                  style: ElevatedButton.styleFrom(
                      primary: MyColor.themeBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side: BorderSide(color: MyColor.themeBlue),),
                      elevation: 5),
                  child: Text("Accept",
                    style: const TextStyle(
                        fontSize: MyDimens.textSize15,
                        color: Colors.white,
                        fontFamily: 'sf_pro_bold'
                    ),)),
            ),
          ),
          SizedBox(width: 20,),

          Expanded(
            child: Container(
              height: 40,
              child: ElevatedButton(
                  onPressed: (){
                    _getXController.hitAcceptDeclineOrderApi('Rejected');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: MyColor.dividerColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),),
                  ),
                  child: Text("Decline",
                    style: const TextStyle(
                        fontSize: MyDimens.textSize15,
                        color: MyColor.themeBlue,
                        fontFamily: 'sf_pro_bold'
                    ),)),
            ),
          )
        ],
      ),
    );

  }



  ///*
  ///
  ///Accepted Order Button
  acceptedOrderButton(){
    return
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10, top: 10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                // margin: const EdgeInsets.only(top: 22.0, left: 23.0, right: 23.0, bottom: 30.0),
                child: ElevatedButton(
                    onPressed: (){
                      _getXController.hitStartJobApi();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: MyColor.themeBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: MyColor.themeBlue),),
                        elevation: 5),
                    child: Text("Start Job",
                      style: const TextStyle(
                          fontSize: MyDimens.textSize15,
                          color: Colors.white,
                          fontFamily: 'sf_pro_bold'
                      ),)),
              ),
            ),
            SizedBox(width: 20,),

            Expanded(
              child: Container(
                height: 40,
                child: ElevatedButton(
                    onPressed: (){
                      _getXController.hitCancelOrderApi();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: MyColor.dividerColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),),
                    ),
                    child: Text("Cancel",
                      style: const TextStyle(
                          fontSize: MyDimens.textSize15,
                          color: MyColor.themeBlue,
                          fontFamily: 'sf_pro_bold'
                      ),)),
              ),
            )
          ],
        ),
      );

  }


  ///*
  ///
  ///
  String getFormattedDateTime(String bookDate, String? bookTime) {
    String bookDateTime = bookDate + " " + bookTime!;
    String formattedDateTime = '';
    formattedDateTime = DateFormat("MMM dd HH:mm").format(DateTime.parse(bookDateTime.toString()));
    return formattedDateTime;
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

         /* SizedBox(
            height: 5.0,
          ),
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
*/
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
  getColor(String status) {
    if(status == 'Pending'){
      return Colors.orange;

    }else if(status == 'Completed' || status == 'Started'){
      return Colors.green;

    }else if(status == 'Rejected' || status == 'Cancelled'){
      return Colors.red;

    }else if(status == 'Accepted'){
      return MyColor.themeBlue;
    }
  }


}
