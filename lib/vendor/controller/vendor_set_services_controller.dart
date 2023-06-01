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
import 'package:door_ap/vendor/model/request/vendor_facility_request.dart';
import 'package:door_ap/vendor/model/request/vendor_set_services_request.dart';
import 'package:door_ap/vendor/model/response/vendor_facility_list_response.dart';
import 'package:door_ap/vendor/model/response/vendor_set_services_response.dart';
import 'package:door_ap/vendor/screen/vendor_show_service_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorSetServicesController extends GetxController{

  String tag = "VendorSetServicesController";
  List<Payload>? facilityList = <Payload>[];
  List<int> selectedFacilityListId = <int>[];

  TextEditingController costEditController = TextEditingController();
  FocusNode costFocus = FocusNode();
  bool isCostEmpty = false;

  List<String> durationList = <String>[];
  String selectedDuration = '';
  bool isDurationEmpty = false;

  late int categoryId ;
  late int serviceId;
  late Function refreshPage;


  ///*
  ///
  /// get facility of selected service by calling facility_list/ Api
  void hitFacilityListApi() async{

    FacilityListRequest request = FacilityListRequest();
    request.id = serviceId;

    final results = await Request().requestPostWithHeader(
        url: vendorFacilityListApi,
        parameters: json.encode(request),
        context: Get.context);

    try{
      if(results != null){
        FacilityListResponse responseModel = FacilityListResponse.fromJson(results);
        log(tag + "getFacilityListApi Response : " + responseModel.toString());
        if(responseModel.status == 200){
          if(responseModel.payload != null){
            facilityList =  responseModel.payload!;
            refreshPage.call();
          }

        }else{   // if error occur then msg is "Something went wrong or validation msg"
/*          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: responseModel.msg!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );*/

        }
      }
    }catch(exception){
      log(tag + "getFacilityListApi Exception " + exception.toString());
/*
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
*/
    }

  }

  ///*
  ///
  ///
  void setAllErrorToFalse() {
    isCostEmpty = false;
    isDurationEmpty = false;
  }

  ///*
  ///
  /// check validations for required field
  void isDataValid() {
    if(selectedFacilityListId.isEmpty){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            OKDialog(
              title: "",
              descriptions: "Please select services",
              img: errorImage,
              text: '',
              key: null,
            ),
      );
    }else if(costEditController.text.isEmpty){
      isCostEmpty = true;

    }else if(selectedDuration.isEmpty){
      isDurationEmpty = true;
      isCostEmpty = false;

    }else{
      hitSetServicesApi();
    }

  }

  ///*
  ///
  /// by calling vender_add_services/ Api
  /// add this service to your account
  void hitSetServicesApi() async{
    VendorSetServicesRequest requestModel = VendorSetServicesRequest();
    requestModel.vendorId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.categoryId = categoryId;
    requestModel.serviceId = serviceId;
    requestModel.facilityIdList = selectedFacilityListId.toString();
    requestModel.price = double.parse(costEditController.text);
    requestModel.hour = selectedDuration;

    final results = await Request().requestPostWithHeader(
        url: vendorSetServicesApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try {
      if (results != null) {
        VendorSetServicesResponse responseModel = VendorSetServicesResponse.fromJson(results);
        log(tag + "hitSetServicesApi Response : " + json.encode(responseModel));
        if (responseModel.status == 200) {
          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) =>
                CustomDialog(
                  my_context: Get.context!,
                  img: successImage,
                  title: "",
                  description: responseModel.msg!,
                  buttonText: 'Ok',
                    okBtnFunction: navigateToListScreen
                ),
          );
        } else { // if error occur then msg is "Something went wrong or validation msg"
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
    } catch (exception) {
      log(tag + "hitSetServicesApi Exception " + exception.toString());
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            OKDialog(
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
  navigateToListScreen() {
    Get.off(() => VendorShowServiceListScreen());
  }
}