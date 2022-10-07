import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:door_ap/common/helperclass/ask_dialog.dart';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/helperclass/permission_dialog.dart';
import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/screen/chat_screen.dart';
import 'package:door_ap/customer/controller/customer_main_controller.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:location/location.dart' as loc;
import 'package:get/get.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'customer_account_screen.dart';
import 'customer_all_category_screen.dart';
import 'customer_favourite_vendors_screen.dart';
import 'customer_home_screen.dart';
import 'customer_my_order_screen.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'customer_order_details_screen.dart';



class CustomerBtmScreen extends StatefulWidget {
  const CustomerBtmScreen({Key? key}) : super(key: key);

  @override
  _CustomerBtmScreenState createState() => _CustomerBtmScreenState();
}

class _CustomerBtmScreenState extends State<CustomerBtmScreen> {
  CustomerMainController _getXController = Get.put(CustomerMainController());
  late ProgressDialog _progressDialog;
  CustomerAddressModel _customerAddressModel = CustomerAddressModel();

  int currentPageNumber = 0;
  List<Widget> pages = <Widget>[];

  late Widget currentPage;
  final PageStorageBucket bucket = PageStorageBucket();
  bool _showSecond = false;


  final _androidAppRetain = const MethodChannel("android_app_retain");
  late geo.LocationPermission permission;
  loc.Location location =  loc.Location();


  @override
  void initState() {

    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance ;
    _firebaseMessaging.getToken().then((token){
      log("CUSTOMER_FCM_TOKEN :" + token!);
    });

    _getXController.refreshPage = refreshPage;
    Future.delayed(Duration.zero, () async {
      _getXController.hitCurrentOrderApi();
    });

    Future.delayed(Duration.zero, () async {
      checkAndRequestPermissions();
    });

    super.initState();
  }

