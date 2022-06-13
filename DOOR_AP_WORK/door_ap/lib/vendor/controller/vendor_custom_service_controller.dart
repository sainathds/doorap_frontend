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
import 'package:door_ap/vendor/model/request/vendor_custom_service_request.dart';
import 'package:door_ap/vendor/model/response/vendor_custom_service_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VendorCustomServiceController extends GetxController{

  String tag = "VendorCustomServiceController";

  XFile? imageFile;
  TextEditingController nameEditController = TextEditingController();
  TextEditingController facilityEditController = TextEditingController();
  List<String> facilityList = <String>[];
  bool isUpdate = false;
  late int updateItemIndex ;
  late int categoryId;

  bool isNameEmpty = false;
  bool isFacilityEmpty = false;

  ///*
  ///
  ///
  void isDataValid(){

    if(nameEditController.text.isEmpty){
      isNameEmpty = true;

    }else if(facilityList.isEmpty && facilityEditController.text.trim().isEmpty) {
      isNameEmpty = false;
      isFacilityEmpty = true;

    }else if(facilityEditController.text.trim().isNotEmpty){
        isNameEmpty = false;
        isFacilityEmpty = false;
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) =>
              OKDialog(
                title: "",
                descriptions: "Please add facility to list",
                img: errorImage,
                text: '',
                key: null,
              ),
        );

    }else if(imageFile == null){
      isNameEmpty = false;
      isFacilityEmpty = false;
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please select service image",
          img: errorImage,
          text: '',
          key: null,
        ),
      );

    }else{
      hitCustomServiceApi();
    }
  }

  ///
  ///
  ///
  void hitCustomServiceApi() async{
    List<String> modifiedList = <String>[];
    VendorCustomServiceRequest requestModel = VendorCustomServiceRequest();
    requestModel.vendorId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.customServiceImage = imageFile!.path;
    requestModel.customServiceName = nameEditController.text;
    requestModel.categoryId = categoryId;
    requestModel.customServicePrice = 0.0;
    requestModel.customServiceTime = "00:00:00";
    for(int index=0; index<facilityList.length; index++ ){
        String facility = '"${facilityList[index]}"';
        modifiedList.add(facility);
      }

    requestModel.customFacilityName = modifiedList;

    final results = await Request().saveCustomServiceFormDataRequest(
        url: vendorCustomServicesApi,
        requestModel: requestModel,
        context: Get.context!);

    try {
      if (results != null) {
        await results.stream.bytesToString().then((value) {
          VendorCustomServiceResponse responseModel = VendorCustomServiceResponse.fromJson(json.decode(value));

          if(responseModel.status == 200) {
            showDialog(
              context: Get.context!,
              builder: (BuildContext context1) =>
                  CustomDialog(
                      my_context: Get.context!,
                      img: successImage,
                      title: "",
                      description: responseModel.msg!,
                      buttonText: 'Ok',
                      okBtnFunction: navigateToBack
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
        });
      }
    } catch (exception) {
      log(tag + "hitSignupApi Exception " + exception.toString());
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
  void errorFieldToFalse() {
    isNameEmpty = false;
    isFacilityEmpty = false;
  }



  ///*
  ///
  ///
  navigateToBack() {
    Get.back();
  }

  ///*
  ///
  ///
  void clearField() {
    nameEditController.clear();
    facilityEditController.clear();
    facilityList.clear();
    imageFile = null;
  }
}