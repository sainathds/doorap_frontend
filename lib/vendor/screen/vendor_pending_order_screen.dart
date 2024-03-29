import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/controller/vendor_home_controller.dart';
import 'package:door_ap/vendor/controller/vendor_pending_order_controller.dart';
import 'package:door_ap/vendor/screen/vendor_order_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class VendorPendingOrderScreen extends StatefulWidget {


  double vendorLatitude;
  double vendorLongitude;

  VendorPendingOrderScreen({Key? key, required this.vendorLatitude, required this.vendorLongitude}) : super(key: key);

  @override
  _VendorPendingOrderScreenState createState() => _VendorPendingOrderScreenState();
}

class _VendorPendingOrderScreenState extends State<VendorPendingOrderScreen> {

  VendorPendingOrderController _getXController = Get.put(VendorPendingOrderController());

  @override
  void initState() {
    // TODO: implement initState
    MySharedPreference.getInstance();
    _getXController.refreshPage = refreshPage;
    _getXController.redirectToAccepted = redirectToAccepted;
    _getXController.pendingOrderList.clear();
    Future.delayed(Duration.zero, () async {
      _getXController.hitVendorOrdersApi();
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
    return _getXController.pendingOrderList.isNotEmpty?
         showPendingOrderList()
        : Center(child: Text("No Pending Orders"),);
  }

  ///*
  ///
  ///
  Widget showPendingOrderList() {

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
               itemCount: _getXController.pendingOrderList.length,
              itemBuilder: (BuildContext context, int index){
                return InkWell(
                  onTap: (){
                    Get.to(() => VendorOrderDetailsScreen(
                      orderPrimaryKey: _getXController.pendingOrderList[index].id!,
                      orderUniqueId: _getXController.pendingOrderList[index].orderId!,));


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
                                          text: _getXController.pendingOrderList[index].service!.serviceName![0] ,
                                          style: TextStyle(
                                            fontSize: MyDimens.textSize14,
                                            color: MyColor.themeBlue,
                                            fontFamily: 'montserrat_medium',
                                          ),
                                        ),

                                        _getXController.pendingOrderList[index].service!.serviceName!.length > 1 ?
                                        TextSpan(
                                            text: " +" + (_getXController.pendingOrderList[index].service!.serviceName!.length - 1).toString(),
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
                                    child: Text(_getXController.pendingOrderList[index].orderStatus!,
                                      style: TextStyle(
                                          fontSize: MyDimens.textSize13,
                                          color: MyColor.orangeColor,
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
                                        Text(_getXController.pendingOrderList[index].fkCustomerName!,
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
                                              text: _getXController.pendingOrderList[index].duration.toString() + "hr",
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

                                    Text( '\$' + _getXController.pendingOrderList[index].vendorPayAmount.toString(),
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
                                          text: _getXController.pendingOrderList[index].customerCity,
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
                                        child: Text( _getXController.pendingOrderList[index].address!,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: MyDimens.textSize13,
                                              color: MyColor.themeBlue,
                                              fontFamily: 'montserrat_regular'
                                          ),),
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        InkWell(
                                            onTap:(){
                                              redirectToMap(_getXController.pendingOrderList[index].lat!,
                                                  _getXController.pendingOrderList[index].lng!);
                                              },
                                            child: Image(image: locationDirectionIc, color: MyColor.themeBlue, width: 25, height: 25,)),

                                        // SizedBox(width: 15,),

                                        // Image(image: messageIcon, color: MyColor.themeBlue, width: 25, height: 25),

                                      ],
                                    )
                                  ],
                                ),


                              ],
                            ),
                          ),


                       //Buttons
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
                                    _getXController.hitAcceptDeclineOrderApi(
                                        _getXController.pendingOrderList[index].id!,
                                        _getXController.pendingOrderList[index].orderId!,
                                        'Accepted',
                                        _getXController.pendingOrderList[index].fkCustomer!
                                    );

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
                                    _getXController.hitAcceptDeclineOrderApi(
                                        _getXController.pendingOrderList[index].id!,
                                        _getXController.pendingOrderList[index].orderId!,
                                        'Rejected',
                                        _getXController.pendingOrderList[index].fkCustomer!
                                    );
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
                    )

                    ],
                      ),
                    ),
                  ),
                );
              }),),

        Container(height: 50,)
      ],
    );
  }


  ///*
  ///
  ///&travelmode=driving  //bind before dir_action  &dir_action=navigate
  void redirectToMap(double destiLatitude, double destiLongitude) async{
    String url =
        'https://www.google.com/maps/dir/?api=1&origin=${widget.vendorLatitude},${widget.vendorLongitude}&destination=$destiLatitude,$destiLongitude&travelmode=driving';
    if (await launchUrl(Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }


  ///*
  ///
/*
  void redirectToMap(double destiLatitude, double destiLongitude) async{
    String url = 'https://www.google.com/maps/dir/?api=1&origin=${widget.vendorLatitude},${widget.vendorLongitude}&destination=$destiLatitude,$destiLongitude&travelmode=driving';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
*/




  ///*
  ///
  ///
  void redirectToAccepted(){
    DefaultTabController.of(context)!.animateTo(1);
  }
}
