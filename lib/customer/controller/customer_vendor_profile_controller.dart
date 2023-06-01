import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/customer/model/request/customer_vendor_profile_request.dart';
import 'package:door_ap/customer/model/response/customer_vendor_profile_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomerVendorProfileController extends GetxController{

  String tag = "CustomerVendorProfileController";
  late String vendorId;
  late int categoryId;
  late Function refreshPage;

  String profileImage = "";
  String vendorName = "";
  String categoryName = "";

  String aboutVendor = "";
  double ratings = 0.0;
  String avgRatingCount = '';

  List<ReviewAndFeedback>? reviewAndFeedbackData = <ReviewAndFeedback>[];


  ///*
  ///
  ///
  ///
  clearData(){
     profileImage = "";
     vendorName = "";
     categoryName = "";

     aboutVendor = "";
     ratings = 0.0;
     avgRatingCount = '';

     reviewAndFeedbackData!.clear();
  }

  ///*
  ///
  /// get selected vendor profile data by calling show_vendor_profile/ Api
  void hitVendorProfileApi() async{

    CustomerVendorProfileRequest requestModel = CustomerVendorProfileRequest();
    requestModel.vendorId = vendorId;
    requestModel.categoryId = categoryId.toString();

    final results = await Request().requestPostWithHeader(
        url: customerVendorProfileApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerVendorProfileResponse responseModel = CustomerVendorProfileResponse.fromJson(results);
        log(tag + "hitVendorProfileApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          if(responseModel.payload != null){
            profileImage =  responseModel.payload!.vendorProfile![0].fkVendorProfileImage!;
            vendorName = responseModel.payload!.vendorProfile![0].fkVendorFullName!;
            categoryName = responseModel.payload!.vendorProfile![0].fkCategoryCategoryName!;
            aboutVendor = responseModel.payload!.vendorProfile![0].fkVendorAbountMe!;
            ratings = responseModel.payload!.vendorProfile![0].rating!;
            avgRatingCount = responseModel.payload!.vendorProfile![0].averageCount!;

            reviewAndFeedbackData!.clear();
            if(responseModel.payload!.reviewAndFeedback != null && responseModel.payload!.reviewAndFeedback!.isNotEmpty){
              reviewAndFeedbackData = responseModel.payload!.reviewAndFeedback!;
            }
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

      log(tag + "hitVendorProfileApi Exception " + exception.toString());
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