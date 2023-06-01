import 'dart:convert';
import 'dart:developer';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_internet_connection.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/model/request/vendor_custom_service_request.dart';
import 'package:door_ap/vendor/model/request/vendor_edit_profile_request.dart';
import 'package:door_ap/vendor/model/request/vendor_save_profile_request.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class Request{

  ///*
  ///
  ///
  Future<Map?> requestPost({required String url, required String parameters, context}) async {
    final ProgressDialog _progressDialog = ProgressDialog(context: context);

      _progressDialog.show(
        msg: "Please wait...",
        max: 100,
        progressBgColor: Colors.yellow,
        backgroundColor: MyColor.themeBlue,
        msgColor: Colors.white,
        msgFontSize: MyDimens.textSize18,
        msgFontWeight: FontWeight.bold,);

   print("API :" + url);
   print("RequestBody :" + parameters);
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post( uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          _progressDialog.close();

          final jsonObject = json.decode(results.body);
           print("Response :" + jsonObject.toString());
          return jsonObject;

        } else{
         print("Request API : null ");
         _progressDialog.close();

          await showDialog(
            context: context,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );
          return null;

        }

      }catch(exception){
       print("Request API Exception: " + exception.toString());
        _progressDialog.close();
       await showDialog(
          context: context,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage!,
            img: errorImage,
            text: '',
            key: null,
          ),
        );
        return null;

      }

    } else {
      _progressDialog.close();
     print("Request API : No Net ");

     await showDialog(
        context: context,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
          text: '',
          key: null,
        ),
      );
      return null;
    }

  }
  ///*
  ///
  ///
