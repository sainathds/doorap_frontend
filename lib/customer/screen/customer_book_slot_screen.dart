import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/customer/controller/customer_book_slot_controller.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:door_ap/customer/model/response/customer_get_cart_item_response.dart';
import 'package:door_ap/customer/screen/customer_checkout_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';

class CustomerBookSlotScreen extends StatefulWidget {
  CustomerAddressModel customerAddressModel;
  int vendorId;
  int categoryId;
  List<CartData> cartData;
  Calculation calculation;


  CustomerBookSlotScreen(
      {Key? key,
      required this.customerAddressModel,
      required this.vendorId,
      required this.categoryId,
      required this.cartData,
      required this.calculation
      })
      : super(key: key);

  @override
  _CustomerBookSlotScreenState createState() => _CustomerBookSlotScreenState();
}

class _CustomerBookSlotScreenState extends State<CustomerBookSlotScreen>
    with TickerProviderStateMixin {
  int selectedTabIndex = 0;
  late TabController tabController;

  CustomerBookSlotController _getXController =
      Get.put(CustomerBookSlotController());

  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    _getXController.refreshPage = refreshPage;
    _getXController.vendorId = widget.vendorId;
    _getXController.categoryId = widget.categoryId;
    _getXController.data.clear();

    Future.delayed(Duration.zero, () async {
      _getXController.hitSlotAvailableApi();
    });
    super.initState();
  }

  ///*
  ///
  ///
  void refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColor.themeBlue,
    ));

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            headerWidget(),
            profileDataWidget(),

            _getXController.data.isNotEmpty?
            dateAndSlotWidget()
                : SizedBox()
          ],
        ),
      ),
    );
  }

  ///*
  ///
  ///
  Widget headerWidget() {
    return Container(
      width: double.infinity,
      color: MyColor.themeBlue,
      padding:
          const EdgeInsets.only(top: 15.0, left: 23.0, right: 23.0, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              Text(
                'Book Slot',
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
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  widget.customerAddressModel.address,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: MyDimens.textSize12,
                      color: Colors.white,
                      fontFamily: 'roboto_medium'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  //
  ///
  ///
  ///
  profileDataWidget() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: _getXController.profileImage == ""
                  ? Image(
                      image: noProfileImg,
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      baseImageUrl + _getXController.profileImage,
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.fill,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image(
                            image: noImage,
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.fill);
                      },
                    )),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getXController.vendorName,
                  style: TextStyle(
                      fontSize: MyDimens.textSize22,
                      color: Colors.black,
                      fontFamily: 'roboto_bold'),
                ),
                Text(
                  _getXController.categoryName,
                  style: TextStyle(
                      fontSize: MyDimens.textSize16,
                      color: MyColor.textGrey,
                      fontFamily: 'roboto_medium'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  ///*
  ///
  ///
  dateAndSlotWidget() {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            decoration:  BoxDecoration(
              image:  DecorationImage(
                image: scaleColorImage,
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Row(
              children: [

                InkWell(
                  onTap: () {
                  if(_getXController.currentDateIndex != 0) {
                    buttonCarouselController.previousPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.linear);
                  }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Icon(Icons.arrow_back_ios, color: _getXController.currentDateIndex != 0 ? MyColor.themeBlue: Colors.black12),
                  ),
                ),

                Expanded(
                  child: CarouselSlider.builder(
                    carouselController: buttonCarouselController,
                    itemCount: _getXController.data.length,
                    itemBuilder: (context, index, position) {
                      return Container(
                        alignment: Alignment.center,
                          child: Text(
                            getFormattedDate(_getXController.data[index].date!),
                            style: TextStyle(
                                color: MyColor.themeBlue,
                                fontSize: MyDimens.textSize18,
                                fontFamily: 'roboto_bold'),
                          ));
                    },
                    options: CarouselOptions(
                        height: 80.0,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _getXController.currentDateIndex = index;
                            _getXController.timeEditController.clear();
                            _getXController.isTimeInValid = false;
                          });
                        }),
                  ),
                ),

                InkWell(
                  onTap: () {
                    if(_getXController.currentDateIndex != _getXController.data.length - 1){
                      buttonCarouselController.nextPage(
                          duration: Duration(milliseconds: 200), curve: Curves.linear);
                    }
                    },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Icon(Icons.arrow_forward_ios, color: _getXController.currentDateIndex != _getXController.data.length - 1 ? MyColor.themeBlue : Colors.black12),
                  ),
                ),
              ],
            ),
          ),

          _getXController.data[_getXController.currentDateIndex].status!.isStatus!?
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                         _getXController.data[_getXController.currentDateIndex].slotDetails!.isNotEmpty?
                         Text(
                          'Vendor is available from ' +
                              getTime(_getXController.data[_getXController.currentDateIndex].status!.fromTime!.toString()) +
                              " To " + getTime(_getXController.data[_getXController.currentDateIndex].status!.toTime!.toString()),
                          style: TextStyle(
                              fontSize: MyDimens.textSize11,
                              color: MyColor.textGrey,
                              fontFamily: 'montserrat_semiBold')
                      ):SizedBox()
                    )
                  ],
                ),

                _getXController.data[_getXController.currentDateIndex].slotDetails!.isNotEmpty
                    ? Expanded(
                  child: LayoutGrid(
                    gridFit: GridFit.loose,
                    // set some flexible track sizes based on the crossAxisCount
                    columnSizes: [1.fr, 1.fr, 1.fr],
                    // set all the row sizes to auto (self-sizing height)
                    rowSizes: List<IntrinsicContentTrackSize>.generate(
                        (_getXController.data[_getXController.currentDateIndex].slotDetails!.length / 2).round(),
                            (int index) => auto),
                    columnGap: 5,
                    rowGap: 15,
                    children: [
                      for (var index = 0;
                      index < _getXController.data[_getXController.currentDateIndex].slotDetails!.length;
                      index++)
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.black12, width: 1.5),
                                borderRadius: BorderRadius.circular(6.0)),
                            child: Column(
                              children: [
                                Text(
                                  _getXController.data[_getXController.currentDateIndex].slotDetails![index].fromTime!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: MyDimens.textSize17,
                                      color: MyColor.textGrey,
                                      fontFamily: 'montserrat_semiBold'),
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  _getXController.data[_getXController.currentDateIndex].slotDetails![index].toTime!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: MyDimens.textSize11,
                                      color: MyColor.textGrey,
                                      fontFamily: 'montserrat_semiBold'),
                                ),
                                SizedBox(
                                  height: 7.0,
                                ),
                                Text(
                                  'Not Available',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: MyDimens.textSize12,
                                      color: MyColor.orangeColor,
                                      fontFamily: 'montserrat_semiBold'),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                )
                    : Expanded(child: Center(child: Text(
                    'Vendor is available from ' +
                        getTime(_getXController.data[_getXController.currentDateIndex].status!.fromTime!.toString()) +
                        " To " + getTime(_getXController.data[_getXController.currentDateIndex].status!.toTime!.toString()),
                    style: TextStyle(
                        fontSize: MyDimens.textSize12,
                        color: MyColor.textGrey,
                        fontFamily: 'montserrat_semiBold')
                ))),


                Container(
                  // height: 80.0,
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 7,
                        blurRadius: 2,
                        offset: Offset(0, 7), // changes position of shadow
                      ),
                    ],
                  ),

                  child: Column(
                    children: [

                      Container(
                        margin: EdgeInsets.only(bottom: 15.0),
                        child: TextFormField(
                          readOnly: true,
                          controller: _getXController.timeEditController,
                          decoration: InputDecoration(
                            hintText: 'Enter time',
                            errorText: _getXController.isTimeEmpty? 'please enter time' :  _getXController.isTimeInValid ? 'vendor not available' : null,
                            focusColor: Colors.red,
                            border: OutlineInputBorder(),
                            contentPadding:
                            const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10.0),
                            prefixIcon:
                            Icon(Icons.access_time, color: MyColor.orangeColor,),

                            suffixIcon:
                            Icon(Icons.keyboard_arrow_down, color: MyColor.themeBlue,),
                          ),

                          onTap: (){
                            setState(() {
                              _getXController.isTimeEmpty = false;
                              _getXController.isTimeInValid = false;
                            });
                            selectTime(context, _getXController.timeEditController );
                          },
                        ),
                      ),


                      Row(
                        mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  '\$' + widget.calculation.totalAmount!.toStringAsFixed(2),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: MyDimens.textSize15,
                                      color: MyColor.themeBlue,
                                      fontFamily: 'montserrat_semiBold'),
                                ),

                                Text(
                                  'Duration ' + widget.calculation.averageTime.toString() + ' Hrs',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: MyDimens.textSize15,
                                      color: MyColor.textGrey,
                                      fontFamily: 'montserrat_semiBold'),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Container(
                              height: 45,
                              // margin: const EdgeInsets.only(top: 22.0, left: 23.0, right: 23.0, bottom: 30.0),
                              child: ElevatedButton(
                                  onPressed: (){
                                    if(_getXController.timeEditController.text.trim().isEmpty){
                                      _getXController.isTimeEmpty = true;
                                      refreshPage();

                                    }else if(!_getXController.isTimeInValid){
                                      _getXController.isTimeEmpty = false;
                                      Get.to(() => CustomerCheckoutScreen(
                                          customerAddressModel: widget.customerAddressModel,
                                        vendorId: widget.vendorId,
                                        categoryId: widget.categoryId,
                                        cartData: widget.cartData,
                                        bookDate: _getXController.data[_getXController.currentDateIndex].date!,
                                        bookTime: _getXController.timeEditController.text,
                                        vendorName: _getXController.vendorName,
                                        categoryName: _getXController.categoryName,
                                        calculation: widget.calculation
                                      ));
                                    }

                                  },
                                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),),
                                      elevation: 5),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                                    child: Text("Checkout",
                                      style: const TextStyle(
                                          fontSize: MyDimens.textSize15,
                                          color: Colors.white,
                                          fontFamily: 'sf_pro_bold'
                                      ),),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )

              ],
            ),
          )

          : Expanded(child: Center(child: Text('Vendor is not available'))),



        ],
      ),
    );
  }


  ///*
  ///
  ///
  void selectTime(BuildContext context,  TextEditingController timeEditController) async{

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

        log("TIME :" + hour +":"+ min );

        // DateTime ftime = DateFormat("HH:mm").parse(result.format(context));
        // timeEditController.text = DateFormat.Hm().format(ftime);
       });
    }

    compareTime();
  }

  ///*
  ///
  ///
  void compareTime() {
    DateTime nowDate = DateTime.now();
    String nowDateString = nowDate.year.toString() + '-' + nowDate.month.toString().padLeft(2, "0") + '-' + nowDate.day.toString().padLeft(2, "0");
    String nowTimeString = nowDate.hour.toString().padLeft(2, "0") + ":" + nowDate.minute.toString().padLeft(2, "0");
    DateTime nowDateTime = DateTime.parse(nowDateString + ' ' + nowTimeString);


    DateTime time = DateTime.parse(_getXController.data[_getXController.currentDateIndex].date! + " " +_getXController.timeEditController.text.trim());//selected time

    DateTime fromTime = DateTime.parse(_getXController.data[_getXController.currentDateIndex].date! + " " + _getXController.data[_getXController.currentDateIndex].status!.fromTime!); //10am
    DateTime toTime = DateTime.parse(_getXController.data[_getXController.currentDateIndex].date! + " " + _getXController.data[_getXController.currentDateIndex].status!.toTime!); //10am


    if(nowDateString == _getXController.data[_getXController.currentDateIndex].date!){
      if(time.isBefore(nowDateTime)){
        log('Availability : false' );
        _getXController.isTimeInValid = true;
        refreshPage();

      }else if(time == fromTime || (time.isAfter(fromTime) && time.isBefore(toTime))){
        for(int index = 0 ; index < _getXController.data[_getXController.currentDateIndex].slotDetails!.length; index++){
          DateTime slotFromTime = DateTime.parse(_getXController.data[_getXController.currentDateIndex].date! + " " + _getXController.data[_getXController.currentDateIndex].slotDetails![index].fromTime!);  // 2pm
          DateTime slotToTime = DateTime.parse(_getXController.data[_getXController.currentDateIndex].date! + " " + _getXController.data[_getXController.currentDateIndex].slotDetails![index].toTime!);  // 4pm

          if(time.isBefore(slotFromTime) || time.isAfter(slotToTime)){
            log('Availability : time.isBefore(slotFromTime) ' + time.isBefore(slotFromTime).toString() );
            log('Availability : time.isAfter(slotToTime) ' + time.isAfter(slotToTime).toString());
            _getXController.isTimeInValid = false;
            refreshPage();

          }else{
            log('Availability : false' );
            _getXController.isTimeInValid = true;
            refreshPage();
            break;

          }
        }
      }else{
      _getXController.isTimeInValid = true;
      log('Availability : out of schedule' );
    }

    }else if(time == fromTime || (time.isAfter(fromTime) && time.isBefore(toTime))){
      for(int index = 0 ; index < _getXController.data[_getXController.currentDateIndex].slotDetails!.length; index++){
        DateTime slotFromTime = DateTime.parse(_getXController.data[_getXController.currentDateIndex].date! + " " + _getXController.data[_getXController.currentDateIndex].slotDetails![index].fromTime!);  // 2pm
        DateTime slotToTime = DateTime.parse(_getXController.data[_getXController.currentDateIndex].date! + " " + _getXController.data[_getXController.currentDateIndex].slotDetails![index].toTime!);  // 4pm

        if(time.isBefore(slotFromTime) || time.isAfter(slotToTime)){
          log('Availability : time.isBefore(slotFromTime) ' + time.isBefore(slotFromTime).toString() );
          log('Availability : time.isAfter(slotToTime) ' + time.isAfter(slotToTime).toString());
          _getXController.isTimeInValid = false;
          refreshPage();

        }else{
          log('Availability : false' );
          _getXController.isTimeInValid = true;
          refreshPage();
          break;

        }
      }
    }else{
      _getXController.isTimeInValid = true;
      log('Availability : out of schedule' );
    }




  }

  ///*
  ///
  ///
  String getFormattedDate(String date) {
    String weekday = DateFormat("EEEE, MMM dd").format(DateTime.parse(date.toString()));
    return weekday;
  }

  ///*
  ///
  ///
  String getTime(String time) {
    // String timeFormatted = DateFormat("HH:mm a").format(DateTime.parse(_getXController.data[_getXController.currentDateIndex].date! + " " + time.toString()));

    String timeFormatted = DateFormat("HH:mm").format(DateTime.parse(_getXController.data[_getXController.currentDateIndex].date! + " " + time.toString()));
    return timeFormatted;

  }

}
