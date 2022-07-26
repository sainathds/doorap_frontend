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
import 'package:door_ap/vendor/model/request/vendor_edit_service_request.dart';
import 'package:door_ap/vendor/model/request/vendor_facility_request.dart';
import 'package:door_ap/vendor/model/request/vendor_selected_facility_request.dart';
import 'package:door_ap/vendor/model/response/vendor_edit_service_response.dart';
import 'package:door_ap/vendor/model/response/vendor_selected_facility_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:door_ap/vendor/model/response/vendor_facility_list_response.dart';


class VendorEditServiceController extends GetxController{

  String tag = "VendorEditServiceController";
  List<Payload>? facilityList = <Payload>[];
  List<int> selectedFacilityListId = <int>[];

  TextEditingController costEditController = TextEditingController();
  FocusNode costFocus = FocusNode();
  bool isCostEmpty = false;

  List<String> durationList = <String>[];
  String selectedDuration = '';
  bool isDurationEmpty = false;

  late String categoryId ;
  late String serviceId;
  late String updateDataId;
  late Function refreshPage;

  ///*
  ///
  ///
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
      hitUpdateServicesApi();
    }

  }


  ///*
  ///
  /// Selected facility list
  void hitSelectedFacilityListApi() async{

    VendorSelectedFacilityRequest request = VendorSelectedFacilityRequest();
    request.vendorId = MySharedPreference.getInt(MyConstants.keyUserId).toString();
    request.serviceId = serviceId;

    final results = await Request().requestPostWithHeader(
        url: vendorSelectedFacilityListApi,
        parameters: json.encode(request),
        context: Get.context);

    try{
      if(results != null){
        VendorSelectedFacilityResponse responseModel = VendorSelectedFacilityResponse.fromJson(results);
        log(tag + "hitSelectedFacilityListApi Response : " + responseModel.toString());
        if(responseModel.status == 200){
          if(responseModel.vendorFacility != null && responseModel.vendorFacility!.isNotEmpty){
            for(int index = 0; index < facilityList!.length; index++) {
              for (int position = 0; position < responseModel.vendorFacility!.length; position++) {
                if(responseModel.vendorFacility![position].fkVenderFacility == facilityList![index].id){
                  facilityList![index].isSelected = true;
                  selectedFacilityListId.add(facilityList![index].id!);
                }
              }
            }
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
      // log(tag + "hitSelectedFacilityListApi Exception " + exception.toString());
      // showDialog(
      //   context: Get.context!,
      //   builder: (BuildContext context1) => OKDialog(
      //     title: "",
      //     descriptions: MyString.errorMessage!,
      //     img: errorImage,
      //     text: '',
      //     key: null,
      //   ),
      // );
    }
  }


  ///*
  ///
  /// All facility
  void hitFacilityListApi() async{

    FacilityListRequest request = FacilityListRequest();
    request.id = int.parse(serviceId);

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
            hitSelectedFacilityListApi();
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
      log(tag + "getFacilityListApi Exception " + exception.toString());
/*      showDialog(
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


  ///*
  ///
  ///
  /// {
  //  "data_id":"4"
  //  "vender_id":"12",
  //  "category_id":"1",
  //  "service_id":"3",
  //  "facility_id_list":"[1,2,3,82,1]",
  //  "price":"432.32"
  //  "hour":"1"
  // }
  void hitUpdateServicesApi() async{
    VendorEditServiceRequest requestModel = VendorEditServiceRequest();
    requestModel.dataId = updateDataId.toString();
    requestModel.venderId = MySharedPreference.getInt(MyConstants.keyUserId).toString();
    requestModel.categoryId = categoryId.toString();
    requestModel.serviceId = serviceId.toString();
    requestModel.facilityIdList = selectedFacilityListId.toString();
    requestModel.price = costEditController.text;
    requestModel.hour = selectedDuration;

    final results = await Request().requestPostWithHeader(
        url: vendorUpdateServicesApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try {
      if (results != null) {
        VendorEditServiceResponse responseModel = VendorEditServiceResponse.fromJson(results);
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
  void setAllErrorToFalse() {
    isCostEmpty = false;
    isDurationEmpty = false;
  }

  ///*
  ///
  ///
  navigateToListScreen() {
    Get.back();
  }
}