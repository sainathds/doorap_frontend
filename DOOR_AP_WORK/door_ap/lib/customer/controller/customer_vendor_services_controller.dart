import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/customer/model/request/customer_vendor_services_request.dart';
import 'package:door_ap/customer/model/response/customer_vendor_services_response.dart';
import 'package:get/get.dart';

class CustomerVendorServicesController extends GetxController{

  String tag = "CustomerVendorServicesController";

  late int vendorId;
  late int categoryId;

  String profileImage = "";
  String vendorName = "";
  String categoryName = "";

  late VenderData vendorData;
  List<ServiceData>? serviceData = <ServiceData>[];

  late Function refreshPage;

  ///*
  ///
  ///
  void hitVendorServicesApi() async{

    CustomerVendorServicesRequest requestModel = CustomerVendorServicesRequest();
    requestModel.categoryId = categoryId;
    requestModel.vendorId = vendorId;

    final results = await Request().requestPostWithHeader(
        url: customerVendorServicesApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerVendorServicesResponse responseModel = CustomerVendorServicesResponse.fromJson(results);
        log(tag + "hitVendorServicesApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          if(responseModel.payload != null){
            if(responseModel.payload!.venderData != null && responseModel.payload!.venderData!.isNotEmpty ){
              vendorData = responseModel.payload!.venderData![0];
              profileImage =  vendorData.fkVendorProfileImage!;
              vendorName = vendorData.fkVendorFullName!;
              categoryName = vendorData.fkCategoryCategoryName!;
              serviceData!.clear();
              serviceData = responseModel.payload!.serviceData;
              refreshPage.call();
            }
          }
        }else{   // if error occur then msg is "Something went wrong or validation msg"
          log("hitVendorServicesApi Error : ");

        }
      }
    }catch(exception){
     log("hitVendorServicesApi Exception : " + exception.toString());
    }

  }


}