  ///*
  ///
  ///
  void refreshPage(){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: pages.isNotEmpty ? PageStorage(bucket: bucket, child: currentPage) : SizedBox(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,

          items: [
            BottomNavigationBarItem(
                // activeIcon: Icon(Icons.home, color: MyColor.themeBlue,),
                icon: Icon(Icons.home, color: currentPageNumber == 0 ?  MyColor.themeBlue : MyColor.fieldBorderGrey),
                label: ""),

            BottomNavigationBarItem(
                // activeIcon: Icon(Icons.category, color: MyColor.themeBlue,),
                icon: Icon(Icons.category, color: currentPageNumber == 1 ? MyColor.themeBlue : MyColor.fieldBorderGrey),
                label: ""),

            BottomNavigationBarItem(
                // activeIcon: Icon(Icons.reorder_sharp, color: MyColor.themeBlue,),
                icon: Icon(Icons.reorder_sharp, color: currentPageNumber == 2 ? MyColor.themeBlue : MyColor.fieldBorderGrey),
                label: ""),

            BottomNavigationBarItem(
                // activeIcon: Icon(Icons.favorite, color: MyColor.themeBlue,),
                icon: Icon(Icons.favorite, color: currentPageNumber == 3 ? MyColor.themeBlue : MyColor.fieldBorderGrey),
                label: ""),

            BottomNavigationBarItem(
                // activeIcon: Icon(Icons.person, color: MyColor.themeBlue,),
                icon: Icon(Icons.person, color: currentPageNumber == 4 ? MyColor.themeBlue : MyColor.fieldBorderGrey),
                label: ""),

          ],
          onTap: (int index){
            setState(() {
              currentPage = pages[index];
              currentPageNumber = index;
            });
            if(index == 0){
              Future.delayed(Duration.zero, () async {
                _getXController.hitCurrentOrderApi();
              });
            }
          },
        ),

        bottomSheet:
        _getXController.currentOrderList.isNotEmpty && _customerAddressModel.latitude != 0.0 && currentPageNumber == 0 ?  showCurrentOrder() : const SizedBox()
      ),
    );
  }




  ///*
  ///
  TextStyle labelStyle(){
    return const TextStyle(
        fontSize: MyDimens.textSize14,
        color: MyColor.textThemeBlue,
        fontFamily: 'sf_pro_semibold'
    );
  }



  ///*
  ///
  ///
  void setInitialLocation() async {
    _progressDialog = ProgressDialog(context: context);
    _progressDialog.show(
      msg: "Please wait...",
      max: 100,
      progressBgColor: Colors.yellow,
      backgroundColor: MyColor.themeBlue,
      msgColor: Colors.white,
      msgFontSize: MyDimens.textSize18,
      msqFontWeight: FontWeight.bold,);

    await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.best)
        .then((geo.Position position) {

      setState(() {
        _customerAddressModel.latitude = position.latitude;
        _customerAddressModel.longitude = position.longitude;

        log("Main latitude ---" + _customerAddressModel.latitude.toString());
        log("Main longitude ---" + _customerAddressModel.longitude.toString());
        log("Main Address ---" + position.toJson().toString());

        // _currentPosition = value,
        // latitude = _currentPosition.latitude;
        // longitude = _currentPosition.longitude;
        getAddress();


      });
    }).catchError((e) {
      print(e);
      _progressDialog.close();
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "Error",
          descriptions: e.toString(),
          img: errorImage,
          text: '',
          key: null,
        ),
      );

    });



  }






  ///*
  ///
  /// Enable geocoding api from google developer console
  void getAddress() async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=${MyString.googleApiKey}&language=en&latlng=${_customerAddressModel.latitude},${_customerAddressModel.longitude}';
    log("URL ADDR"  + url);

    if(_customerAddressModel.latitude != null && _customerAddressModel.longitude != null){
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];

        List<dynamic> addressComponents =
        data['results'][0]['address_components'];

        List<dynamic> countries = addressComponents
            .where((entry) => entry['types'].contains('country'))
            .toList()
            .map((entry) => entry['long_name'])
            .toList();
        List<dynamic> localities = addressComponents
            .where((entry) => entry['types'].contains('locality'))
            .toList()
            .map((entry) => entry['long_name'])
            .toList();
        List<dynamic> postalCode = addressComponents
            .where((entry) => entry['types'].contains('postal_code'))
            .toList()
            .map((entry) => entry['long_name'])
            .toList();

        _customerAddressModel.address = _formattedAddress;
        _customerAddressModel.countryName = countries[0];
        _customerAddressModel.city = localities[0];
        _customerAddressModel.zipCode = postalCode[0];


          log("Main Address : " + _customerAddressModel.address);
          log("Main Country : " + _customerAddressModel.countryName);
          log("Main City : " + _customerAddressModel.city);
          log("Main ZipCode : " + _customerAddressModel.zipCode);

          _progressDialog.close();
          pages.clear();
          currentPage = CustomerHomeScreen(customerAddressModel: _customerAddressModel);
          pages.add(CustomerHomeScreen(customerAddressModel: _customerAddressModel));
          pages.add( CustomerAllCategoryScreen(customerAddressModel: _customerAddressModel));
          pages.add(CustomerMyOrderScreen());
          pages.add(CustomerFavouriteScreen());
          pages.add(CustomerAccountScreen());
          setState(() {});
      }
    }
  }


  ///*
  ///
  /// show bottom sheet
  Widget showCurrentOrder(){
    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) => AnimatedContainer(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        child: AnimatedCrossFade(
            firstChild: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container(
                  //   margin: EdgeInsets.all(20),
                  //   width: MediaQuery.of(context).size.width * 0.5,
                  //   height: 3,
                  //   color: Colors.white,
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, bottom: 10.0, top: 10, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Current Order",
                             style: TextStyle(
                               fontSize: MyDimens.textSize16,
                               color: Colors.white,
                               fontFamily: 'montserrat_regular'
                             ),),

                        InkWell(
                          onTap: (){
                            setState(() => _showSecond = true);
                          },
                          child:
                          Icon(
                            Icons.keyboard_arrow_up_rounded, color: Colors.white, size: 30,
                          )
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),
            secondChild: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 3,
                    color: Colors.white,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Current Order Show",
                          style: TextStyle(
                              fontSize: MyDimens.textSize16,
                              color: Colors.white,
                              fontFamily: 'montserrat_regular'
                          ),),

                        InkWell(
                          onTap: (){
                            setState(() => _showSecond = false);
                          },
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 30,
                          )
                        ),
                      ],
                    ),
                  ),


                  Container(
                    height: 250,
                    child: Swiper(
                      containerHeight: 230,

                          loop: _getXController.currentOrderList.length > 1 ? true: false,

                      pagination:
                      _getXController.currentOrderList.length > 1 ?
                      const SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: FractionPaginationBuilder(
                            activeFontSize: MyDimens.textSize18,
                            color: MyColor.textGrey,
                            activeColor: Colors.white,
                            fontSize: MyDimens.textSize18),
                      ):null,
                      itemCount: _getXController.currentOrderList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return
                          InkWell(
                            onTap: (){
                              Get.to(() => CustomerOrderDetailsScreen(
                                orderPrimaryKey: _getXController.currentOrderList[index].id!,
                                orderUniqueId: _getXController.currentOrderList[index].orderId!,
                                callFrom: _getXController.currentOrderList[index].orderStatus! == 'Started' ? 'CurrentStartedOrder' : 'CurrentOtherOrder'));
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 35),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20.0))
                              ),
                              child: Column(
                                children: [

                                  //service name and status
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: _getXController.currentOrderList[index].service!.serviceName![0],
                                                    style: TextStyle(
                                                      fontSize: MyDimens.textSize14,
                                                      color: MyColor.themeBlue,
                                                      fontFamily: 'montserrat_medium',
                                                    ),
                                                ),

                                                _getXController.currentOrderList[index].service!.serviceName!.length > 1 ?
                                                TextSpan(
                                                    text: " +" + (_getXController.currentOrderList[index].service!.serviceName!.length - 1).toString(),
                                                    style: TextStyle(
                                                      fontSize: MyDimens.textSize14,
                                                      color: MyColor.themeBlue,
                                                      fontFamily: 'montserrat_medium',
                                                    )
                                                ): TextSpan()
                                              ],
                                            ),
                                          ),
                                        ),


                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                            color: MyColor.inactiveOtp,
                                          )  ,
                                          child: Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Text(_getXController.currentOrderList[index].orderStatus!,
                                              style: TextStyle(
                                                  fontSize: MyDimens.textSize13,
                                                  color: getColor(_getXController.currentOrderList[index].orderStatus!),
                                                  fontFamily: 'montserrat_regular'
                                              ),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //vendor data and total hour and amount
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    child: Row(
                                      children: [

                                        ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(50)),
                                            child: _getXController.currentOrderList[index].fkVendorProfileImage == "" ?
                                            Image(image:  noProfileImg,
                                              height: 50.0, width : 50.0, fit: BoxFit.fill,)
                                                :
                                            Image.network(baseImageUrl + _getXController.currentOrderList[index].fkVendorProfileImage!,
                                              height: 50.0, width : 50.0, fit: BoxFit.fill,
                                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                return Image(
                                                    image: noProfileImg, height: 50, width : 50.0, fit: BoxFit.fill);
                                              },)),

                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(_getXController.currentOrderList[index].fkVendorFullName!,
                                                   maxLines: 1,
                                                   style: TextStyle(
                                                      fontSize: MyDimens.textSize15,
                                                      color: MyColor.themeBlue,
                                                      fontFamily: 'montserrat_medium'
                                                  ),),

                                                RatingBar.builder(
                                                  initialRating: _getXController.currentOrderList[index].rating!,
                                                  ignoreGestures : true,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 15,
                                                  itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                                  itemBuilder: (context, _) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        Row(
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                      child:
                                                      // Icon(Icons.timelapse_rounded, size: 14, color: MyColor.orangeColor,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 3.0),
                                                        child: Image(image: totalTimeIc, width: 20, height: 20,),
                                                      )
                                                  ),
                                                  TextSpan(
                                                      text: _getXController.currentOrderList[index].duration.toString() + "hr",
                                                      style: TextStyle(
                                                          fontSize: MyDimens.textSize18,
                                                          color: MyColor.themeBlue,
                                                          fontFamily: 'montserrat_medium'
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),

                                            SizedBox(width: 10,),

                                            Text( '\$' + _getXController.currentOrderList[index].totalAmount.toString(),
                                              style: TextStyle(
                                                  fontSize: MyDimens.textSize18,
                                                  color: MyColor.themeBlue,
                                                  fontFamily: 'montserrat_medium'
                                              ),),

                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                  //vendor location data
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 3.0),
                                                  child: Image(image: locationIcon, color: MyColor.themeBlue, width: 15, height: 18,),
                                                ),

                                              ),
                                              TextSpan(
                                                  text: _getXController.currentOrderList[index].fkVendorFkCityCityName,
                                                  style: TextStyle(
                                                      fontSize: MyDimens.textSize14,
                                                      color: MyColor.themeBlue,
                                                      fontFamily: 'montserrat_medium'
                                                  )
                                              ),
                                            ],
                                          ),
                                        ),

                                        Row(
                                          children: [


                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 18.0),
                                                child: Text( _getXController.currentOrderList[index].fkVendorGoogleAddress!,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: MyDimens.textSize13,
                                                      color: MyColor.themeBlue,
                                                      fontFamily: 'montserrat_regular'
                                                  ),),
                                              ),
                                            ),

                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap:(){
                                                    redirectToMap(_getXController.currentOrderList[index].fkVendorGoogleAddressLat!,
                                                      _getXController.currentOrderList[index].fkVendorGoogleAddressLng!);
                                                    },
                                                    child: Image(image: locationDirectionIc, color: MyColor.themeBlue, width: 25, height: 25,)),

                                                SizedBox(width: 15,),

                                                _getXController.currentOrderList[index].orderStatus! == 'Accepted' ||
                                                    _getXController.currentOrderList[index].orderStatus! == 'Started'?
                                                InkWell(
                                                    onTap: (){
                                                      Get.to(() => ChatScreen(
                                                        receiverId: _getXController.currentOrderList[index].fkVendorFkUserId!,
                                                        receiverName: _getXController.currentOrderList[index].fkVendorFullName!,
                                                        callFrom: "",

                                                        ));
                                                      },
                                                    child: Image(image: messageIcon, color: MyColor.themeBlue, width: 25, height: 25)): SizedBox()
                                              ],
                                            )
                                          ],
                                        ),


                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                      },
                    ),
                  )

                ],
              ),
            ),
            crossFadeState: _showSecond
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 400)),
        duration: Duration(milliseconds: 400),
      ),
    );
  }


  ///*
  ///
  ///&travelmode=driving  //bind before dir_action  &dir_action=navigate
  void redirectToMap(double destiLatitude, double destiLongitude) async{
    String url ='https://www.google.com/maps/dir/?api=1&origin=${_customerAddressModel.latitude},${_customerAddressModel.longitude}&destination=$destiLatitude,$destiLongitude&travelmode=driving';
    if (await launchUrl(Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  /*void redirectToMap(double destiLatitude, double destiLongitude) async{
    String url ='https://www.google.com/maps/dir/?api=1&origin=${_customerAddressModel.latitude},${_customerAddressModel.longitude}&destination=$destiLatitude,$destiLongitude&travelmode=driving';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
*/

  ///*
  ///
  ///
  getColor(String status) {
    if(status == 'Pending'){
      return Colors.orange;

    }else if(status == 'Started'){
      return Colors.green;

    }else if(status == 'Rejected' || status == 'Cancelled'){
      return Colors.red;

    }else if(status == 'Accepted'){
      return MyColor.themeBlue;
    }
  }



  ///*
  ///
  ///
  Future<bool> _onWillPop() async{

    showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => AskDialog(
            my_context: Get.context!,
            msg: "Do you want to Exit ?",
            yesFunction: yesFunction,
            noFunction: noFunction));

    return false;
  }


  ///*
  ///
  ///
  Future<bool> yesFunction(){
    if (Platform.isAndroid) {
      if (Navigator.of(context).canPop()) {
        return Future.value(true);
      } else {
        _androidAppRetain.invokeMethod("sendToBackground");
        return Future.value(false);
      }
    } else {
      return Future.value(true);
    }

  }


  ///*
  ///
  ///
  void noFunction(){
    Navigator.pop(Get.context!);
  }


  ///*
  ///
  ///
  checkAndRequestPermissions() async{
    permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied ) {
      permission = await geo.Geolocator.requestPermission();

      if (permission == geo.LocationPermission.denied) {
        log('Location_Permission : LocationPermission.denied');
        showLocationPermssionDialog("denied");

      }else if(permission == geo.LocationPermission.deniedForever){
        log('Location_Permission : ' + permission.toString());
        showLocationPermssionDialog("deniedForever");

      }else if(permission == geo.LocationPermission.always || permission == geo.LocationPermission.whileInUse){
        log('Location_Permission : ' + permission.toString());
        checkLocationService();

      }
    }else{
      checkLocationService();
    }

  }

  ///*
  ///
  ///
  void showLocationPermssionDialog(String permission) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => PermissionDialog(
            my_context: Get.context!,
            msg: "To use this App, required location permission. \n please allow location permission",
            okFunction: permission == "deniedForever" ? checkLocationService : checkAndRequestPermissions,
            cancelFunction: noFunction));

  }


  ///*
  ///
  ///
  void checkLocationService() async{
    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        log("checkLocationService 1" + _serviceEnabled.toString() );
        showLocationServiceDialog();
      }else{
        log("checkLocationService 2" + _serviceEnabled.toString() );
        setInitialLocation();
      }
    }else{
      setInitialLocation();

    }

  }


  ///*
  ///
  ///
  void showLocationServiceDialog() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => PermissionDialog(
            my_context: Get.context!,
            msg: "To see near by vendor you have to turn On Lcation",
            okFunction: checkLocationService,
            cancelFunction: noFunction));

  }

}
