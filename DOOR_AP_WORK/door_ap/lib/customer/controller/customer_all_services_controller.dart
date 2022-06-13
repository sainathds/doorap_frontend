import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/customer/model/request/customer_all_services_request.dart';
import 'package:door_ap/customer/model/response/customer_all_services_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerAllServicesController extends GetxController{

  String tag = "VendorShowServicesController";
  TextEditingController searchEditController = TextEditingController();
  late Function refreshPage;
  String searchQuery = "";
  List<Payload> allServices = <Payload>[];



  ///*
  ///
  ///
  void hitShowAllServicesApi() async{

    CustomerAllServicesRequest requestModel = CustomerAllServicesRequest();
    requestModel.search = searchEditController.text.trim();

    final results = await Request().requestPostWithHeader(
        url: customerShowAllServicesApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerAllServicesResponse responseModel = CustomerAllServicesResponse.fromJson(results);
        log(tag + "hitShowAllServicesApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          if(responseModel.payload != null && responseModel.payload!.isNotEmpty ){
            allServices.clear();
            allServices = responseModel.payload!;
            refreshPage.call();
          }
        }else{   // if error occur then msg is "Something went wrong or validation msg"
/*
          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: responseModel.msg!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );
*/

        }
      }
    }catch(exception){
      /*log(tag + "hitShowVendorListApi Exception " + exception.toString());
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: MyString.errorMessage!,
          img: errorImage,
          text: '',
          key: null,
        ),
      );*/
    }

  }

}