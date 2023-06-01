import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/model/request/city_list_request.dart';
import 'package:door_ap/common/model/response/city_list_response.dart' as cityListResponse;
import 'package:door_ap/common/model/response/country_list_response.dart' as countryListResponse;
import 'package:door_ap/common/network/request.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/model/request/vendor_save_profile_request.dart';
import 'package:door_ap/vendor/model/response/vendor_save_profile_response.dart';
import 'package:door_ap/vendor/screen/vendor_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class VendorProfileController extends GetxController{

  String tag = "ProfileController";
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
  bool isIdProofEmpty = false;
  bool isAddressProofEmpty = false;

  // List<String> countryList = <String>[];
  List<cityListResponse.Payload> cityList = <cityListResponse.Payload>[];
  List<countryListResponse.Payload> countryList = <countryListResponse.Payload>[];

  countryListResponse.Payload selectedCountry = countryListResponse.Payload();
  cityListResponse.Payload selectedCity = cityListResponse.Payload();


  XFile? imageFile;
  File? selectedIdProof;
  File? selectedAddressProof;

  final ProgressDialog _progressDialog = ProgressDialog(context: Get.context!);


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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
    isIdProofEmpty = false;
    isAddressProofEmpty = false;
  }


  ///*
  ///
  /// check validations for all required field
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

    }else if(idProofEditController.text.isEmpty){
      isZipCodeEmpty = false;
      isIdProofEmpty = true;
      isCityEmpty = false;
      isCountryEmpty = false;
      isAddress1Empty = false;
      isLocationEmpty = false;
      isMobileEmpty = false;
      isBusinessNameEmpty = false;
      isAboutMeEmpty = false;
      isNameEmpty = false;

    }else if(addressProofEditController.text.isEmpty){
      isZipCodeEmpty = false;
      isIdProofEmpty = false;
      isAddressProofEmpty = true;
      isCityEmpty = false;
      isCountryEmpty = false;
      isAddress1Empty = false;
      isLocationEmpty = false;
      isMobileEmpty = false;
      isBusinessNameEmpty = false;
      isAboutMeEmpty = false;
      isNameEmpty = false;

    }else if(imageFile == null){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            OKDialog(
              title: "",
              descriptions: "Please select Image",
              img: errorImage,
              text: '',
              key: null,
            ),
      );
    }else{
      hitSaveProfileApi();
    }
  }

  ///*
  ///
  /// save profile data by calling save_profile/ Api
  void hitSaveProfileApi() async {
    VendorSaveProfileRequest requestModel = VendorSaveProfileRequest();
    requestModel.email = MySharedPreference.getString(MyConstants.keyEmail);
    requestModel.fullName = nameEditController.text;
    requestModel.profileImage = imageFile!.path;
    requestModel.idProofFile = selectedIdProof!.path;
    requestModel.addressProofFile = selectedAddressProof!.path;
    requestModel.abountMe = aboutMeEditController.text;
    requestModel.businessName = businessNameEditController.text;
    requestModel.mobileNo = mobileEditController.text;
    requestModel.googleAddress = locationEditController.text;
    requestModel.googleAddressLat = latitude ;
    requestModel.googleAddressLng = longitude ;
    requestModel.addressLineOne = address1EditController.text;
    requestModel.addressLineTwo = address2EditController.text;
    requestModel.fkCountry = selectedCountryId;
    requestModel.fkCity = selectedCityID;
    requestModel.zipCode = int.parse(zipCodeEditController.text);


    final results = await Request().saveProfileFormDataRequest(
        url: vendorSaveProfileApi,
        requestModel: requestModel,
        context: Get.context!);

    try {
      if (results != null) {

        await results.stream.bytesToString().then((value) {
          VendorSaveProfileResponse responseModel = VendorSaveProfileResponse.fromJson(json.decode(value));
          if(responseModel.status == 200) {
            MySharedPreference.setBool(MyConstants.keyIsProfileCompleted, true);
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
  /// get country list by calling get_country/ Api
  void hitCountryListApi() async{
    final results = await Request().requestGet(
        url: countryListApi,
        context: Get.context);

    try{
      if(results != null){
        countryListResponse.CountryListResponse responseModel = countryListResponse.CountryListResponse.fromJson(results);
        print(tag + "hitGetOtpApi Response : " + responseModel.toString());
        if(responseModel.status == 200){
          if(responseModel.payload != null){
            countryList =  responseModel.payload!;
            if(countryList.isNotEmpty ){
              selectedCountry = countryList[0];
              selectedCountryId = selectedCountry.id!;
              hitCityListApi();
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
      print(tag + "hitGetOtpApi Exception " + exception.toString());
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
  /// get city list of country by calling get_city/ Api
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
          if(_progressDialog.isOpen()){
              _progressDialog.close();
            }
          if(responseModel.payload != null){
            cityList =  responseModel.payload!;
            if(cityList.isNotEmpty){
              selectedCity = cityList[0];
              selectedCityID = selectedCity.id!;
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
  navigateToHomeScreen() {
    Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (context) => VendorHomeScreen()), (route) => false);
  }

}