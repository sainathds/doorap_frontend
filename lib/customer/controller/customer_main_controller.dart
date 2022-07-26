import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/model/request/customer_current_order_request.dart';
import 'package:door_ap/customer/model/response/customer_current_order_response.dart';
import 'package:get/get.dart';

class CustomerMainController extends GetxController{
  String tag = "CustomerMainController";
  late Function refreshPage;

  String status = "Started";
  String serviceName = "Cleaning Service";
  String vendorImage = "";
  String vendorName = "Aliana Pinto";
  String vendorRating = "";
  String totalHour = "2h";
  double totalAmount = 70.0;
  String vendorCity = "New York";
  String vendorAddress = "3 The Green London W19";
  double vendorLatitude = 0.0;
  double vendorLongitude = 0.0;

  List<Payload> currentOrderList = <Payload>[];

  ///*
  ///
  ///
    void hitCurrentOrderApi() async{
      CustomerCurrentOrderRequest requestModel = CustomerCurrentOrderRequest();
      requestModel.customerId = MySharedPreference.getInt(MyConstants.keyUserId);

      final results = await Request().requestPostHeaderNoProgressBar(
          url: customerCurrentOrderApi,
          parameters: json.encode(requestModel),
          context: Get.context);

      try{
        if(results != null){

          CustomerCurrentOrderResponse responseModel = CustomerCurrentOrderResponse.fromJson(results);
          log(tag + "hitCurrentOrderApi Response : " + json.encode(responseModel));


          if(responseModel.status == 200){
            if(responseModel.payload != null && responseModel.payload!.isNotEmpty){
              currentOrderList.clear();
              currentOrderList = responseModel.payload!;
            }else{
              currentOrderList.clear();
            }

            refreshPage.call();
          }else{// if error occur then msg is "Something went wrong or validation msg"
            log('hitCurrentOrderApi Error: ');
            currentOrderList.clear();
            refreshPage.call();


          }
        }
      }catch(exception){
        log('hitCurrentOrderApi Exception: ' + exception.toString() );
        currentOrderList.clear();
        refreshPage.call();


      }


    }


}