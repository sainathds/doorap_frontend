import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/controller/vendor_set_schedule_controller.dart';
import 'package:door_ap/vendor/model/other/week_days_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class VendorSetScheduleScreen extends StatefulWidget {
  const VendorSetScheduleScreen({Key? key}) : super(key: key);

  @override
  _VendorSetScheduleScreenState createState() => _VendorSetScheduleScreenState();
}

class _VendorSetScheduleScreenState extends State<VendorSetScheduleScreen> {

  VendorSetScheduleController _getXController = Get.put(VendorSetScheduleController());


  @override
  void initState() {
    // TODO: implement initState

    log("BOOLEAN STRING  : " + true.toString().capitalizeFirst!);

    MySharedPreference.getInstance();
    _getXController.refreshPage = refreshPage;
    Future.delayed(Duration.zero, () async {
      _getXController.hitGetScheduleApi();
      // setWeekDaysData();
    });
    super.initState();
  }

  ///*
  ///
  ///
/*
  void setWeekDaysData(){
    _getXController.weekDaysData.clear();

    WeekDaysData data1 = WeekDaysData();
    data1.weekName = "Mon";
    data1.isSelected = _getXController.isMonday;
    _getXController.weekDaysData.add(data1);

    WeekDaysData data2 = WeekDaysData();
    data2.weekName = "Tues";
    data2.isSelected = _getXController.isTuesday;
    _getXController.weekDaysData.add(data2);

    WeekDaysData data3 = WeekDaysData();
    data3.weekName = "Wed";
    data3.isSelected = _getXController.isWednesday;
    _getXController.weekDaysData.add(data3);

    WeekDaysData data4 = WeekDaysData();
    data4.weekName = "Thus";
    data4.isSelected = _getXController.isThursday;
    _getXController.weekDaysData.add(data4);

    WeekDaysData data5 = WeekDaysData();
    data5.weekName = "Fri";
    data5.isSelected = _getXController.isFriday;
    _getXController.weekDaysData.add(data5);

    WeekDaysData data6 = WeekDaysData();
    data6.weekName = "Sat";
    data6.isSelected = _getXController.isSaturday;
    _getXController.weekDaysData.add(data6);

    WeekDaysData data7 = WeekDaysData();
    data7.weekName = "Sun";
    data7.isSelected = _getXController.isSunday;
    _getXController.weekDaysData.add(data7);

    log("WEEKDAYS DATA : " + json.encode(_getXController.weekDaysData.toString()));
  }
*/

