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
import 'package:door_ap/vendor/model/other/week_days_data.dart';
import 'package:door_ap/vendor/model/request/vendor_get_schedule_request.dart';
import 'package:door_ap/vendor/model/request/vendor_set_schedule_request.dart';
import 'package:door_ap/vendor/model/response/vendor_get_schedule_response.dart';
import 'package:door_ap/vendor/model/response/vendor_set_schedule_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorSetScheduleController extends GetxController{

  String tag = "VendorSetScheduleController";
  late Function refreshPage;

  List<WeekDaysData> weekDaysData = <WeekDaysData>[];
  TextEditingController fromTimeEditController = TextEditingController();
  TextEditingController toTimeEditController = TextEditingController();

  bool isWeekSelected = false;
  bool isFromTimeEmpty = false;
  bool isToTimeEmpty = false;

  bool isMonday = false;
  bool isTuesday = false;
  bool isWednesday = false;
  bool isThursday = false;
  bool isFriday = false;
  bool isSaturday = false;
  bool isSunday = false;

  //get api response use to identify is create time or update time
  bool isSetStatus = false;

  void isDataValid(){
     if(fromTimeEditController.text.isEmpty){
      // isFromTimeEmpty = true;
      showDialog(
          context: Get.context!,
          builder: (BuildContext context1) =>
              OKDialog(
                title: "",
                descriptions: "Please select From Time",
                img: errorImage,
                text: '',
                key: null,
              ));
    }else if(toTimeEditController.text.isEmpty){
      // isToTimeEmpty = true;
      // isFromTimeEmpty = false;
       showDialog(
           context: Get.context!,
           builder: (BuildContext context1) =>
               OKDialog(
                 title: "",
                 descriptions: "Please select To Time",
                 img: errorImage,
                 text: '',
                 key: null,
               ));

    }else {
      hitCreateUpdateScheduleApi();
    }

  }


  ///*
  ///
  /// Set / update schedule by calling set_schedule/ Api
  void hitCreateUpdateScheduleApi() async{
    VendorSetScheduleRequest requestModel = VendorSetScheduleRequest();
    requestModel.vendorId = MySharedPreference.getInt(MyConstants.keyUserId).toString();
    requestModel.data = Data();
    requestModel.data!.isMonday = weekDaysData[0].isSelected.toString().capitalizeFirst;
    requestModel.data!.isTuesday = weekDaysData[1].isSelected.toString().capitalizeFirst;
    requestModel.data!.isWednesday = weekDaysData[2].isSelected.toString().capitalizeFirst;
    requestModel.data!.isThursday = weekDaysData[3].isSelected.toString().capitalizeFirst;
    requestModel.data!.isFriday = weekDaysData[4].isSelected.toString().capitalizeFirst;
    requestModel.data!.isSaturday = weekDaysData[5].isSelected.toString().capitalizeFirst;
    requestModel.data!.isSunday = weekDaysData[6].isSelected.toString().capitalizeFirst;
    requestModel.data!.fromDate = fromTimeEditController.text;
    requestModel.data!.toDate = toTimeEditController.text;


    final results = await Request().requestPostWithHeader(
        url: vendorSetUpdateScheduleApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try {
      if (results != null) {
        VendorSetScheduleResponse responseModel = VendorSetScheduleResponse.fromJson(results);
        log(tag + "hitSetUpdateScheduleApi Response : " + json.encode(responseModel));
        if (responseModel.status == 200) {
          fromTimeEditController.clear();
          toTimeEditController.clear();
          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) =>
                CustomDialog(
                    my_context: Get.context!,
                    img: successImage,
                    title: "",
                    description: responseModel.msg!,
                    buttonText: 'Ok',
                    okBtnFunction: hitGetScheduleApi
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
      log(tag + "hitSetUpdateScheduleApi Exception " + exception.toString());
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
  /// get previously added schedule data
  void hitGetScheduleApi()  async{

    VendorGetScheduleRequest requestModel = VendorGetScheduleRequest();
    requestModel.vendorId = MySharedPreference.getInt(MyConstants.keyUserId).toString();

    final results = await Request().requestPostWithHeader(
        url: vendorGetScheduleApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        VendorGetScheduleResponse responseModel = VendorGetScheduleResponse.fromJson(results);
        log(tag + "hitGetScheduleApi Response : " + json.encode(responseModel));
        if(responseModel.status == 200){
          if(responseModel.payload != null){

            isSetStatus = responseModel.payload![0].isSetStatus!;
            isMonday = responseModel.payload![0].isMonday!;
            isTuesday = responseModel.payload![0].isTuesday!;
            isWednesday = responseModel.payload![0].isWednesday!;
            isThursday = responseModel.payload![0].isThursday!;
            isFriday = responseModel.payload![0].isFriday!;
            isSaturday = responseModel.payload![0].isSaturday!;
            isSunday = responseModel.payload![0].isSunday!;

            if(responseModel.payload![0].fromTime != null){
              fromTimeEditController.text = responseModel.payload![0].fromTime!;
            }

            if(responseModel.payload![0].toTime != null){
              toTimeEditController.text = responseModel.payload![0].toTime!;
            }

            log("IS_SET_STATUS : " + isSetStatus.toString());
            setWeekDaysData();
            refreshPage.call();

          }
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
      log(tag + "hitGetScheduleApi Exception " + exception.toString());
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
  void setWeekDaysData(){
    weekDaysData.clear();

    WeekDaysData data1 = WeekDaysData();
    data1.weekName = "Mon";
    data1.isSelected = isMonday;
    weekDaysData.add(data1);

    WeekDaysData data2 = WeekDaysData();
    data2.weekName = "Tues";
    data2.isSelected = isTuesday;
    weekDaysData.add(data2);

    WeekDaysData data3 = WeekDaysData();
    data3.weekName = "Wed";
    data3.isSelected = isWednesday;
    weekDaysData.add(data3);

    WeekDaysData data4 = WeekDaysData();
    data4.weekName = "Thu";
    data4.isSelected = isThursday;
    weekDaysData.add(data4);

    WeekDaysData data5 = WeekDaysData();
    data5.weekName = "Fri";
    data5.isSelected = isFriday;
    weekDaysData.add(data5);

    WeekDaysData data6 = WeekDaysData();
    data6.weekName = "Sat";
    data6.isSelected = isSaturday;
    weekDaysData.add(data6);

    WeekDaysData data7 = WeekDaysData();
    data7.weekName = "Sun";
    data7.isSelected = isSunday;
    weekDaysData.add(data7);

    log("WEEKDAYS DATA : " + json.encode(weekDaysData.toString()));
  }



}