/*
  Future<Map?> requestPost2({required String url, required String parameters, context}) async {
    final ProgressDialog _progressDialog = ProgressDialog(context: context);

      _progressDialog.show(
        msg: "Please wait...",
        max: 100,
        progressBgColor: Colors.yellow,
        backgroundColor: MyColor.themeBlue,
        msgColor: Colors.white,
        msgFontSize: MyDimens.textSize18,
        msgFontWeight: FontWeight.bold,);

   print("API :" + url);
   print("RequestBody :" + parameters);
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post( uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          _progressDialog.close();

          final jsonObject = json.decode(results.body);
          print("Response :" + jsonObject.toString());
          return jsonObject;

        } else{
          _progressDialog.close();

          print("Request API : null ");
          await showDialog(
            context: context,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );
          return null;

        }

      }catch(exception){
       print("Request API Exception: " + exception.toString());
        _progressDialog.close();
       await showDialog(
          context: context,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage!,
            img: errorImage,
            text: '',
            key: null,
          ),
        );
        return null;

      }

    } else {
      _progressDialog.close();
     print("Request API : No Net ");

     await showDialog(
        context: context,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
          text: '',
          key: null,
        ),
      );
      return null;
    }

  }
*/


  ///*
  ///
  ///
  Future<Map?> requestPostWithHeader({required String url, required String parameters, context}) async {
    final ProgressDialog _progressDialog = ProgressDialog(context: context);

    MySharedPreference.getInstance();
   print("API_TOKEN :" + MySharedPreference.getString(MyConstants.keyAccessToken));

    _progressDialog.show(
      msg: "Please wait...",
      max: 100,
      progressBgColor: Colors.yellow,
      backgroundColor: MyColor.themeBlue,
      msgColor: Colors.white,
      msgFontSize: MyDimens.textSize18,
      msgFontWeight: FontWeight.bold,);

   print("API :" + url);
   print("RequestBody :" + parameters);
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters,
            headers:
            {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${MySharedPreference.getString(MyConstants.keyAccessToken)}"
             });

        if (results.statusCode == 200) {

         print("XYZ :" + results.body);
          // _progressDialog.close();
          Navigator.pop(context);
          final jsonObject = json.decode(utf8.decode(results.bodyBytes));
         print("Response JSON :" + jsonObject.toString());
          return jsonObject;

        } else{
          _progressDialog.close();
         print("Request API : null ");

          showDialog(
            context: context,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );
          return null;

        }

      }catch(exception){
       print("Request API Exception: " + exception.toString());
        _progressDialog.close();
        showDialog(
          context: context,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage!,
            img: errorImage,
            text: '',
            key: null,
          ),
        );
        return null;

      }

    } else {
      _progressDialog.close();
     print("Request API : No Net ");

      showDialog(
        context: context,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
          text: '',
          key: null,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<Map?> requestPostHeaderNoProgressBar({required String url, required String parameters, context}) async {

    MySharedPreference.getInstance();
   print("API_TOKEN :" + MySharedPreference.getString(MyConstants.keyAccessToken));

   print("API :" + url);
   print("RequestBody :" + parameters);
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters,
            headers:
            {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${MySharedPreference.getString(MyConstants.keyAccessToken)}"
            });

        if (results.statusCode == 200) {

         print("XYZ :" + results.body);
          final jsonObject = json.decode(utf8.decode(results.bodyBytes));
         print("Response JSON :" + jsonObject.toString());
          return jsonObject;

        } else{
         print("Request API : null ");

          /*showDialog(
            context: context,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );*/
          return null;

        }

      }catch(exception){
       print("Request API Exception: " + exception.toString());
        /*showDialog(
          context: context,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage!,
            img: errorImage,
            text: '',
            key: null,
          ),
        );*/
        return null;

      }

    } else {
     print("Request API : No Net ");

      showDialog(
        context: context,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
          text: '',
          key: null,
        ),
      );
      return null;
    }

  }

  ///*
  ///
  ///PATCH use to update
  Future<Map?> requestPatchWithHeader({required String url, required String parameters, context}) async {
    final ProgressDialog _progressDialog = ProgressDialog(context: context);

    MySharedPreference.getInstance();
   print("API_TOKEN :" + MySharedPreference.getString(MyConstants.keyAccessToken));

    _progressDialog.show(
      msg: "Please wait...",
      max: 100,
      progressBgColor: Colors.yellow,
      backgroundColor: MyColor.themeBlue,
      msgColor: Colors.white,
      msgFontSize: MyDimens.textSize18,
      msgFontWeight: FontWeight.bold,);

   print("API :" + url);
   print("RequestBody :" + parameters);
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.patch(uri,
            body: parameters,
            headers:
            {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${MySharedPreference.getString(MyConstants.keyAccessToken)}"
            });

        if (results.statusCode == 200) {
          Navigator.pop(context);
          final jsonObject = json.decode(results.body);
         print("Response :" + jsonObject.toString());
          return jsonObject;

        } else{
          Navigator.pop(context);
         print("Request API : null ");

          showDialog(
            context: context,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );
          return null;

        }

      }catch(exception){
       print("Request API Exception: " + exception.toString());
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage!,
            img: errorImage,
            text: '',
            key: null,
          ),
        );
        return null;

      }

    } else {
      Navigator.pop(context);
      print("Request API : No Net ");

      showDialog(
        context: context,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
          text: '',
          key: null,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<Map?> requestGet({required String url, context}) async {
    final ProgressDialog _progressDialog = ProgressDialog(context: context);

    _progressDialog.show(
      msg: "Please wait...",
      max: 100,
      progressBgColor: Colors.yellow,
      backgroundColor: MyColor.themeBlue,
      msgColor: Colors.white,
      msgFontSize: MyDimens.textSize18,
      msgFontWeight: FontWeight.bold,);

    print("API :" + url);
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        print("Url :" + uri.toString());
        final results = await http.get(
            uri,
            headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          Navigator.pop(context);
          final jsonObject = json.decode(results.body);
          print("Response :" + jsonObject.toString());
          return jsonObject;

        } else{
          Navigator.pop(context);
          print("Request API : null ");

          showDialog(
            context: context,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );
          return null;

        }

      }catch(exception){
        print("Request API Exception: " + exception.toString());
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage!,
            img: errorImage,
            text: '',
            key: null,
          ),
        );
        return null;

      }

    } else {
      Navigator.pop(context);
     print("Request API : No Net ");

      showDialog(
        context: context,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
          text: '',
          key: null,
        ),
      );
      return null;
    }
  }


  ///*
  ///
  ///
  Future<Map?> requestGetWithHeader({required String url, context}) async {
    final ProgressDialog _progressDialog = ProgressDialog(context: context);
    MySharedPreference.getInstance();
   print("API_TOKEN :" + MySharedPreference.getString(MyConstants.keyAccessToken));

    _progressDialog.show(
      msg: "Please wait...",
      max: 100,
      progressBgColor: Colors.yellow,
      backgroundColor: MyColor.themeBlue,
      msgColor: Colors.white,
      msgFontSize: MyDimens.textSize18,
      msgFontWeight: FontWeight.bold,);

   print("API :" + url);
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.get(
            uri,
            headers:
            {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${MySharedPreference.getString(MyConstants.keyAccessToken)}"
            });

        if (results.statusCode == 200) {
          Navigator.pop(context);
          final jsonObject = json.decode(results.body);
         print("Response :" + jsonObject.toString());
          return jsonObject;

        } else{
          Navigator.pop(context);
         print("Request API : null ");

          showDialog(
            context: context,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );
          return null;

        }

      }catch(exception){
       print("Request API Exception: " + exception.toString());
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage!,
            img: errorImage,
            text: '',
            key: null,
          ),
        );
        return null;

      }

    } else {
      Navigator.pop(context);
     print("Request API : No Net ");

      showDialog(
        context: context,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
          text: '',
          key: null,
        ),
      );
      return null;
    }
  }


  ///*
  ///
  ///
  Future<StreamedResponse> saveProfileFormDataRequest({required BuildContext context, required String url, required VendorSaveProfileRequest requestModel}) async{

    MySharedPreference.getInstance();
    final ProgressDialog _progressDialog = ProgressDialog(context: context);


    _progressDialog.show(
      msg: "Please wait...",
      max: 100,
      progressBgColor: Colors.yellow,
      backgroundColor: MyColor.themeBlue,
      msgColor: Colors.white,
      msgFontSize: MyDimens.textSize18,
      msgFontWeight: FontWeight.bold,);

   print("API :" + url);
   print("ACCESS_TOKEN :" + MySharedPreference.getString(MyConstants.keyAccessToken));
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if(flagNet){
      try{
        var headers = {
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer ${MySharedPreference.getString(MyConstants.keyAccessToken)}"
        };

        final data = {
          'email': requestModel.email,
          'full_name': requestModel.fullName,
          'abount_me': requestModel.abountMe,
          'business_name': requestModel.businessName,
          'mobile_no': requestModel.mobileNo,
          'google_address': requestModel.googleAddress,
          'google_address_lat': requestModel.googleAddressLat,
          'google_address_lng': requestModel.googleAddressLng,
          'address_line_one': requestModel.addressLineOne,
          'address_line_two': requestModel.addressLineTwo,
          'fk_country': requestModel.fkCountry,
          'fk_city': requestModel.fkCity,
          'zip_code': requestModel.zipCode,
        };

        var request = http.MultipartRequest('POST', Uri.parse(url));
        request = jsonToFormData(request, data);

        if(requestModel.profileImage != ""){
          request.files.add(await http.MultipartFile.fromPath('profile_image', requestModel.profileImage!));
        }
        if(requestModel.idProofFile != ""){
          request.files.add(await http.MultipartFile.fromPath('photo_id_proof', requestModel.idProofFile!));
        }
        if(requestModel.addressProofFile != ""){
          request.files.add(await http.MultipartFile.fromPath('address_proof', requestModel.addressProofFile!));
        }
        request.headers.addAll(headers);

       print("ProfileRequest :" + request.fields.toString());

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          Navigator.pop(context);
          return response;

        } else{
          Navigator.pop(context);
         print("Request API : null ");

          showDialog(
            context: context,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );
          throw '';
        }
      }catch(exception){
       print("Request API Exception: " + exception.toString());
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage!,
            img: errorImage,
            text: '',
            key: null,
          ),
        );
        throw '';

      }

    }else{
      Navigator.pop(context);
     print("Request API : No Net ");

      showDialog(
        context: context,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
          text: '',
          key: null,
        ),
      );
      throw '';
    }
  }


  ///*
  ///
  ///
  Future<StreamedResponse> editProfileFormDataRequest({required BuildContext context, required String url, required VendorEditProfileRequest requestModel}) async{

    MySharedPreference.getInstance();
    final ProgressDialog _progressDialog = ProgressDialog(context: context);


    _progressDialog.show(
      msg: "Please wait...",
      max: 100,
      progressBgColor: Colors.yellow,
      backgroundColor: MyColor.themeBlue,
      msgColor: Colors.white,
      msgFontSize: MyDimens.textSize18,
      msgFontWeight: FontWeight.bold,);

   print("API :" + url);
   print("ACCESS_TOKEN :" + MySharedPreference.getString(MyConstants.keyAccessToken));
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if(flagNet){
      try{
        var headers = {
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer ${MySharedPreference.getString(MyConstants.keyAccessToken)}"
        };

        final data = {
          'id':requestModel.id,
          'full_name': requestModel.fullName,
          'abount_me': requestModel.abountMe,
          'business_name': requestModel.businessName,
          'mobile_no': requestModel.mobileNo,
          'google_address': requestModel.googleAddress,
          'google_address_lat': requestModel.googleAddressLat,
          'google_address_lng': requestModel.googleAddressLng,
          'address_line_one': requestModel.addressLineOne,
          'address_line_two': requestModel.addressLineTwo,
          'fk_country': requestModel.fkCountry,
          'fk_city': requestModel.fkCity,
          'zip_code': requestModel.zipCode,
        };

        var request = http.MultipartRequest('POST', Uri.parse(url));
        request = jsonToFormData(request, data);

        if(requestModel.profileImage == ""){
          request.fields['profile_image'] = "";
        }else{
          request.files.add(await http.MultipartFile.fromPath('profile_image', requestModel.profileImage!));
        }

        request.headers.addAll(headers);
       print("EditProfileRequest :" + request.fields.toString());

        // Duration duration = const Duration(seconds: 60);
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          Navigator.pop(context);
          return response;

        } else{
          Navigator.pop(context);
         print("Request API : null ");

          showDialog(
            context: context,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );
          throw '';
        }
      }catch(exception){
       print("Request API Exception: " + exception.toString());
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage!,
            img: errorImage,
            text: '',
            key: null,
          ),
        );
        throw '';

      }

    }else{
      Navigator.pop(context);
     print("Request API : No Net ");

      showDialog(
        context: context,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
          text: '',
          key: null,
        ),
      );
      throw '';
    }
  }


  ///*
  ///
  ///
  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }


  ///*
  ///
  ///
  Future<StreamedResponse> saveCustomServiceFormDataRequest({required BuildContext context, required String url, required VendorCustomServiceRequest requestModel}) async{
    MySharedPreference.getInstance();
    final ProgressDialog _progressDialog = ProgressDialog(context: context);


    _progressDialog.show(
      msg: "Please wait...",
      max: 100,
      progressBgColor: Colors.yellow,
      backgroundColor: MyColor.themeBlue,
      msgColor: Colors.white,
      msgFontSize: MyDimens.textSize18,
      msgFontWeight: FontWeight.bold,);

   print("API :" + url);
   print("ACCESS_TOKEN :" + MySharedPreference.getString(MyConstants.keyAccessToken));
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if(flagNet){
      try{
        var headers = {
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer ${MySharedPreference.getString(MyConstants.keyAccessToken)}"
        };

        final data = {
          'vendor_id': requestModel.vendorId,
          'custom_service_name': requestModel.customServiceName,
          'category_id': requestModel.categoryId,
          'custom_service_price': requestModel.customServicePrice,
          'custom_service_time': requestModel.customServiceTime,
          'custom_facility_name': requestModel.customFacilityName,
        };

        var request = http.MultipartRequest('POST', Uri.parse(url));
        request = jsonToFormData(request, data);

        if(requestModel.customServiceImage != ""){
         print("CUSTOM SERVICE IMG : " + requestModel.customServiceImage!);
          request.files.add(await http.MultipartFile.fromPath('custom_service_image', requestModel.customServiceImage!));
        }
        request.headers.addAll(headers);

       print("CustomServiceRequest :" + request.fields.toString());

        // Duration duration = const Duration(seconds: 60);
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          Navigator.pop(context);
          return response;

        } else{
          Navigator.pop(context);
         print("Request API : null ");

          showDialog(
            context: context,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );
          throw '';
        }
      }catch(exception){
       print("Request API Exception: " + exception.toString());
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage!,
            img: errorImage,
            text: '',
            key: null,
          ),
        );
        throw '';

      }

    }else{
      Navigator.pop(context);
     print("Request API : No Net ");

      showDialog(
        context: context,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
          text: '',
          key: null,
        ),
      );
      throw '';
    }
  }



  ///*
  ///
  ///
  Future<Map?> requestSendPushNotification({required String url, required String parameters, context}) async {

   print("API :" + url);
   print("RequestBody :" + parameters);
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters,
            headers:
            {
              "Content-Type": "application/json",
              "Authorization": "key = ${MyString.firebaseServerToken}"
            });

        if (results.statusCode == 200) {

         print("requestSendPushNotification RequestBody :" + results.body);
          final jsonObject = json.decode(utf8.decode(results.bodyBytes));
         print("requestSendPushNotification Response :" + jsonObject.toString());
          return jsonObject;

        } else{
         print("Request API : null ");

          /*showDialog(
            context: context,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage!,
              img: errorImage,
              text: '',
              key: null,
            ),
          );*/
          return null;

        }

      }catch(exception){
       print("Request API Exception: " + exception.toString());
        /*showDialog(
          context: context,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage!,
            img: errorImage,
            text: '',
            key: null,
          ),
        );*/
        return null;

      }

    } else {
     print("Request API : No Net ");

      /*showDialog(
        context: context,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
          text: '',
          key: null,
        ),
      );*/
      return null;
    }

  }

}