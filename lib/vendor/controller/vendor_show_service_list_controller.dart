import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/customdialog.dart';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/model/request/vendor_delete_service_request.dart';
import 'package:door_ap/vendor/model/request/vendor_show_services_request.dart';
import 'package:door_ap/vendor/model/response/vendor_delete_service_response.dart';
import 'package:door_ap/vendor/model/response/vendor_show_services_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorShowServicesController extends GetxController{


  String tag = "VendorShowServicesController";
  late Function refreshPage;
  List<VenderService> vendorServiceList = <VenderService>[];


  ///*
  ///
  ///
  void hitShowVendorServicesListApi() async{

    VendorShowServiceRequest requestModel = VendorShowServiceRequest();
    requestModel.id = MySharedPreference.getInt(MyConstants.keyUserId).toString();

    final results = await Request().requestPostWithHeader(
        url: showVendorServicesApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        VendorShowServiceResponse responseModel = VendorShowServiceResponse.fromJson(results);
        log(tag + "hitShowVendorListApi Response : " + responseModel.toString());
        if(responseModel.status == 200){
          if(responseModel.payload != null && responseModel.payload!.venderService!.isNotEmpty ){
            vendorServiceList.clear();
            vendorServiceList = responseModel.payload!.venderService!;
            refreshPage.call();
          }
        }else{   // if error occur then msg is "Something went wrong or validation msg"
          vendorServiceList.clear();
          refreshPage.call();
        }
      }
    }catch(exception){
      log(tag + "hitShowVendorListApi Exception " + exception.toString());
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: MyString.errorMessage!,
          img: errorImage,
          text: '',
          key: null,
        ),
      );
    }

  }


  ///*
  ///
  ///
  void hitDeleteServiceApi(int? id) async{
    VendorDeleteServiceRequest requestModel = VendorDeleteServiceRequest();
    requestModel.id = id!;
    requestModel.vendorId = MySharedPreference.getInt(MyConstants.keyUserId);


    final results = await Request().requestPostWithHeader(
        url: vendorDeleteServicesApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        VendorDeleteServiceResponse responseModel = VendorDeleteServiceResponse.fromJson(results);
        log(tag + "hitShowVendorListApi Response : " + responseModel.toString());
        if(responseModel.status == 200){

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) =>
                CustomDialog(
                    my_context: Get.context!,
                    img: successImage,
                    title: "",
                    description: responseModel.msg!,
                    buttonText: 'Ok',
                    okBtnFunction: hitShowVendorServicesListApi
                ),
          );
        }else{   // if error occur then msg is "Something went wrong or validation msg"
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
        }
      }
    }catch(exception){
      log(tag + "hitShowVendorListApi Exception " + exception.toString());
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: MyString.errorMessage!,
          img: errorImage,
          text: '',
          key: null,
        ),
      );
    }


  }

}