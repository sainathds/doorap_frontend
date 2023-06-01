import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_ap/common/helperclass/customdialog.dart';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/model/request/city_list_request.dart';
import 'package:door_ap/common/model/request/logout_request.dart';
import 'package:door_ap/common/model/response/city_list_response.dart' as cityListResponse;
import 'package:door_ap/common/model/response/country_list_response.dart' as countryListResponse;
import 'package:door_ap/common/model/response/logout_response.dart';
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/screen/social_login_screen.dart';
import 'package:door_ap/common/utils/firestore_constants.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/model/request/vendor_delete_account_request.dart';
import 'package:door_ap/vendor/model/request/vendor_edit_profile_request.dart';
import 'package:door_ap/vendor/model/response/vendor_delete_service_response.dart';
import 'package:door_ap/vendor/model/response/vendor_edit_profile_response.dart';
import 'package:door_ap/vendor/screen/vendor_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VendorShowEditProfileController extends GetxController{

  String tag = "VendorShowEditProfileController ";
  late Function refreshPage;

  TextEditingController nameEditController = TextEditingController();
  TextEditingController aboutMeEditController = TextEditingController();
  TextEditingController businessNameEditController = TextEditingController();
  TextEditingController mobileEditController = TextEditingController();
  TextEditingController locationEditController = TextEditingController();
  TextEditingController address1EditController = TextEditingController();
  TextEditingController address2EditController = TextEditingController();
  TextEditingController zipCodeEditController = TextEditingController();
  TextEditingController idProofEditController = TextEditingController();
  TextEditingController addressProofEditController = TextEditingController();
  int selectedCountryId = 0;
  int selectedCityID = 0 ;
  double latitude = 0.0;
  double longitude = 0.0;
  XFile? imageFile;
  late String serverImageUrl = "";

  FocusNode nameFocus = FocusNode();
  FocusNode aboutMeFocus = FocusNode();
  FocusNode businessNameFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  FocusNode locationFocus = FocusNode();
  FocusNode address1Focus = FocusNode();
  FocusNode address2Focus = FocusNode();
  FocusNode zipCodeFocus = FocusNode();

  bool isNameEmpty = false;
  bool isAboutMeEmpty = false;
  bool isBusinessNameEmpty = false;
  bool isMobileEmpty = false;
  bool isMobileValid = false;
  bool isLocationEmpty = false;
  bool isAddress1Empty = false;
  bool isCountryEmpty = false;
  bool isCityEmpty = false;
  bool isZipCodeEmpty = false;

  List<cityListResponse.Payload> cityList = <cityListResponse.Payload>[];
  List<countryListResponse.Payload> countryList = <countryListResponse.Payload>[];

  countryListResponse.Payload selectedCountry = countryListResponse.Payload();
  cityListResponse.Payload selectedCity = cityListResponse.Payload();

  String? selectedAddressProof;
  bool isAddressProofEmpty = false;
  String? selectedIdProof;
  bool isIdProofEmpty = false;
  



  ///*
  ///
  ///
  void isDataValid() {
    if(nameEditController.text.isEmpty){
      isNameEmpty = true;

    }else if(aboutMeEditController.text.isEmpty){
      isAboutMeEmpty = true;
      isNameEmpty = false;

    }else if(businessNameEditController.text.isEmpty){
      isBusinessNameEmpty = true;
      isAboutMeEmpty = false;
      isNameEmpty = false;

    }else if(mobileEditController.text.isEmpty){
      isMobileEmpty = true;
      isBusinessNameEmpty = false;
      isAboutMeEmpty = false;
      isNameEmpty = false;

    }else if(locationEditController.text.isEmpty){
      isLocationEmpty = true;
      isMobileEmpty = false;
      isBusinessNameEmpty = false;
      isAboutMeEmpty = false;
      isNameEmpty = false;

    }else if(address1EditController.text.isEmpty){
      isAddress1Empty = true;
      isLocationEmpty = false;
      isMobileEmpty = false;
      isBusinessNameEmpty = false;
      isAboutMeEmpty = false;
      isNameEmpty = false;

    }else if(selectedCountryId == 0){
      isCountryEmpty = true;
      isAddress1Empty = false;
      isLocationEmpty = false;
      isMobileEmpty = false;
      isBusinessNameEmpty = false;
      isAboutMeEmpty = false;
      isNameEmpty = false;

    }else if(selectedCityID == 0){
      isCityEmpty = true;
      isCountryEmpty = false;
      isAddress1Empty = false;
      isLocationEmpty = false;
      isMobileEmpty = false;
      isBusinessNameEmpty = false;
      isAboutMeEmpty = false;
      isNameEmpty = false;

    }else if(zipCodeEditController.text.isEmpty){
      isZipCodeEmpty = true;
      isCityEmpty = false;
      isCountryEmpty = false;
      isAddress1Empty = false;
      isLocationEmpty = false;
      isMobileEmpty = false;
      isBusinessNameEmpty = false;
      isAboutMeEmpty = false;
      isNameEmpty = false;

    }else{
      hitEditProfileApi();
    }
  }

  ///*
  ///
  ///
  navigateToHomeScreen() {
    Navigator.pop(Get.context!);
  }

  ///*
  ///
  ///
  void setAllErrorToFalse(){
    isNameEmpty = false;
    isAboutMeEmpty = false;
    isBusinessNameEmpty = false;
    isMobileEmpty = false;
    isMobileValid = false;
    isLocationEmpty = false;
    isAddress1Empty = false;
    isCountryEmpty = false;
    isCityEmpty = false;
    isZipCodeEmpty = false;

  }

  ///*
  ///
  ///
  void hitDeleteAccountApi() async{
    VendorDeleteAccountRequest requestModel = VendorDeleteAccountRequest();
    requestModel.userId = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.userType = "Vendor";


    final results = await Request().requestPostWithHeader(
        url: deleteCustomerVendorApi,
        parameters: json.encode(requestModel),
        context: Get.context);

    try{
      if(results != null){
        VendorDeleteServiceResponse responseModel = VendorDeleteServiceResponse.fromJson(results);
        log(tag + "Response : " + responseModel.toString());
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
                    okBtnFunction: (){
                      String userId = MySharedPreference.getInt(MyConstants.keyUserId).toString();
                      MySharedPreference.logout();
                      logoutFirebaseUser(userId);
                      Navigator.pushAndRemoveUntil(
                          Get.context!, MaterialPageRoute(builder: (context) => SocialLoginScreen()), (route) => false );
                      
                    }
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
      log(tag + "Exception " + exception.toString());
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
  Future<String?> logoutFirebaseUser(String userId) async {
    String? fbUserId = await getFirebaseUserData(userId);

    if (fbUserId != null) {
      FirebaseFirestore.instance
          .collection(FirestoreConstants.pathUsersCollection)
          .doc(fbUserId)
          .update({
        FirestoreConstants.fcmToken: "",
      }).whenComplete(() {

      }).catchError((onError) =>
          log(tag + ' Firestore updateFirebaseUser Exception : ' +
              onError.toString()));
    }
  }



  ///*
  ///
  ///
  Future<String?> getFirebaseUserData(String userId) async{
    String? fbUserId;

    //get user
    QuerySnapshot userData = await FirebaseFirestore.instance
        .collection('Users')
        .where(FirestoreConstants.userId, isEqualTo: userId)
        .get();

    if(userData != null){
      for (QueryDocumentSnapshot document in userData.docs) {
        fbUserId = document.id;
      }
    }
    return fbUserId;
  }
  
  
  ///*
  ///
  ///
  void hitCountryListApi() async{
    final results = await Request().requestGet(
        url: countryListApi,
        context: Get.context);

    try{
      if(results != null){
        countryListResponse.CountryListResponse responseModel = countryListResponse.CountryListResponse.fromJson(results);
        log(tag + "hitGetOtpApi Response : " + responseModel.toString());
        if(responseModel.status == 200){
          if(responseModel.payload != null){
            countryList =  responseModel.payload!;
            for(countryListResponse.Payload data in countryList){
               if(data.id == selectedCountryId){
                 selectedCountry = data;
                 break;
               }
            }
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
      log(tag + "hitGetOtpApi Exception " + exception.toString());
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
  void hitCityListApi() async{
    CityListRequest requestModel = CityListRequest();
    requestModel.id = selectedCountryId;
    final results = await Request().requestPost(
        url: cityListApi,
        context: Get.context,
        parameters: json.encode(requestModel));

    try{
      if(results != null){
        cityListResponse.CityListResponse responseModel = cityListResponse.CityListResponse.fromJson(results);
        log(tag + "hitCityListApi Response : " + json.encode(responseModel));
        if(responseModel.status == 200){
          if(responseModel.payload != null){
            cityList =  responseModel.payload!;

            if(selectedCityID != 0){
              for(cityListResponse.Payload data in cityList){
                if(data.id == selectedCityID){
                  selectedCity = data;
                  log("DefaultCity : " + json.encode(selectedCity));
                  break;
                }
              }
            }else{
              selectedCity = cityList[0];
            }

          }
          refreshPage.call();
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
      log(tag + "hitCityListApi Exception " + exception.toString());
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
  void hitEditProfileApi() async {
    VendorEditProfileRequest requestModel = VendorEditProfileRequest();
    requestModel.id = MySharedPreference.getInt(MyConstants.keyUserId);
    requestModel.fullName = nameEditController.text;
    requestModel.abountMe = aboutMeEditController.text;
    requestModel.businessName = businessNameEditController.text;
    requestModel.mobileNo = mobileEditController.text;
    requestModel.googleAddress = locationEditController.text;
    requestModel.googleAddressLat = latitude;
    requestModel.googleAddressLng = longitude;
    requestModel.addressLineOne = address1EditController.text;
    requestModel.addressLineTwo = address2EditController.text;
    requestModel.fkCountry = selectedCountryId;
    requestModel.fkCity = selectedCityID;
    requestModel.zipCode = int.parse(zipCodeEditController.text);

    if(imageFile != null){
      requestModel.profileImage = imageFile!.path;
    }else{
      requestModel.profileImage = "";
    }

    final results = await Request().editProfileFormDataRequest(
        url: vendorEditProfileApi,
        requestModel: requestModel,
        context: Get.context!,);

    try {
      if (results != null) {

        await results.stream.bytesToString().then((value) {
          VendorEditProfileResponse responseModel = VendorEditProfileResponse.fromJson(json.decode(value));
          log("EditProfileResponse : " + json.encode(responseModel));
          if(responseModel.status == 200) {
            navigateToHomeScreen();
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
      log(tag + "hitEditProfileApi Exception " + exception.toString());
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

}