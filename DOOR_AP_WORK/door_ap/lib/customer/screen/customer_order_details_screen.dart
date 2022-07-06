import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/controller/customer_order_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomerOrderDetailsScreen extends StatefulWidget {

  int orderPrimaryKey;
  String orderUniqueId;

  CustomerOrderDetailsScreen({Key? key, required this.orderPrimaryKey, required this.orderUniqueId}) : super(key: key);

  @override
  _CustomerOrderDetailsScreenState createState() => _CustomerOrderDetailsScreenState();
}

class _CustomerOrderDetailsScreenState extends State<CustomerOrderDetailsScreen> {

 final CustomerOrderDetailsController _getXController = Get.put(CustomerOrderDetailsController());


 @override
  void initState() {
    // TODO: implement initState
   MySharedPreference.getInstance();
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

                  //vendor profile data
                  profileDataWidget(),

                  Container(
                    margin: EdgeInsets.only( top: 10.0, bottom: 10.0),
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
                                'Order Information',
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

                          paymentAndAddressDetails()
                        ],),
                    ),
                  ),

                  buttonsWidget(),

                ],
              ),
            )
            : SizedBox()
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
                   color: MyColor.orangeColor,
                   fontFamily: 'montserrat_medium'),
             ),
           ],
         ),

         SizedBox(height: 5.0,),
         Text(
           _getXController.bookingDate,
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
                         '\$' + _getXController.orderService[index].fkServicePrice.toString(),
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


 //
 ///
 ///
 /// Vendor profile data
 profileDataWidget() {
   return Padding(
     padding: const EdgeInsets.only(
         top: 0.0, bottom: 0.0, left: 20.0, right: 20.0),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(
               _getXController.vendorName,
               style: TextStyle(
                   fontSize: MyDimens.textSize20,
                   color: Colors.black,
                   fontFamily: 'roboto_bold'),
             ),

             /*Text(
               'Avg Time: ' + _getXController.averageTime + ' Hrs',
               textAlign: TextAlign.center,
               style: TextStyle(
                   fontSize: MyDimens.textSize14,
                   color: Colors.black,
                   fontFamily: 'montserrat_semiBold'),
             ),*/
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


  ///*
 ///
 ///
  buttonsWidget() {
    return
      Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              // margin: const EdgeInsets.only(top: 22.0, left: 23.0, right: 23.0, bottom: 30.0),
              child: ElevatedButton(
                  onPressed: (){
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side: BorderSide(color: MyColor.themeBlue),),
                      elevation: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("Reorder",
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
                  },
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),),
                      elevation: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("Leave Feedback",
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


}
