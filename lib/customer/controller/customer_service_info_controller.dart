import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/utils/global_data.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:door_ap/customer/model/request/customer_add_to_cart_request.dart';
import 'package:door_ap/customer/model/request/customer_cart_count_request.dart';
import 'package:door_ap/customer/model/request/customer_service_info_request.dart';
import 'package:door_ap/customer/model/response/customer_add_to_cart_response.dart';
import 'package:door_ap/customer/model/response/customer_cart_count_response.dart';
import 'package:door_ap/customer/model/response/customer_service_info_response.dart';
import 'package:door_ap/customer/screen/cuatomer_cart_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerServiceInfoController extends GetxController{

  String tag = "CustomerServiceInfoController";

  late int vendorId;
  late int categoryId;
  late int serviceId;
  late int vendorServiceId; //sevice provided by vendor


  late ServiceData serviceData;
  List<IncludeFacility> includeFacility = <IncludeFacility>[];
  List<ExcludeFacility> excludeFacility = <ExcludeFacility>[];


  String serviceImage = "";
  String serviceName = "";
  String hours = "";
  double price = 0.0;
  int quantity = 01;

  late Function refreshPage;

  late CustomerAddressModel customerAddressModel;

  ///*
  ///
  ///
  void hitServiceInfoApi() async{

    CustomerServiceInfoRequest requestModel = CustomerServiceInfoRequest();
    requestModel.vendorId = vendorId;
    requestModel.categoryId = categoryId;
    requestModel.serviceId = serviceId;
    requestModel.venderServiceId = vendorServiceId;

    final results = await Request().requestPostWithHeader(
        url: customerServiceInfoApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerServiceInfoResponse responseModel = CustomerServiceInfoResponse.fromJson(results);
        log(tag + "hitServiceInfoApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          if(responseModel.payload != null){
            if(responseModel.payload!.serviceData != null && responseModel.payload!.serviceData!.isNotEmpty ){
              serviceData = responseModel.payload!.serviceData![0];
              serviceImage =  serviceData.fkServiceServiceImage!;
              serviceName = serviceData.fkServiceServiceName!;
              hours = serviceData.hour!;
              price = serviceData.price!;

              includeFacility.clear();
              excludeFacility.clear();
              includeFacility = responseModel.payload!.includeFacility!;
              excludeFacility = responseModel.payload!.excludeFacility!;
              refreshPage.call();
            }
          }
        }else{   // if error occur then msg is "Something went wrong or validation msg"
          log("hitServiceInfoApi Error : ");

        }
      }
    }catch(exception){
      log("hitServiceInfoApi Exception : " + exception.toString());
    }

  }


  ///*
  ///
  ///
  void hitAddToCartApi() async{

    CustomerAddToCartRequest requestModel = CustomerAddToCartRequest();
    requestModel.vendorId = vendorId.toString();
    requestModel.customerId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.vendorServiceId = vendorServiceId;
    requestModel.categoryId = categoryId;
    requestModel.country = "India";
    requestModel.quantity = quantity;
    requestModel.price = serviceData.price;

    String time = hours.substring(0, hours.length-5);

    requestModel.hour = int.parse(time);


    final results = await Request().requestPostWithHeader(
        url: customerAddToCartApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerAddToCartResponse responseModel = CustomerAddToCartResponse.fromJson(results);
        log(tag + "hitAddToCartApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          var nav = await Navigator.pushReplacement(Get.context!,
              MaterialPageRoute(builder: (BuildContext context) =>
                  CustomerCartSummaryScreen(
                      categoryId: categoryId,
                      vendorId: vendorId,
                      customerAddressModel: customerAddressModel,
                      callFrom: 'ServiceInfo')));

          if(nav == null){
            refreshPage.call();
          }

        }else{   // if error occur then msg is "Something went wrong or validation msg"
          log("hitAddToCartApi Error : ");
          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) =>
                OKDialog(
                  title: "",
                  descriptions: responseModel.msg!,
                  img: errorImage,
                  text: '',
                  key: null,
                ),
          );

        }
      }
    }catch(exception){
      log("hitAddToCartApi Exception : " + exception.toString());
    }

  }



}