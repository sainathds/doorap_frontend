import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/utils/global_data.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:door_ap/customer/model/request/customer_cart_count_request.dart';
import 'package:door_ap/customer/model/request/customer_like_dislike_request.dart';
import 'package:door_ap/customer/model/request/customer_vendors_request.dart';
import 'package:door_ap/customer/model/response/customer_cart_count_response.dart' as cartCountResponse;
import 'package:door_ap/customer/model/response/customer_like_dislike_response.dart';
import 'package:door_ap/customer/model/response/customer_vendors_response.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CustomerVendorsController extends GetxController{

  String tag = "CustomerVendorsServiceController";
  late Function refreshPage;

  List<Payload>? vendorsData = <Payload>[];
  late String categoryId;
  String serviceOrCategoryName = "";

  late CustomerAddressModel customerAddressModel;

  ///*
  ///
  ///
  void hitCustomerVendorsApi() async{

    CustomerVendorsRequest requestModel = CustomerVendorsRequest();
    requestModel.customerId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.categoryId = categoryId;
    requestModel.lat = customerAddressModel.latitude.toString();
    requestModel.lng = customerAddressModel.longitude.toString();


    final results = await Request().requestPostWithHeader(
        url: customerVendorsByLocationApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerVendorsResponse responseModel = CustomerVendorsResponse.fromJson(results);
        log(tag + "hitCustomerVendorsApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
            if(responseModel.payload != null && responseModel.payload!.isNotEmpty ){
              vendorsData!.clear();
              vendorsData = responseModel.payload!;
              refreshPage.call();
            }
        }else{   // if error occur then msg is "Something went wrong or validation msg"
        }
      }
    }catch(exception){
    }

  }


  ///*
  ///
  ///
  void hitLikeDislikeApi(int vendorId, String isLikeDislike) async{

    CustomerLikeDislikeRequest requestModel = CustomerLikeDislikeRequest();
    requestModel.vendorId = vendorId;
    requestModel.customerId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.categoryId = int.parse(categoryId);
    requestModel.likeDislike = isLikeDislike;

    final results = await Request().requestPostHeaderNoProgressBar(
        url: customerLikeDislikeApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerLikeDislikeResponse responseModel = CustomerLikeDislikeResponse.fromJson(results);
        log(tag + "hitLikeDislikeApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          refreshPage.call();
        }else{// if error occur then msg is "Something went wrong or validation msg"
          log('hitLikeDislikeApi Error: ');

        }
      }
    }catch(exception){
      log('hitLikeDislikeApi Exception: ' + exception.toString() );
    }

  }

}