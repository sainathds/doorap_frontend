import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/model/request/customer_favourite_vendors_request.dart';
import 'package:door_ap/customer/model/response/customer_favourite_vendors_response.dart';
import 'package:get/get.dart';

class CustomerFavouriteVendorsController extends GetxController{

  String tag = "CustomerVendorsServiceController";
  late Function refreshPage;

  List<Payload>? vendorsData = <Payload>[];


  ///*
  ///
  ///
  void hitFavouriteVendorsApi() async{

    CustomerFavouriteVendorsRequest requestModel = CustomerFavouriteVendorsRequest();
    requestModel.customerId = MySharedPreference.getInt(MyConstants.keyUserId);

    final results = await Request().requestPostWithHeader(
        url: customerFavouriteVendorsApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerFavouriteVendorsResponse responseModel = CustomerFavouriteVendorsResponse.fromJson(results);
        log(tag + "hitCustomerVendorsApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          if(responseModel.payload != null && responseModel.payload!.isNotEmpty ){
            vendorsData!.clear();
            vendorsData = responseModel.payload!;
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