import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/customer/model/request/customer_slot_available_request.dart';
import 'package:door_ap/customer/model/response/customer_next_six_days_response.dart';
import 'package:door_ap/customer/model/response/customer_slot_available_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerBookSlotController extends GetxController{

  String tag = 'CustomerBookSlotController';
  late Function refreshPage;
  late int categoryId;
  late int vendorId;

  String profileImage = "";
  String vendorName = "";
  String categoryName = "";
  TextEditingController timeEditController = TextEditingController();
  bool isTimeEmpty = false;
  bool isTimeInValid = false;
  bool isSelectPreviousTime = false;

  List<Data> data = <Data>[];
  int currentDateIndex = 0;

  //  List<String> dates = <String>[];



  ///
  ///
  /// get vendor available slots by calling
  /// slot_availability/ Api
  void hitSlotAvailableApi() async{
    CustomerSlotAvailableRequest requestModel = CustomerSlotAvailableRequest();
    requestModel.categoryId = categoryId;
    requestModel.vendorId = vendorId;

    final results = await Request().requestPostWithHeader(
        url: customerSlotAvailabilityApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerSlotAvailableResponse responseModel = CustomerSlotAvailableResponse.fromJson(results);
        log(tag + "hitSlotAvailableApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          if(responseModel.payload != null){
            if(responseModel.payload!.vendorData != null && responseModel.payload!.vendorData!.isNotEmpty ){
              profileImage =  responseModel.payload!.vendorData![0].profileImage!;
              vendorName = responseModel.payload!.vendorData![0].fullName!;
              categoryName = responseModel.payload!.vendorData![0].categoryName!;
            }
            if(responseModel.payload!.data != null && responseModel.payload!.data!.isNotEmpty){
              data.clear();
              data = responseModel.payload!.data!;
              refreshPage.call();
            }
          }
        }else{   // if error occur then msg is "Something went wrong or validation msg"
          log("hitSlotAvailableApi Error : ");

        }
      }
    }catch(exception){
      log("hitSlotAvailableApi Exception : " + exception.toString());
    }

  }



  ///*
  ///
  ///
/*
  void hitGetNextSixDays() async{
    CustomerSlotAvailableRequest requestModel = CustomerSlotAvailableRequest();
    requestModel.categoryId = categoryId;
    requestModel.vendorId = vendorId;

    final results = await Request().requestPostWithHeader(
        url: customerNextSixDaysApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerNextSixDaysResponse responseModel = CustomerNextSixDaysResponse.fromJson(results);
        log(tag + "hitGetNextSixDays Response : " + responseModel.toString());

        if(responseModel.status == 200){
          if(responseModel.payload != null){
            if(responseModel.payload!.vendorData != null && responseModel.payload!.vendorData!.isNotEmpty ){
              profileImage =  responseModel.payload!.vendorData![0].profileImage!;
              vendorName = responseModel.payload!.vendorData![0].fullName!;
              categoryName = responseModel.payload!.vendorData![0].categoryName!;
              if(responseModel.payload!.date != null && responseModel.payload!.date!.isNotEmpty){
                dates.clear();
                dates = responseModel.payload!.date!;
                hitGetSlotDataApi(dates[0]);

              }
              refreshPage.call();
            }
          }
        }else{   // if error occur then msg is "Something went wrong or validation msg"
          log("hitGetNextSixDays Error : ");

        }
      }
    }catch(exception){
      log("hitGetNextSixDays Exception : " + exception.toString());
    }

  }
*/

  ///*
  ///
  ///
/*
  void hitGetSlotDataApi(String date) async{
    timeEditController.clear();
    CustomerSlotRequest requestModel = CustomerSlotRequest();
    requestModel.slotDate = date;
    requestModel.vendorId = vendorId.toString();

    final results = await Request().requestPostWithHeader(
        url: customerSlotDetailsApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerSlotResponse responseModel = CustomerSlotResponse.fromJson(results);
        log(tag + "hitGetSlotDataApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          if(responseModel.payload != null){
            if(responseModel.payload!.slotDetails != null && responseModel.payload!.slotDetails!.isNotEmpty){
              slotData.clear();
              slotData = responseModel.payload!.slotDetails!;
              refreshPage.call();
            }else{
              slotData.clear();
              refreshPage.call();
            }

            if(responseModel.payload!.status != null && responseModel.payload!.status!.isNotEmpty){
              scheduleData.clear();
              scheduleData = responseModel.payload!.status!;
              refreshPage.call();

            }else{
              scheduleData.clear();
              refreshPage.call();

            }

          }else{
            slotData.clear();
            refreshPage.call();

          }
        }else{   // if error occur then msg is "Something went wrong or validation msg"
          log("hitGetSlotDataApi Error : ");
          slotData.clear();
          refreshPage.call();
        }
      }
    }catch(exception){
      log("hitGetSlotDataApi Exception : " + exception.toString());
      slotData.clear();
      refreshPage.call();

    }

  }
*/

}