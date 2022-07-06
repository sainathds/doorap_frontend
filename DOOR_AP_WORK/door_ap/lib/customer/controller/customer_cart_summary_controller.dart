import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/model/request/customer_get_cart_item_request.dart';
import 'package:door_ap/customer/model/request/customer_promcode_request.dart';
import 'package:door_ap/customer/model/request/customer_remove_cart_item_request.dart';
import 'package:door_ap/customer/model/request/customer_update_cart_item_request.dart';
import 'package:door_ap/customer/model/response/customer_get_cart_item_response.dart';
import 'package:door_ap/customer/model/response/customer_promo_code_response.dart';
import 'package:door_ap/customer/model/response/customer_remove_cart_item_response.dart';
import 'package:door_ap/customer/model/response/customer_update_cart_item_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerCartSummaryController extends GetxController{

  String tag = 'CustomerCartSummaryController';

  //Add to cart data
  List<CartData>? cartData = <CartData>[] ;
  Calculation calculation = Calculation();

  int itemCount = 0;
  double subTotalPrice = 0.0;
  double convenienceFees = 0.0;
  double totalAmount = 0.0;
  String averageTime = "";
  double discount = 0.0;
  bool isPromoCodeApplied = false;
  String appliedId = "";
  String offerId = "";
  String appliedStatus = "False";
  String promoCodeMsg = "";


  TextEditingController promoCodeController = TextEditingController();
  bool isPromoCodeClick = false;
  bool isPromoCodeEmpty = false;


  late int categoryId;
  late String countryName;

  late Function refreshPage;


  ///*
  ///
  ///
  void hitGetCartItemApi() async{

    CustomerGetCartItemRequest requestModel = CustomerGetCartItemRequest();
    requestModel.customerId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.categoryId = categoryId;
    requestModel.countryName = countryName;


    final results = await Request().requestPostWithHeader(
        url: customerGetCartItemApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerGetCartItemResponse responseModel = CustomerGetCartItemResponse.fromJson(results);
        log(tag + "hitGetCartItemApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          if(responseModel.payload != null){
            if(responseModel.payload!.cartData != null && responseModel.payload!.cartData!.isNotEmpty){
              cartData!.clear();
              cartData = responseModel.payload!.cartData!;
              calculation = responseModel.payload!.calculation![0];

               itemCount = calculation.itemCount!;
               subTotalPrice = calculation.subTotal!;
               convenienceFees = calculation.convenienceFee!;
               totalAmount = calculation.totalAmount!;
               averageTime = calculation.averageTime!.toString();
               discount = calculation.discount!;
               isPromoCodeApplied = calculation.isPromocdeApplied!;
               appliedId = calculation.appliedId!.toString();
               offerId  = calculation.offerId!.toString();
               appliedStatus = calculation.isPromocdeApplied!.toString().capitalizeFirst!;
               promoCodeMsg = calculation.prmocodeMsg!;

               refreshPage.call();
            }
          }
        }else{   // if error occur then msg is "Something went wrong or validation msg"
          cartData!.clear();
          refreshPage.call();
          log("hitGetCartItemApi Error : ");

        }
      }
    }catch(exception){
      cartData!.clear();
      refreshPage.call();
      log("hitGetCartItemApi Exception : " + exception.toString());
    }

  }



  ///*
  ///
  ///
  void hitRemoveFromCartApi(int itemId) async{

    CustomerRemoveCartItemRequest requestModel = CustomerRemoveCartItemRequest();
    requestModel.cartId = itemId;
    requestModel.customerId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.offerId = offerId;
    requestModel.appliedId = appliedId;
    requestModel.appliedStatus = appliedStatus;


    final results = await Request().requestPostWithHeader(
        url: customerRemoveCartItemApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerRemoveCartItemResponse responseModel = CustomerRemoveCartItemResponse.fromJson(results);
        log(tag + "hitRemoveFromCartApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          hitGetCartItemApi();

        }else{   // if error occur then msg is "Something went wrong or validation msg"
          log("hitRemoveFromCartApi Error : ");

        }
      }
    }catch(exception){
      log("hitRemoveFromCartApi Exception : " + exception.toString());
    }

  }


  ///*
  ///
  ///
  void hitUpdateCartItemApi(CartData cartDataItem) async{

    CustomerUpdateCartItemRequest requestModel = CustomerUpdateCartItemRequest();
    requestModel.cartId = cartDataItem.id;
    requestModel.vendorId = cartDataItem.fkVendor!.toString();
    requestModel.customerId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.country = countryName;
    requestModel.quantity = cartDataItem.quantity;
    requestModel.price = cartDataItem.price;
    requestModel.categoryId = categoryId;

    final results = await Request().requestPostWithHeader(
        url: customerUpdateCartItemApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerUpdateCartItemResponse responseModel = CustomerUpdateCartItemResponse.fromJson(results);
        log(tag + "hitUpdateCartItemApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
          hitGetCartItemApi();
        }else{   // if error occur then msg is "Something went wrong or validation msg"
          log("hitUpdateCartItemApi Error : ");

        }
      }
    }catch(exception){
      log("hitUpdateCartItemApi Exception : " + exception.toString());
    }

  }

  ///*
  ///
  ///
  void isCodeDataValid(String callFrom) {

    if(callFrom == 'ApplyCode'){
      if(promoCodeController.text.isEmpty){
        isPromoCodeEmpty = true;
      }else{
        isPromoCodeEmpty = false;
        hitApplyPromoCodeApi(callFrom, promoCodeController.text.trim(), 'False');
      }
    }else{
      hitApplyPromoCodeApi(callFrom, MySharedPreference.getString(MyConstants.keyPromoCode), 'True');

    }
  }

  ///*
  ///
  ///
  void hitApplyPromoCodeApi(String callFrom, String promocode, String cancelStatus) async{

    CustomerPromocodeRequest requestModel = CustomerPromocodeRequest();
    requestModel.customerId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.coupon = promocode;
    requestModel.countryName = countryName;
    requestModel.categoryId = categoryId;
    requestModel.cancelStatus = cancelStatus;
    requestModel.appliedId = appliedId;

    final results = await Request().requestPostWithHeader(
        url: customerPromocodeApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        CustomerPromocodeResponse responseModel = CustomerPromocodeResponse.fromJson(results);
        log(tag + "hitApplyPromoCodeApi Response : " + responseModel.toString());

        if(responseModel.status == 200){
         MySharedPreference.setString(MyConstants.keyPromoCode, promoCodeController.text.trim());
         promoCodeController.clear();
         hitGetCartItemApi();

        }else{   // if error occur then msg is "Something went wrong or validation msg"
          log("hitApplyPromoCodeApi Error : ");
          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: responseModel.msg,
              img: errorImage,
              text: '',
              key: null,
            ),
          );
        }
      }
    }catch(exception){
      log("hitApplyPromoCodeApi Exception : " + exception.toString());
    }

  }


}