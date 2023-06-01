import 'dart:developer';

import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/vendor/controller/vendor_edit_service_controller.dart';
import 'package:door_ap/vendor/model/response/vendor_show_services_response.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VendorEditServiceScreen extends StatefulWidget {
  VenderService vendorServiceData;

  VendorEditServiceScreen({Key? key, required this.vendorServiceData}) : super(key: key);

  @override
  _VendorEditServiceScreenState createState() => _VendorEditServiceScreenState();
}

class _VendorEditServiceScreenState extends State<VendorEditServiceScreen> {

  VendorEditServiceController _getXController =  Get.put(VendorEditServiceController());

  @override
  void initState() {
    // TODO: implement initState
    _getXController.updateDataId = widget.vendorServiceData.id.toString();
    _getXController.categoryId = widget.vendorServiceData.fkCategory!.toString();
    _getXController.serviceId = widget.vendorServiceData.fkService.toString();
    _getXController.selectedDuration = widget.vendorServiceData.hour!;
    _getXController.costEditController.text = widget.vendorServiceData.price.toString();

    _getXController.refreshPage = refreshPage;
    Future.delayed(Duration.zero, () async {
      _getXController.hitFacilityListApi();
    });

    _getXController.durationList.add('1 hour');
    _getXController.durationList.add('2 hour');
    _getXController.durationList.add('3 hour');
    _getXController.durationList.add('4 hour');

    super.initState();
  }

  ///*
  ///
  ///
  void refreshPage(){
    setState(() {});
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
                padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 21.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Image(image: backArrowIcon, height: 16.0, width: 18.0, color: Colors.white,)),

                    Text("Edit Service",
                      style: const TextStyle(
                          fontSize: MyDimens.textSize20,
                          color: Colors.white,
                          fontFamily: 'roboto_medium'
                      ),),

