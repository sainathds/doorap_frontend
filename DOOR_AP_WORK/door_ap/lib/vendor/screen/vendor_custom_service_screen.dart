import 'dart:developer';
import 'dart:io';

import 'package:door_ap/common/helperclass/show_image_option_dialog.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/vendor/controller/vendor_custom_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VendorCustomServiceScreen extends StatefulWidget {
  int categoryId;

  VendorCustomServiceScreen({Key? key, required this.categoryId}) : super(key: key);

  @override
  _VendorCustomServiceScreenState createState() =>
      _VendorCustomServiceScreenState();
}

class _VendorCustomServiceScreenState extends State<VendorCustomServiceScreen> {
  VendorCustomServiceController _getXController =
      Get.put(VendorCustomServiceController());
  bool isLoad = false;


  @override
  void initState() {
    // TODO: implement initState
    _getXController.categoryId = widget.categoryId;
    _getXController.clearField();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
            color: MyColor.themeBlue,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 23.0, vertical: 21.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image(
                            image: backArrowIcon,
                            height: 16.0,
                            width: 18.0,
                            color: Colors.white,
                          )),
                      Text(
                        MyString.createService!,
                        style: const TextStyle(
                            fontSize: MyDimens.textSize20,
                            color: Colors.white,
                            fontFamily: 'roboto_medium'),
                      ),
                      const SizedBox(
                        height: 16,
                        width: 18,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            topLeft: Radius.circular(8.0)),
                        color: Colors.white,
                      ),
                      child:SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            //Image
                            Padding(
                              padding: EdgeInsets.only(top: 35.0),
                              child: imageWidget(),
                            ),

                            Padding(
                                padding: const EdgeInsets.only(top: 32.0, left: 23.0, right: 23.0),
                                child: serviceNameField()),

                            Padding(
                                padding: const EdgeInsets.only(top: 32.0, left: 23.0, right: 23.0),
                                child: facilityNameField()
                            ),

                            _getXController.facilityList.isNotEmpty?
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0, left: 23.0, right: 23.0),
                              child: ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _getXController.facilityList.length,
                                itemBuilder: (BuildContext context, int index){
                                  return facilityItem(index);
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(thickness: 1.2,);
                                },
                              ),
                            ): SizedBox(),

                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 30.0, bottom: 30, left: 23, right: 23),
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
                                    child: Text("Create Service",
                                      style: const TextStyle(
                                          fontSize: MyDimens.textSize15,
                                          color: Colors.white,
                                          fontFamily: 'sf_pro_bold'
                                      ),),
                                  )),
                            ),

                          ],
                        ),
                      ),

                    ),
                    )
              ],
            )),
      ),
    );
  }

  ///*
  ///
  ///
  Widget imageWidget() {
    return Container(
      height: 120,
      width: 120,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: !isLoad
                  ? Image(
                      image: noProfileImg,
                      width: 110.0,
                      height: 110.0,
                      fit: BoxFit.fill,
                    )
                  : Image(
                      image: FileImage(File(_getXController.imageFile!.path)),
                      width: 110.0,
                      height: 110.0,
                      fit: BoxFit.fill,
                    )),
          Positioned(
              right: 5,
              bottom: 5,
              child: InkWell(
                  onTap: () {
                    ShowImageOptionDialog(
                      context: context,
                      galleryFunction: galleryImageSelector,
                      cameraFunction: cameraImageSelector,
                    );
                  },
                  child: Image(
                    image: cameraImage,
                    height: 35.0,
                    width: 35.0,
                  ))),

        ],
      ),
    );
  }

  ///*
  ///
  ///
  serviceNameField() {
    return TextFormField(
      controller: _getXController.nameEditController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: fieldStyle(),
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          border: OutlineInputBorder(),
          labelText: MyString.serviceName!.toUpperCase(),
          labelStyle: labelStyle(),
          hintText: MyString.enterServiceName,
          errorText: _getXController.isNameEmpty? "Please enter service name" : null // obs
      ),
      onChanged: (value){
        setState(() {
          if(value.isNotEmpty){
            _getXController.errorFieldToFalse();
          }
        });
      }, // controller func
    );
  }

  ///*
  ///
  ///
  galleryImageSelector() async {
    _getXController.imageFile = (await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 90))!;
    isLoad = true;
    refreshPage();
  }

  ///*
  ///
  ///
  cameraImageSelector() async {
    _getXController.imageFile = (await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 90))!;
    isLoad = true;
    refreshPage();
  }

  ///*
  ///
  TextStyle labelStyle() {
    return const TextStyle(
        fontSize: MyDimens.textSize10,
        color: MyColor.labelGrey,
        fontFamily: 'sf_pro_semibold');
  }

  ///*
  ///
  TextStyle fieldStyle() {
    return const TextStyle(
        fontSize: MyDimens.textSize14,
        color: MyColor.fieldGrey,
        fontFamily: 'sf_pro_regular');
  }

  ///*
  ///
  ///
  void refreshPage() {
    setState(() {});
  }

  ///*
  ///
  ///
  facilityNameField() {
    return TextFormField(
      controller: _getXController.facilityEditController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: fieldStyle(),
      decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          border: OutlineInputBorder(),
          labelText: MyString.facility!.toUpperCase(),
          labelStyle: labelStyle(),
          hintText: MyString.enterFacility,
          errorText: _getXController.isFacilityEmpty? "Please enter facility" : null ,
          suffixIcon: InkWell(
            onTap: (){
              setState(() {
                if(_getXController.isUpdate){
                  _getXController.isUpdate = false;
                  if(_getXController.facilityEditController.text.trim().isNotEmpty){
                    _getXController.facilityList[_getXController.updateItemIndex] = _getXController.facilityEditController.text.trim();
                    _getXController.facilityEditController.clear();
                  }
                }else{
                  if(_getXController.facilityEditController.text.trim().isNotEmpty) {
                    _getXController.facilityList.insert(
                        0, _getXController.facilityEditController.text.trim());
                    _getXController.facilityEditController.clear();
                  }
                }
              });
            },
            child: Icon(_getXController.isUpdate ? Icons.check : Icons.add_circle, color: _getXController.isUpdate ? Colors.green: MyColor.orangeColor, size: 30,),
          )
      ),
      onChanged: (value){
        setState(() {
          if(value.isNotEmpty){
            _getXController.errorFieldToFalse();
          }
        });
      }, // con
    );
  }

  ///*
  ///
  ///
  Widget facilityItem(int index) {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(_getXController.facilityList[index]),
              )),

          InkWell(
            onTap: (){
              setState(() {
                _getXController.updateItemIndex = index;
                _getXController.isUpdate = true;
                _getXController.facilityEditController.text = _getXController.facilityList[index];
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.edit, color: MyColor.themeBlue,),
            ),
          ),

          InkWell(
              onTap: (){
                setState(() {
                  _getXController.facilityList.removeAt(index);
                });
              },
              child: Icon(Icons.delete_outline_outlined, color: Colors.redAccent,))

        ],
      )
    );
  }
}
