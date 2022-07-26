import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/model/request/vendor_order_list_request.dart';
import 'package:door_ap/vendor/model/response/vendor_order_list_response.dart';
import 'package:get/get.dart';

class VendorPastOrderController extends GetxController{

  String tag = "VendorPastOrderController";
  late Function cancelOrderRefreshPage;
  late Function completeOrderRefreshPage;
  List<Payload> completedOrderList = <Payload>[];
  List<Payload> cancelledOrderList = <Payload>[];


  ///*
  ///
  ///
  void hitVendorOrdersApi(String orderStatus) async{
    VendorOrderListRequest requestModel = VendorOrderListRequest();
    requestModel.vendorId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.orderStatus = orderStatus;

    final results = await Request().requestPostWithHeader(
        url: vendorOrderListApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){

        VendorOrderListResponse responseModel = VendorOrderListResponse.fromJson(results);
        log(tag + "hitVendorOrdersApi Response : " + json.encode(responseModel));

        if(responseModel.status == 200){
          if(responseModel.payload != null && responseModel.payload!.isNotEmpty){

            if(orderStatus == 'Completed'){
              completedOrderList.clear();
              completedOrderList = responseModel.payload!;
              completeOrderRefreshPage.call();
            }else{
              cancelledOrderList.clear();
              cancelledOrderList = responseModel.payload!;
              cancelOrderRefreshPage.call();
            }
          }else{
            if(orderStatus == 'Completed'){
              completedOrderList.clear();
              completeOrderRefreshPage.call();

            }else{
              cancelledOrderList.clear();
              cancelOrderRefreshPage.call();
            }
          }
        }else{// if error occur then msg is "Something went wrong or validation msg"
          log('hitVendorOrdersApi Error: ');

        }
      }
    }catch(exception){
      log('hitVendorOrdersApi Exception: ' + exception.toString() );
    }


  }

}