  ///*
  ///
  ///
  void refreshPage(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:  Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
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
                            Navigator.pop(context);
                          },
                          child: Image(image: backArrowIcon, height: 16.0, width: 18.0, color: Colors.white,)),

                      Text(MyString.setSchedule!,
                        style: const TextStyle(
                            fontSize: MyDimens.textSize20,
                            color: Colors.white,
                            fontFamily: 'roboto_medium'
                        ),),

                      const SizedBox(height: 16, width: 18,),
                    ],),
                ),


                Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
                        color: Colors.white,
                      ),

                      child: Stack(
                        children: [

                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0, left: 60.0, right: 60.0),
                              child: Image(image: scheduleImg, ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 38.0, left: 23.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(MyString.selectDays!,
                                    textAlign: TextAlign.left,
                                    style: titleStyle(),),
                                ],
                              ),
                            ),

                            _getXController.weekDaysData.isNotEmpty?
                            selectDaysContainer(): SizedBox(),

                            Padding(
                              padding: const EdgeInsets.only(top: 30.0, left: 23.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(MyString.selectDays!,
                                    textAlign: TextAlign.left,
                                    style: titleStyle(),),
                                ],
                              ),
                            ),

                            selectDateTimeContainer(),


                              saveButtonContainer()

                            ],),


                        ],
                      ),
                    )),


              ],
            ),
          ),
        ) );
  }


  ///*
  ///
  ///
  TextStyle titleStyle() {
    return const TextStyle(
      fontSize: MyDimens.textSize18,
      color: MyColor.themeBlue,
      fontFamily: 'montserrat_semiBold'
    );
  }

  ///*
  ///
  ///
  Widget selectDaysContainer() {
    return Container(
        margin: EdgeInsets.only(top: 20.0, left: 23.0),
        height: 44,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 5);
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: _getXController.weekDaysData.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return
                      InkWell(
                        onTap: (){
                          setState(() {
                            _getXController.weekDaysData[index].isSelected = !_getXController.weekDaysData[index].isSelected!;
                          });
                        },
                        /*child: Container(
                            // width: 44,
                            // height: 44,
                            padding: EdgeInsets.all(3),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColor.orangeColor,
                              ),
                              borderRadius: BorderRadius.circular(50),
                              color: _getXController.weekDaysData[index].isSelected!? MyColor.orangeColor : Colors.white,
                            ),
                            child: Text(_getXController.weekDaysData[index].weekName!,
                              style: TextStyle(
                                  color: _getXController.weekDaysData[index].isSelected!? Colors.white : MyColor.textGrey,
                                  fontSize: MyDimens.textSize12,
                                  fontFamily: 'montserrat_medium'
                              ),)),*/


                        child: Container(
                          width: 44,
                          height: 44,
                            padding: EdgeInsets.all(3),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColor.orangeColor,
                              ),
                              borderRadius: BorderRadius.circular(50),
                              color: _getXController.weekDaysData[index].isSelected!? MyColor.orangeColor : Colors.white,
                            ),
                            child: Text(_getXController.weekDaysData[index].weekName!,
                              style: TextStyle(
                                  color: _getXController.weekDaysData[index].isSelected!? Colors.white : MyColor.textGrey,
                                  fontSize: MyDimens.textSize12,
                                  fontFamily: 'montserrat_medium'
                              ),)),
                      );
                  }
              ),
            ),
          ],
        )

    );

  }

  ///*
  ///
  ///
  Widget selectDateTimeContainer() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 23.0, right: 10.0),
              child: TextFormField(
                textAlign: TextAlign.center,
                readOnly: true,
                controller: _getXController.fromTimeEditController,
                decoration: InputDecoration(
                  focusColor: Colors.red,
                  border: OutlineInputBorder(),
                  contentPadding:
                  EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 0.0),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 5.0,),
                    child: Icon(Icons.access_time, color: MyColor.orangeColor, size: 20,),
                  ),
                  prefixIconConstraints: BoxConstraints(maxWidth: 25),


                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 5.0,),
                    child: Icon(Icons.keyboard_arrow_down, color: MyColor.themeBlue, size: 20),
                  ),
                  suffixIconConstraints: BoxConstraints(maxWidth: 25),
                ),

                onTap: (){
                  selectTime(context, _getXController.fromTimeEditController );
                  },
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 23.0),
              child: TextFormField(
                textAlign: TextAlign.center,
                readOnly: true,
                controller: _getXController.toTimeEditController,
                decoration: const InputDecoration(
                  focusColor: Colors.red,
                  border: OutlineInputBorder(),
                  contentPadding:
                  EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 0.0),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 5.0,),
                    child: Icon(Icons.access_time, color: MyColor.orangeColor, size: 20,),
                  ),
                  prefixIconConstraints: BoxConstraints(maxWidth: 25),


                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 5.0,),
                    child: Icon(Icons.keyboard_arrow_down, color: MyColor.themeBlue, size: 20),
                  ),
                  suffixIconConstraints: BoxConstraints(maxWidth: 25),
                ),

                onTap: (){
                  selectTime(context, _getXController.toTimeEditController );
                },
              ),
            ),
          )

        ],
      ),
    );
  }

  ///*
  ///
  ///
  void selectTime(BuildContext context,  TextEditingController timeEditController) async {
    final TimeOfDay? result =
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );

    if (result != null) {
      setState(() {
        log("TIME :" + result.format(context));
        final hour = result.hour.toString().padLeft(2, "0");
        final min = result.minute.toString().padLeft(2, "0");
        timeEditController.text = hour +":"+ min;
        log("SCHEDULE TIME :" + hour +":"+ min );
      });
    }
  }

  ///*
  ///
  ///
  Widget saveButtonContainer() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 40.0, left: 23, right: 23),
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
            child: Text(MyString.save!,
              style: const TextStyle(
                  fontSize: MyDimens.textSize15,
                  color: Colors.white,
                  fontFamily: 'sf_pro_bold'
              ),),
          )),
    );

  }

}
