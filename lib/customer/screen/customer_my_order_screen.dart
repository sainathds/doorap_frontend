import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/controller/customer_my_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';

import 'customer_order_details_screen.dart';

class CustomerMyOrderScreen extends StatefulWidget {
  const CustomerMyOrderScreen({Key? key}) : super(key: key);

  @override
  _CustomerMyOrderScreenState createState() => _CustomerMyOrderScreenState();
}

class _CustomerMyOrderScreenState extends State<CustomerMyOrderScreen> {

  CustomerMyOrdersController _getXController = Get.put(CustomerMyOrdersController());

  @override
  void initState() {
    // TODO: implement initState

    MySharedPreference.getInstance();
    _getXController.myOrders.clear();
    _getXController.refreshPage = refreshPage;
    Future.delayed(Duration.zero, () async{
      _getXController.hitMyOrderApi();
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
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          shadowColor: MyColor.textGrey,
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: MyColor.themeBlue, // Navigation bar
            statusBarColor: MyColor.themeBlue, // Status bar
          ),
          centerTitle: true,
          title: const Text(
            "My Orders",
            style: TextStyle(
                fontSize: MyDimens.textSize20,
                color: Colors.white,
                fontFamily: 'roboto_medium'),
          ),
        ),
        body: _getXController.myOrders.isNotEmpty ? myOrdersWidget() :
        Center(child:
        Text('No Orders Found',
          style: TextStyle(
          fontSize: MyDimens.textSize16,
            color: MyColor.textGrey,
            fontFamily: 'montserrat_medium'
        ),),)
      ),
    );
  }

  ///*
  ///
  ///
  myOrdersWidget() {

    return ListView.builder(
        itemCount: _getXController.myOrders.length,
        itemBuilder: (BuildContext context, int index){
          return
              InkWell(
                onTap: (){
                  var nav = Get.to(() => CustomerOrderDetailsScreen(
                    orderPrimaryKey: _getXController.myOrders[index].id!,
                    orderUniqueId: _getXController.myOrders[index].orderId!,
                    callFrom: 'MyOrderScreen',));
                  if(nav == null){
                    _getXController.hitMyOrderApi();
                  }
                },
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    child: Column(
                      children: [

                        //vendor name and status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                  _getXController.myOrders[index].fkVendorFullName!,
                                    style: TextStyle(
                                      fontSize: MyDimens.textSize18,
                                      color: Colors.black,
                                      fontFamily: 'roboto_bold'
                                    )
                              ),
                            ),

                            Text(
                                _getXController.myOrders[index].orderStatus!,
                                style: TextStyle(
                                    fontSize: MyDimens.textSize14,
                                    color: getColor(_getXController.myOrders[index].orderStatus!),
                                    fontFamily: 'montserrat_medium'
                                )
                            )
                          ],
                        ),

                        //order no. and date
                        SizedBox(height: 5.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                  'Order No: #' + _getXController.myOrders[index].orderId!,
                                  style: TextStyle(
                                      fontSize: MyDimens.textSize14,
                                      color: Colors.black,
                                      fontFamily: 'roboto_medium'
                                  )
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: Text(
                                  getFormattedDateTime(_getXController.myOrders[index].bookingDate!, _getXController.myOrders[index].bookingStartTime),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: MyDimens.textSize14,
                                      color: MyColor.textGrey,
                                      fontFamily: 'roboto_medium'
                                  )
                              ),
                            )
                          ],
                        ),


                        SizedBox(height: 5.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                  'Total Amount: \$' + _getXController.myOrders[index].totalAmount!.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: MyDimens.textSize14,
                                      color: Colors.black,
                                      fontFamily: 'roboto_medium'
                                  )
                              ),
                            ),

                          ],
                        ),

                        /*SizedBox(height: 20.0,),
                        Row(
                          children: [

                            _getXController.myOrders[index].orderStatus == 'Pending' || _getXController.myOrders[index].orderStatus == 'Accepted' ?
                            //Cancel btn
                            Expanded(
                              child: Container(
                                height: 40,
                                child: ElevatedButton(
                                    onPressed: (){
                                      _getXController.hitCancelOrderApi(
                                          _getXController.myOrders[index].id!,
                                          _getXController.myOrders[index].orderId!,
                                          _getXController.myOrders[index].fkVendor!);
                                      },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.0),
                                          side: BorderSide(color: MyColor.themeBlue),),
                                        elevation: 5),
                                    child: Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text("Cancel",
                                        style: const TextStyle(
                                            fontSize: MyDimens.textSize15,
                                            color: MyColor.themeBlue,
                                            fontFamily: 'sf_pro_bold'
                                        ),),
                                    )),
                              ),
                            )


                            :_getXController.myOrders[index].orderStatus == 'Started'?
                            //Complete button
                            Expanded(
                              child: Container(
                                height: 40,
                                child: ElevatedButton(
                                    onPressed: (){
                                      _getXController.hitCompleteOrderApi(
                                          _getXController.myOrders[index].id!,
                                          _getXController.myOrders[index].orderId!,
                                          _getXController.myOrders[index].fkVendor!);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.0),
                                          side: BorderSide(color: MyColor.themeBlue),),
                                        elevation: 5),
                                    child: Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text("Complete",
                                        style: const TextStyle(
                                            fontSize: MyDimens.textSize15,
                                            color: MyColor.themeBlue,
                                            fontFamily: 'sf_pro_bold'
                                        ),),
                                    )),
                              ),
                            )


                                :_getXController.myOrders[index].orderStatus == 'Completed'?
                            //Reorder button
                            Expanded(
                              child: Container(
                                height: 40,
                                child: ElevatedButton(
                                    onPressed: (){
                                      // Get.back();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.0),
                                          side: BorderSide(color: MyColor.themeBlue),),
                                        elevation: 5),
                                    child: Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text("Reorder",
                                        style: const TextStyle(
                                            fontSize: MyDimens.textSize15,
                                            color: MyColor.themeBlue,
                                            fontFamily: 'sf_pro_bold'
                                        ),),
                                    )),
                              ),
                            )


                            :SizedBox(),


                            SizedBox(width: _getXController.myOrders[index].orderStatus != 'Rejected' ? 20 : 0),

                            Expanded(
                              child: Container(
                                height: 40,
                                child: ElevatedButton(
                                    onPressed: (){
                                    },
                                    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),),
                                        elevation: 5),
                                    child: Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text("Rate & Review",
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
*/
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

  ///*
  ///
  ///
  String getFormattedDateTime(String bookDate, String? bookTime) {

    String bookDateTime = bookDate + " " + bookTime!;
    String formattedDateTime = '';
    formattedDateTime = DateFormat("MMM dd HH:mm").format(DateTime.parse(bookDateTime.toString()));
    return formattedDateTime;
  }

}
