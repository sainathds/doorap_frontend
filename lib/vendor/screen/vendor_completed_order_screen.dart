import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/vendor/controller/vendor_past_order_controller.dart';
import 'package:door_ap/vendor/screen/vendor_order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorCompletedOrderScreen extends StatefulWidget {

  VendorPastOrderController pastOrderController;
  VendorCompletedOrderScreen({Key? key, required this.pastOrderController}) : super(key: key);

  @override
  _VendorCompletedOrderScreenState createState() => _VendorCompletedOrderScreenState();
}

class _VendorCompletedOrderScreenState extends State<VendorCompletedOrderScreen> {

  @override
  void initState() {
    // TODO: implement initState
    widget.pastOrderController.completeOrderRefreshPage = completedOrderRefreshPage;
    widget.pastOrderController.completedOrderList.clear();

    Future.delayed(Duration.zero, () async {
      //get completed order list
      widget.pastOrderController.hitVendorOrdersApi('Completed');
    });
    super.initState();
  }

  ///*
  ///
  ///
  void completedOrderRefreshPage(){
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return widget.pastOrderController.completedOrderList.isNotEmpty?
    showCompletedOrderList()
        : Center(child: Text("No Completed Orders"),);
  }

  ///*
  ///
  ///
  Widget showCompletedOrderList() {

    return ListView.builder(
        itemCount: widget.pastOrderController.completedOrderList.length,
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap: (){
              Get.to(() => VendorOrderDetailsScreen(
                orderPrimaryKey: widget.pastOrderController.completedOrderList[index].id!,
                orderUniqueId: widget.pastOrderController.completedOrderList[index].orderId!,));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              elevation: 5,
              margin: EdgeInsets.only(left:20, right: 20, top: 10),
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                ),
                child: Column(
                  children: [

                    //service name and status
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: widget.pastOrderController.completedOrderList[index].service!.serviceName![0] ,
                                    style: TextStyle(
                                      fontSize: MyDimens.textSize14,
                                      color: MyColor.themeBlue,
                                      fontFamily: 'montserrat_medium',
                                    ),
                                  ),

                                  widget.pastOrderController.completedOrderList[index].service!.serviceName!.length > 1 ?
                                  TextSpan(
                                      text: " +" + (widget.pastOrderController.completedOrderList[index].service!.serviceName!.length - 1).toString(),
                                      style: TextStyle(
                                        fontSize: MyDimens.textSize14,
                                        color: MyColor.themeBlue,
                                        fontFamily: 'montserrat_medium',
                                      )
                                  ): TextSpan()
                                ],
                              ),
                            ),
                          ),


                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              color: MyColor.inactiveOtp,
                            )  ,
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Text(widget.pastOrderController.completedOrderList[index].orderStatus!,
                                style: TextStyle(
                                    fontSize: MyDimens.textSize13,
                                    color: MyColor.greenColor,
                                    fontFamily: 'montserrat_regular'
                                ),),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //vendor data and total hour and amount
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: Row(
                        children: [

                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.pastOrderController.completedOrderList[index].fkCustomerName!,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: MyDimens.textSize15,
                                        color: MyColor.themeBlue,
                                        fontFamily: 'montserrat_medium'
                                    ),),

                                ],
                              ),
                            ),
                          ),

                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                        child:
                                        // Icon(Icons.timelapse_rounded, size: 14, color: MyColor.orangeColor,),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 3.0),
                                          child: Image(image: totalTimeIc, width: 20, height: 20,),
                                        )
                                    ),
                                    TextSpan(
                                        text: widget.pastOrderController.completedOrderList[index].duration.toString() + "hr",
                                        style: TextStyle(
                                            fontSize: MyDimens.textSize18,
                                            color: MyColor.themeBlue,
                                            fontFamily: 'montserrat_medium'
                                        )
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 10,),

                              Text( '\$' + widget.pastOrderController.completedOrderList[index].vendorPayAmount.toString(),
                                style: TextStyle(
                                    fontSize: MyDimens.textSize18,
                                    color: MyColor.themeBlue,
                                    fontFamily: 'montserrat_medium'
                                ),),

                            ],
                          )
                        ],
                      ),
                    ),

                    //Customer location data
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 3.0),
                                    child: Image(image: locationIcon, color: MyColor.themeBlue, width: 15, height: 18,),
                                  ),

                                ),
                                TextSpan(
                                    text: widget.pastOrderController.completedOrderList[index].customerCity,
                                    style: TextStyle(
                                        fontSize: MyDimens.textSize14,
                                        color: MyColor.themeBlue,
                                        fontFamily: 'montserrat_medium'
                                    )
                                ),
                              ],
                            ),
                          ),

                          Row(
                            children: [


                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Text( widget.pastOrderController.completedOrderList[index].address!,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: MyDimens.textSize13,
                                        color: MyColor.themeBlue,
                                        fontFamily: 'montserrat_regular'
                                    ),),
                                ),
                              ),

                              /*Row(
                                children: [
                                  InkWell(
                                      onTap:(){
                                        // redirectToMap(_getXController.acceptedOrderList[index].lat!,
                                        //     _getXController.acceptedOrderList[index].lng!);
                                      },
                                      child: Image(image: locationDirectionIc, color: MyColor.themeBlue, width: 25, height: 25,)),

                                  // SizedBox(width: 15,),

                                  // Image(image: messageIcon, color: MyColor.themeBlue, width: 25, height: 25),

                                ],
                              )*/
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        });
  }

}