                    Image(image: editServiceIcon, width: 20.0, height: 20.0,),

                  ],),
              ),

              Expanded(
                flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
                      color: Colors.white,
                    ),

                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                                child:
                                                widget.vendorServiceData.fkServiceServiceImage != null && widget.vendorServiceData.fkServiceServiceImage != "" ?
                                                Image(
                                                  image: NetworkImage(baseImageUrl + widget.vendorServiceData.fkServiceServiceImage!),
                                                  width: 100, height: 100,)
                                                    :
                                                Image(
                                                  image: noImage,
                                                  width: 70, height: 80,),
                                              ),
                                            ],
                                          ),
                                        )),

                                    Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Row(children: [
                                              Expanded(
                                                flex:1,
                                                child: Text(widget.vendorServiceData.fkServiceServiceName! ,
                                                  style: const TextStyle(
                                                      fontSize: MyDimens.textSize16,
                                                      color: MyColor.themeBlue,
                                                      fontFamily: 'roboto_medium'
                                                  ),),
                                              ),
                                            ],),

                                            SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text("(" + widget.vendorServiceData.fkCategoryCategoryName! + ")",
                                                    style: const TextStyle(
                                                        fontSize: MyDimens.textSize14,
                                                        color: MyColor.selectedOtp,
                                                        fontFamily: 'roboto_medium'
                                                    ),),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 20,),
                                            // Text(MyString.addCost!, style: labelStyle(),),
                                            addCostField(),

                                          ],))
                                  ],
                                ),


                                SizedBox(height: 20.0,),
                                Text(MyString.addTimeDuration!, style: labelStyle(),),
                                SizedBox(height: 10.0,),
                                timeDurationDropdown(),

                                SizedBox(height: 20.0,),
                                Text(MyString.selectServices!,
                                  style: labelStyle(),),


                                _getXController.facilityList != null && _getXController.facilityList!.isNotEmpty?
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _getXController.facilityList!.length,
                                    itemBuilder: (BuildContext context, int index){
                                      return facilityListWidget(context, index);
                                    })
                                    : SizedBox(),

                              ],),
                            ),
                          ),


                          ///*
                          /// Submit button
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


                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),

    );
  }

  ///*
  ///
  ///
  Widget facilityListWidget(BuildContext context, int index) {

    return Padding(
      padding: const EdgeInsets.only(top: 13.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          InkWell(
            onTap: (){
              setState(() {
                _getXController.facilityList![index].isSelected = !_getXController.facilityList![index].isSelected!;
                if(_getXController.facilityList![index].isSelected!){
                  _getXController.selectedFacilityListId.add(_getXController.facilityList![index].id!);
                  log("selected_facility_list added :" + _getXController.selectedFacilityListId.toString());

                }else{
                  for(int position = 0; position < _getXController.selectedFacilityListId.length;  position++ ){
                    if(_getXController.selectedFacilityListId[position] == _getXController.facilityList![index].id){
                      _getXController.selectedFacilityListId.removeAt(position);
                      log("selected_facility_list removed :" + _getXController.selectedFacilityListId.toString());
                    }
                  }
                }
              });
            },
            child: Icon(_getXController.facilityList![index].isSelected!?
            Icons.check_circle_rounded
                :Icons.radio_button_unchecked_outlined,

                color: _getXController.facilityList![index].isSelected!?
                MyColor.themeBlue: MyColor.selectedOtp

            ),
          ),

          SizedBox(width: 5.0,),

          Expanded(
              flex:1,
              child: Text(_getXController.facilityList![index].facilityName!,
                style: TextStyle(
                    color: MyColor.themeBlue,
                    fontSize: MyDimens.textSize13,
                    fontFamily: 'montserrat_regular'
                ),)),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  TextStyle labelStyle(){
    return TextStyle(
        color: MyColor.themeBlue,
        fontSize: MyDimens.textSize12,
        fontFamily: 'montserrat_semiBold'
    );
  }

  ///*
  ///
  TextStyle fieldStyle(){
    return const TextStyle(
        fontSize: MyDimens.textSize14,
        color: MyColor.textGrey,
        fontFamily: 'montserrat_regular'
    );
  }

  ///*
  ///
  ///
  Widget addCostField() {
    return TextFormField(
      onTap: () {
        setState(() {
          _getXController.setAllErrorToFalse();
        });
      },
      controller: _getXController.costEditController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      textInputAction: TextInputAction.next,
      focusNode: _getXController.costFocus,
      style: fieldStyle(),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
          contentPadding: EdgeInsets.zero,
          hintText: 'enter cost',
          label: Text(MyString.addCost!, style: fieldStyle(),),

        errorText: _getXController.isCostEmpty ? "Please enter cost" : null,
          prefixIcon: Icon(Icons.money, color: MyColor.orangeColor,),



      ),

    );
  }

  ///*
  ///
  ///
  Widget timeDurationDropdown(){
    return DropdownSearch<String>(
      dropdownBuilder: _cityDropDownStyle,
      mode: Mode.MENU,
      dropdownSearchDecoration: InputDecoration(
        prefixIcon: Icon(Icons.access_time_rounded, color: MyColor.orangeColor,),
        border: OutlineInputBorder(),
        labelText: "Select duration",
        labelStyle: fieldStyle(),
        hintText: "Select duration",
        hintStyle: fieldStyle(),
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 5.0),
        errorText: _getXController.isDurationEmpty ? "Please select duration" : null,
      ),

      items: _getXController.durationList,
      selectedItem: _getXController.selectedDuration,
      showSearchBox: false,
      dropdownSearchBaseStyle: labelStyle(),
      onChanged: (value) {
        log("SelectedDuration : " + value!);
        _getXController.selectedDuration = value;
      },
    );
  }

  ///*
  ///
  ///
  Widget _cityDropDownStyle(
      BuildContext context, String? selectedData) {
    return Text(
        selectedData!,
        style: fieldStyle()
    );
  }


}
