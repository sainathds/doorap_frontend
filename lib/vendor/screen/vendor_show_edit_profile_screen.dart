import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:door_ap/common/helperclass/ask_dialog.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_place_picker.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/controller/vendor_show_edit_profile_controller.dart';
import 'package:door_ap/vendor/model/response/vendor_view_profile_response.dart';
import 'package:door_ap/common/model/response/city_list_response.dart' as cityListResponse;
import 'package:door_ap/common/model/response/country_list_response.dart' as countryListResponse;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorShowEditProfileScreen extends StatefulWidget {

  Payload profileData;

  VendorShowEditProfileScreen({Key? key, required this.profileData}) : super(key: key);

  @override
  _VendorShowEditProfileScreenState createState() => _VendorShowEditProfileScreenState();
}

class _VendorShowEditProfileScreenState extends State<VendorShowEditProfileScreen> {

  VendorShowEditProfileController _getXController = Get.put(VendorShowEditProfileController());
  bool isLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    MySharedPreference.getInstance();
    _getXController.refreshPage = refreshPage;
    setProfileData(widget.profileData);
    PluginGooglePlacePicker.initialize(
        androidApiKey: MyString.googleApiKey,
        iosApiKey: MyString.googleApiKey
    );
    super.initState();

  }

  ///*
  ///
  ///
  refreshPage() {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 33.0),
        child: Column(
          children: [
            //title and back arrow
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image(image: backArrowIcon, height: 16.0, width: 18.0,)),

                Text(MyString.editProfile!,
                  style: const TextStyle(
                      fontSize: MyDimens.textSize20,
                      color: MyColor.themeBlue,
                      fontFamily: 'roboto_bold'
                  ),),

                const SizedBox(height: 16, width: 18,),

              ],),


            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(children: [

                  //Image
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0,),
                    child: Container(
                      height: 120,
                      width: 120,
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: !isLoad ? Image(image:  noProfileImg,
                            width: 110.0, height: 110.0, fit: BoxFit.fill,)

                              : _getXController.imageFile != null ? Image(
                            image: FileImage(
                                File(_getXController.imageFile!.path)),
                            width: 110.0, height: 110.0, fit: BoxFit.fill,)

                              :  Image.network(_getXController.serverImageUrl,
                            width: 110.0, height: 110.0, fit: BoxFit.fill,
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return Image(
                                  image: noImage, width: 110, height: 110, fit: BoxFit.fill);
                            },
                            ),

                        ),

                        Positioned(
                            right: 5,
                            bottom: 5,
                            child: InkWell(
                                onTap: (){
                                  showImageOptionDialog();
                                },
                                child: Image(image: cameraImage, height: 35.0, width: 35.0,)))
                      ],),
                    ),
                  ),


                  //full name
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: fullNameField(),
                  ),

                  //About me
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: aboutMeField(),
                  ),

                  //Business Name
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: businessNameField(),
                  ),

                  //Mobile no
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: mobileField(),
                  ),

                  //Location
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: locationField(),
                  ),

                  //Select map Location
                  /*Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: mapLocationField(),
                  ),
*/
                  Padding(
                    padding: EdgeInsets.only(top: 22.0),
                    child: Row(
                      children: [
                        Expanded(flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(right: 5.0),
                              height: 1.0, color: MyColor.lightBgGrey,)),

                        Text(MyString.postalAddress!, style: TextStyle(fontSize: MyDimens.textSize16, color: MyColor.themeBlue, fontFamily: 'montserrat_semiBold'),),

                        Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 5.0),
                              height: 1.0, color: MyColor.lightBgGrey,)),

                      ],
                    ),),

                  //address Line1
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: addressOneField(),
                  ),

                  //address Line2
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: addressTwoField(),
                  ),


                  _getXController.countryList.isNotEmpty?
                  //Select Country
                      Padding(
                        padding: const EdgeInsets.only(top:22.0),
                        child: countryDropdown(),): SizedBox(),


                  _getXController.cityList.isNotEmpty?
                      //Select City
                      Padding(
                        padding: const EdgeInsets.only(top:22.0),
                        child: cityDropdown(),)
                  :SizedBox(),


                  //ZIP code
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: zipCodeField(),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 22.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(right: 5.0),
                              height: 1.0,
                              color: MyColor.lightBgGrey,
                            )),
                        Text(
                          MyString.documents!,
                          style: TextStyle(fontSize: MyDimens.textSize16, color: MyColor.themeBlue, fontFamily: 'montserrat_semiBold'),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.only(left: 5.0),
                              height: 1.0,
                              color: MyColor.lightBgGrey,
                            )),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: idProofField(),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: addressProofField(),
                  ),

                  ///*
                  /// update button
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 22.0),
                    child: ElevatedButton(
                        onPressed: (){
                          _getXController.isDataValid();
                          refreshPage();
                        },
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),),
                            elevation: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(MyString.update!,
                            style: const TextStyle(
                                fontSize: MyDimens.textSize15,
                                color: Colors.white,
                                fontFamily: 'sf_pro_bold'
                            ),),
                        )),
                  ),

                  
                  ///*
                  /// update button
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 12.0),
                    child: ElevatedButton(
                        onPressed: (){
                          showDialog(
                              context: Get.context!,
                              builder: (BuildContext context1) => AskDialog(
                                  my_context: Get.context!,
                                  msg: "Do you want to delete your account ?",
                                  yesFunction: () {
                                    _getXController.hitDeleteAccountApi();
                                  },
                                  noFunction: (){Navigator.pop(context);}));
                          ;
                        },
                        style: ElevatedButton.styleFrom(primary:Colors.red.shade600,shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),),
                            elevation: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(MyString.delete!,
                            style: const TextStyle(
                                fontSize: MyDimens.textSize15,
                                color: Colors.white,
                                fontFamily: 'sf_pro_bold'
                            ),),
                        )),
                  ),

                ],),
              ),
            ),




          ],
        ),
      ),
    ));
  }

  ///*
  ///ID proof
  Widget idProofField() {
    return GestureDetector(
      onTap: () async {
        launchUrl(Uri.parse(_getXController.selectedIdProof!),mode: LaunchMode.externalApplication);
        
        // showDialog(
        //   context: context,
        //   useSafeArea: false,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       insetPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 50),
        //       content: Container(
        //         width: MediaQuery.of(context).size.width,
        //         child: WebViewX(
        //           width: MediaQuery.of(context).size.width,
        //           height: MediaQuery.of(context).size.height,
        //         ),
        //       ),
        //     );
        //   },
        // );
        
        // _getXController.setAllErrorToFalse();
        //
        // FilePickerResult? result = await FilePicker.platform.pickFiles(
        //   type: FileType.custom,
        //   allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc', 'docx'],
        // );
        //
        // if (result != null) {
        //   _getXController.selectedIdProof = File(result.files.single.path!);
        //   print(_getXController.selectedIdProof);
        //
        //   setState(() {
        //     _getXController.isIdProofEmpty = false;
        //     _getXController.idProofEditController.text = _getXController.selectedIdProof!.path.split("/").last;
        //   });
        // }
      },
      child: TextField(
        controller: _getXController.idProofEditController,
        enabled: false,
        style: fieldStyle(),
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          // disabledBorder: OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          // border: OutlineInputBorder(),
          labelText: MyString.idProof!.toUpperCase(),
          labelStyle: TextStyle(
              fontSize: MyDimens.textSize14,
              color: MyColor.labelGrey,
              fontFamily: 'sf_pro_semibold'
          ),
          hintText: MyString.selectIdProof,
          errorText: _getXController.isIdProofEmpty ? "Please Select Photo ID Proof" : null, 
          suffixIcon: Icon(Icons.remove_red_eye_outlined)
        ),
      ),
    );
  }

  
  ///*
  ///ID proof
  Widget addressProofField() {
    return GestureDetector(
      onTap: () async {
        print(_getXController.selectedAddressProof);
        launchUrl(Uri.parse(_getXController.selectedAddressProof!),mode: LaunchMode.externalApplication);
        // _getXController.setAllErrorToFalse();
        //
        // FilePickerResult? result = await FilePicker.platform.pickFiles(
        //   type: FileType.custom,
        //   allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc', 'docx'],
        // );
        //
        // if (result != null) {
        //   _getXController.selectedAddressProof = File(result.files.single.path!);
        //   print(_getXController.selectedAddressProof);
        //
        //   setState(() {
        //     _getXController.isAddressProofEmpty = false;
        //     _getXController.addressProofEditController.text = _getXController.selectedAddressProof!.path.split("/").last;
        //   });
        // }
      },
      child: TextField(
        controller: _getXController.addressProofEditController,
        enabled: false,
        style: fieldStyle(),
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          labelText: MyString.addressProof!.toUpperCase(),
          labelStyle: TextStyle(
              fontSize: MyDimens.textSize14,
              color: MyColor.labelGrey,
              fontFamily: 'sf_pro_semibold'
          ),
          hintText: MyString.selectAddressProof,
          errorText: _getXController.isAddressProofEmpty ? "Please Select Address Proof" : null,
          suffixIcon: Icon(Icons.remove_red_eye_outlined)
        ),
      ),
    );
  }
  
  
  
  
  ///*
  ///
  Widget fullNameField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllErrorToFalse();
        });
      },
      controller: _getXController.nameEditController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: _getXController.nameFocus,
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        // border: OutlineInputBorder(),
        labelText: MyString.fullName,
        labelStyle: labelStyle(),
        hintText: MyString.enterYourName,
        errorText: _getXController.isNameEmpty ? "Please Enter Name" : null ,
      ),

      onEditingComplete: (){
        _getXController.aboutMeFocus.requestFocus();
      },
    );
  }

  ///*
  /// about me field
  Widget aboutMeField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllErrorToFalse();
        });
      },
      controller: _getXController.aboutMeEditController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: _getXController.aboutMeFocus,
      style: fieldStyle(),
      maxLines: null,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        labelText: MyString.aboutMe,
        labelStyle: labelStyle(),
        hintText: MyString.enterAboutYourself,
        errorText: _getXController.isAboutMeEmpty ? "Please Enter about your self" : null ,
      ),
      onEditingComplete: (){
        _getXController.businessNameFocus.requestFocus();
      },
    );
  }


  ///*
  /// Business Name Field
  Widget businessNameField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllErrorToFalse();
        });
      },
      controller: _getXController.businessNameEditController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: _getXController.businessNameFocus,
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        labelText: MyString.businessName,
        labelStyle: labelStyle(),
        hintText: MyString.enterBusinessName,
        errorText: _getXController.isBusinessNameEmpty ? "Please Enter business name" : null ,
      ),
      onEditingComplete: (){
        _getXController.mobileFocus.requestFocus();
      },
    );
  }

  ///*
  /// Mobile no Field
  Widget mobileField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllErrorToFalse();
        });
      },
      controller: _getXController.mobileEditController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        LengthLimitingTextInputFormatter(10),

      ],
      textInputAction: TextInputAction.next,
      focusNode: _getXController.mobileFocus,
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        labelText: MyString.mobileNumber,
        labelStyle: labelStyle(),
        hintText: MyString.enterMobileNumber,
        errorText: _getXController.isMobileEmpty ? "Please Enter mobile no" : _getXController.isMobileValid ? "Please enter valid mobile no" : null ,
      ),
      onEditingComplete: (){
        _getXController.locationFocus.requestFocus();
      },
    );
  }


  ///*
  /// Location Field
  Widget locationField() {
    return TextFormField(
      readOnly: true,
      onTap: () {
        setState(() async{
          _getXController.setAllErrorToFalse();
          Place place = await MyPlacePicker.showPlacePicker();
          _getXController.locationEditController.text = place.address!;
          _getXController.latitude = place.latitude;
          _getXController.longitude = place.longitude;
          log("SelectedLocation Name: " + place.name!);
          log("SelectedLocation Address: " + place.address!);
          log("SelectedLocation Latitude: " + place.latitude.toString());
          log("SelectedLocation Longitude: " + place.longitude.toString());
        });
      },
      controller: _getXController.locationEditController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: _getXController.locationFocus,
      style: fieldStyle(),
      maxLines: null,
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        labelText: MyString.location,
        labelStyle: labelStyle(),
        hintText: MyString.selectYourLocation,
        errorText: _getXController.isLocationEmpty ? "Please Select location" : null ,
      ),
      onEditingComplete: (){
        _getXController.address1Focus.requestFocus();
      },
    );
  }

  ///*
  ///
  ///
  Widget mapLocationField() {
    return Row(
      children: [
        Image(image: locationIcon),
        SizedBox(width: 10.0,),
        Text(MyString.selectYourLocation!, style: TextStyle(fontSize: MyDimens.textSize13, color: MyColor.textThemeBlue, fontFamily: 'montserrat_medium' ),),
      ],
    );
  }

  ///*
  /// Address 1 Field
  Widget addressOneField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllErrorToFalse();
        });
      },
      controller: _getXController.address1EditController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: _getXController.address1Focus,
      style: fieldStyle(),
      maxLines: null,
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        labelText: MyString.addressLine1,
        labelStyle: labelStyle(),
        hintText: MyString.enterAddress,
        errorText: _getXController.isAddress1Empty ? "Please Enter Address" : null ,
      ),
      onEditingComplete: (){
        _getXController.address2Focus.requestFocus();
      },
    );
  }

  ///*
  /// Address 2 Field
  Widget addressTwoField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllErrorToFalse();
        });
      },
      controller: _getXController.address2EditController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      focusNode: _getXController.address2Focus,
      style: fieldStyle(),
      maxLines: null,
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        labelText: MyString.addressLine2,
        labelStyle: labelStyle(),
        hintText: MyString.enterAddress,
      ),
      onEditingComplete: (){
        // _getXController.sele.requestFocus();
      },
    );
  }


  ///*
  ///ZIP code field
  Widget zipCodeField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllErrorToFalse();
        });
      },
      controller: _getXController.zipCodeEditController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      textInputAction: TextInputAction.next,
      focusNode: _getXController.zipCodeFocus,
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        labelText: MyString.zipCode,
        labelStyle: labelStyle(),
        hintText: MyString.enterZipCode,
        errorText: _getXController.isZipCodeEmpty ? "Please Enter zip code" : null,
      ),

    );

  }


  ///*
  ///
  TextStyle fieldStyle(){
    return const TextStyle(
        fontSize: MyDimens.textSize14,
        color: MyColor.fieldGrey,
        fontFamily: 'sf_pro_regular'
    );
  }

  ///*
  ///
  TextStyle labelStyle(){
    return const TextStyle(
        fontSize: MyDimens.textSize10,
        color: MyColor.labelGrey,
        fontFamily: 'sf_pro_semibold'
    );
  }


  ///*
  ///
  ///
  void showImageOptionDialog() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    imageSelector(context, "gallery");
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.image, color: MyColor.themeBlue, size: 40.0,),
                      SizedBox(width: 5.0,),
                      Text('Gallery',style: TextStyle(fontSize: MyDimens.textSize16, color: MyColor.themeBlue, fontFamily: 'montserrat_semiBold')),
                    ],
                  ),
                ),


                InkWell(
                  onTap: (){
                    imageSelector(context, "camera");
                    Navigator.pop(context);
                  },
                  child: Row(
                    children:  [
                      Icon(Icons.add_a_photo, color: MyColor.themeBlue, size: 40.0,),
                      SizedBox(width: 5.0,),
                      Text('Camera', style: TextStyle(fontSize: MyDimens.textSize16, color: MyColor.themeBlue, fontFamily: 'montserrat_semiBold')),
                    ],
                  ),
                ),

                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.cancel, color: MyColor.themeBlue, size: 40.0,),
                      SizedBox(width: 5.0,),
                      Text('Cancel', style: TextStyle(fontSize: MyDimens.textSize16, color: MyColor.themeBlue, fontFamily: 'montserrat_semiBold')),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }


  Future imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":

      /// GALLERY IMAGE PICKER
        _getXController.imageFile = (await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 90))!;
        isLoad = true;
        refreshPage();
        break;

      case "camera": // CAMERA CAPTURE CODE
        _getXController.imageFile = (await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 90))!;
        isLoad = true;
        refreshPage();
        break;
    }

    if (_getXController.imageFile != null) {
      print("You selected  image : " + _getXController.imageFile!.path);
      setState(() {
        debugPrint("SELECTED IMAGE PICK   ${_getXController.imageFile}");
      });
    } else {
      print("You have not taken image");
    }
  }

  ///*
  ///
  ///
  Widget countryDropdown() {
    return DropdownSearch<countryListResponse.Payload?>(
      dropdownBuilder: _countryDropDownStyle,
      dropdownSearchDecoration: InputDecoration(
        labelText: "Country",
        labelStyle: labelStyle(),
        hintText: "Select country",
      contentPadding:
      const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0),
        ),
    items: _getXController.countryList,
    itemAsString: (countryListResponse.Payload? u) => u!.countryAsString(),
    selectedItem: _getXController.selectedCountry,
    popupTitle: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text("Select Country", style: TextStyle(
              fontSize: MyDimens.textSize16,
              color: MyColor.themeBlue,
              fontFamily: 'sf_pro_semibold'
          )),
        ),
      ],
    ),
    showSearchBox: true,
    searchFieldProps: const TextFieldProps(
      showCursor: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: MyColor.labelGrey,),
        hintText: "search for country",
        hintStyle: TextStyle(
            fontSize: MyDimens.textSize14,
            color: MyColor.labelGrey,
            fontFamily: 'sf_pro_semibold'
        ),
      ),
    ),
    dropdownSearchBaseStyle: labelStyle(),
    onChanged: (value) {
      log("SelectedCountry : " + value!.countryName!);
      _getXController.selectedCountry = value;
      _getXController.selectedCountryId = _getXController.selectedCountry.id!;
      _getXController.selectedCityID = 0;
      _getXController.hitCityListApi();
      },
  );
  }


  ///*
  ///
  ///
  Widget cityDropdown(){
    return DropdownSearch<cityListResponse.Payload?>(
      dropdownBuilder: _cityDropDownStyle,
      dropdownSearchDecoration: InputDecoration(
        labelText: "City",
        labelStyle: labelStyle(),
        hintText: "Select city",
        hintStyle: fieldStyle(),
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
      ),

      items: _getXController.cityList,
      itemAsString: (cityListResponse.Payload? u) => u!.cityAsString(),
      selectedItem: _getXController.selectedCity,
      popupTitle: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text("Select City", style: TextStyle(
                fontSize: MyDimens.textSize16,
                color: MyColor.themeBlue,
                fontFamily: 'sf_pro_semibold'
            )),
          ),
        ],
      ),
      showSearchBox: true,
      searchFieldProps:  TextFieldProps(
        showCursor: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: MyColor.labelGrey,),
          hintText: "search for city",
          hintStyle: TextStyle(
              fontSize: MyDimens.textSize14,
              color: MyColor.labelGrey,
              fontFamily: 'sf_pro_semibold'
          ),
        ),
      ),
      dropdownSearchBaseStyle: labelStyle(),
      onChanged: (value) {
        log("SelectedCity : " + value!.cityName!);
        _getXController.selectedCity = value;
        _getXController.selectedCityID = _getXController.selectedCity.id!;
        },
    );
  }


  ///*
  ///
  ///
  Widget _cityDropDownStyle(
      BuildContext context, cityListResponse.Payload? selectedData) {
    return Text(
        selectedData!.cityName!.toString(),
        style: fieldStyle()
    ); }


  ///*
  ///
  ///
  Widget _countryDropDownStyle(
      BuildContext context, countryListResponse.Payload? selectedData) {
    return Text(
        selectedData!.countryName!.toString(),
        style: fieldStyle()
    ); }


  ///*
  ///
  ///
  void setProfileData(Payload profileData){
    _getXController.nameEditController.text = profileData.fullName!;
    _getXController.aboutMeEditController.text = profileData.abountMe!;
    _getXController.businessNameEditController.text = profileData.businessName!;
    _getXController.mobileEditController.text = profileData.mobileNo!;
    _getXController.locationEditController.text = profileData.googleAddress!;
    _getXController.latitude = profileData.googleAddressLat!;
    _getXController.longitude = profileData.googleAddressLng!;
    _getXController.address1EditController.text = profileData.addressLineOne!;
    _getXController.address2EditController.text = profileData.addressLineTwo!;
    _getXController.selectedCountryId = profileData.fkCountry!;
    _getXController.selectedCityID = profileData.fkCity!;
    _getXController.zipCodeEditController.text = profileData.zipCode.toString();

    Future.delayed(Duration.zero, () async {
      _getXController.hitCountryListApi();
      _getXController.hitCityListApi();
    });

    if(profileData.profileImage != null && profileData.profileImage != ""){
      isLoad = true;
      _getXController.serverImageUrl = baseImageUrl + profileData.profileImage!;
    }
    
    if(profileData.photoIdProof != null && profileData.photoIdProof != ""){
      _getXController.selectedIdProof = baseImageUrl + profileData.photoIdProof!;
      // _getXController.idProofEditController.text = profileData.photoIdProof!.split("/").last;
    }
    if(profileData.addressProof != null && profileData.addressProof != ""){
      _getXController.selectedAddressProof = baseImageUrl + profileData.addressProof!;
      // _getXController.addressProofEditController.text = profileData.addressProof!.split("/").last;
    }
  }
}
