import 'dart:developer';
import 'dart:io';

import 'package:door_ap/common/helperclass/ask_dialog.dart';
import 'package:door_ap/common/helperclass/ok_dialog.dart';
import 'package:door_ap/common/helperclass/permission_dialog.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/screen/chat_screen.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/vendor/controller/vendor_home_controller.dart';
import 'package:door_ap/vendor/screen/vendor_accepted_order_screen.dart';
import 'package:door_ap/vendor/screen/vendor_categories_screen.dart';
import 'package:door_ap/common/screen/notification_list_screen.dart';
import 'package:door_ap/vendor/screen/vendor_pending_order_screen.dart';
import 'package:door_ap/vendor/screen/vendor_side_nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:location/location.dart' as loc;

import 'package:get/get.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({Key? key}) : super(key: key);

  @override
  _VendorHomeScreenState createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen>{
  final VendorHomeController _getXController = Get.put(VendorHomeController());
  bool _showSecond = false;
  late ProgressDialog _progressDialog;
  final _androidAppRetain = const MethodChannel("android_app_retain");
  late geo.LocationPermission permission;
  loc.Location location =  loc.Location();


  @override
  void initState() {
    // TODO: implement initState
    MySharedPreference.getInstance();  //get SharedPreference instance
    _getXController.payload = null;
    _getXController.refreshPage = refreshPage;
    Future.delayed(Duration.zero, () async {
      _getXController.hitNotificationCountApi(); //get unread notification count
    });

    Future.delayed(Duration.zero, () async {
      _getXController.hitCurrentOrderApi(); //get current order
    });

    Future.delayed(Duration.zero, () async {
      checkAndRequestPermissions(); //check and request for location permission
    });

    super.initState();
  }



  ///*
  ///
  void refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          endDrawer: VendorSideNavDrawer(profileData: _getXController.payload, getXController: _getXController),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
              titleSpacing: 0,
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image(
                            image: homeLocIcon,
                            height: 25.0,
                            width: 25.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getXController.cityName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MyDimens.textSize13,
                                    fontFamily: "montserrat_medium",
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    _getXController.fullAddress,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: MyDimens.textSize12,
                                      fontFamily: "montserrat_regular",
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                    notificationCountWidget()

                  ],
                ),
              ),
              elevation: 0,
              backgroundColor: MyColor.themeBlue,
            ),
          ),
          bottomSheet: _getXController.isServiceCreated! && _getXController.currentOrderList.isNotEmpty &&
                  _getXController.latitude != 0.0
              ? showCurrentOrder()
              : SizedBox(),
          body: Container(
            height: MediaQuery.of(context).size.height,
            color: MyColor.themeBlue,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  _getXController.payload == null
                      ? const SizedBox()
                      :_getXController.isApproved! == "false"
                      ? notApprovedContainer()
                      : !_getXController.isServiceCreated!
                      ?  createServiceContainer()
                      : Expanded(child: customTabWidget())

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///*
  ///
  ///
  Widget notApprovedContainer() {
    return Center(
      child: Column(
        children: [
          Image(
            image: underApprovalImg,
            width: 150.0,
            height: 150.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "Your account is under approval",
            style: TextStyle(
                fontSize: 15.0,
                color: MyColor.themeBlue,
                fontFamily: 'montserrat_semiBold'),
          ),
          Text(
            "Please contact Admin",
            style: TextStyle(
                fontSize: 15.0,
                color: MyColor.themeBlue,
                fontFamily: 'montserrat_semiBold'),
          ),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  Widget customTabWidget() {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
              /*shape: Border(
                  bottom: BorderSide(
                      color: Colors.black26,
                      width: 0.2
                  )),*/
              backgroundColor: Colors.transparent,
              elevation: 0,
              bottom: TabBar(
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                indicatorPadding: EdgeInsets.zero,
                unselectedLabelColor: MyColor.black50,
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(
                    text: "Pending",
                  ),
                  Tab(
                    text: "Accepted",
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            // controller: _tabController,
            children: [
              VendorPendingOrderScreen(
                  vendorLatitude: _getXController.latitude,
                  vendorLongitude: _getXController.longitude,),
              VendorAcceptedOrderScreen(
                  vendorLatitude: _getXController.latitude,
                  vendorLongitude: _getXController.longitude,
                  vendorHomeController: _getXController),
            ],
          ),
        ));
  }

  ///*
  ///
  /// show bottom sheet
  Widget showCurrentOrder() {
    int index = 0;

    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) => AnimatedContainer(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        child: AnimatedCrossFade(
            firstChild: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, top: 10.0, bottom:10, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Running Job",
                          style: TextStyle(
                              fontSize: MyDimens.textSize16,
                              color: Colors.white,
                              fontFamily: 'montserrat_regular'),
                        ),
                        InkWell(
                            onTap: () {
                              setState(() => _showSecond = true);
                            },
                            child: Icon(
                              Icons.keyboard_arrow_up_rounded,
                              color: Colors.white,
                              size: 30,
                            )),
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
                        Text(
                          "Running Job",
                          style: TextStyle(
                              fontSize: MyDimens.textSize16,
                              color: Colors.white,
                              fontFamily: 'montserrat_regular'),
                        ),
                        InkWell(
                            onTap: () {
                              setState(() => _showSecond = false);
                            },
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Get.to(() => CustomerOrderDetailsScreen(orderPrimaryKey: _getXController.currentOrderList[index].id!, orderUniqueId: _getXController.currentOrderList[index].orderId!,));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 35),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Column(
                        children: [
                          //service name and status
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: _getXController
                                              .currentOrderList[index]
                                              .service!
                                              .serviceName![0],
                                          style: TextStyle(
                                            fontSize: MyDimens.textSize14,
                                            color: MyColor.themeBlue,
                                            fontFamily: 'montserrat_medium',
                                          ),
                                        ),
                                        _getXController
                                                    .currentOrderList[index]
                                                    .service!
                                                    .serviceName!
                                                    .length >
                                                1
                                            ? TextSpan(
                                                text: " +" +
                                                    (_getXController
                                                                .currentOrderList[
                                                                    index]
                                                                .service!
                                                                .serviceName!
                                                                .length -
                                                            1)
                                                        .toString(),
                                                style: TextStyle(
                                                  fontSize: MyDimens.textSize14,
                                                  color: MyColor.themeBlue,
                                                  fontFamily:
                                                      'montserrat_medium',
                                                ))
                                            : TextSpan()
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    color: MyColor.inactiveOtp,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Text(
                                      _getXController
                                          .currentOrderList[index].orderStatus!,
                                      style: TextStyle(
                                          fontSize: MyDimens.textSize13,
                                          color: MyColor.greenColor,
                                          fontFamily: 'montserrat_regular'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //vendor data and total hour and amount
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _getXController
                                              .currentOrderList[index]
                                              .fkCustomerName!,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: MyDimens.textSize15,
                                              color: MyColor.themeBlue,
                                              fontFamily: 'montserrat_medium'),
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
                                            padding: const EdgeInsets.only(
                                                right: 3.0),
                                            child: Image(
                                              image: totalTimeIc,
                                              width: 20,
                                              height: 20,
                                            ),
                                          )),
                                          TextSpan(
                                              text: _getXController
                                                      .currentOrderList[index]
                                                      .duration
                                                      .toString() +
                                                  "hr",
                                              style: TextStyle(
                                                  fontSize: MyDimens.textSize18,
                                                  color: MyColor.themeBlue,
                                                  fontFamily:
                                                      'montserrat_medium')),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '\$' +
                                          _getXController
                                              .currentOrderList[index]
                                              .vendorPayAmount
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: MyDimens.textSize18,
                                          color: MyColor.themeBlue,
                                          fontFamily: 'montserrat_medium'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                          //vendor location data
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 3.0),
                                          child: Image(
                                            image: locationIcon,
                                            color: MyColor.themeBlue,
                                            width: 15,
                                            height: 18,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                          text: _getXController
                                              .currentOrderList[index]
                                              .customerCity,
                                          style: TextStyle(
                                              fontSize: MyDimens.textSize14,
                                              color: MyColor.themeBlue,
                                              fontFamily: 'montserrat_medium')),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18.0),
                                        child: Text(
                                          _getXController
                                              .currentOrderList[index].address!,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: MyDimens.textSize13,
                                              color: MyColor.themeBlue,
                                              fontFamily: 'montserrat_regular'),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              redirectToMap(
                                                  _getXController
                                                      .currentOrderList[index]
                                                      .lat!,
                                                  _getXController
                                                      .currentOrderList[index]
                                                      .lng!);
                                            },
                                            child: Image(
                                              image: locationDirectionIc,
                                              color: MyColor.themeBlue,
                                              width: 25,
                                              height: 25,
                                            )),

                                        SizedBox(width: 15,),

                                        InkWell(
                                            onTap: (){
                                              Get.to(() => ChatScreen(
                                                  receiverId: _getXController.currentOrderList[index].fkCustomer!,
                                                  receiverName: _getXController.currentOrderList[index].fkCustomerName!,
                                                  callFrom: "",));

                                            },
                                            child: Image(image: messageIcon, color: MyColor.themeBlue, width: 25, height: 25)),

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
  /// Redirect to Direction on MAP
  /// from vendor current location to Customer Location
  ///
  void redirectToMap(double destiLatitude, double destiLongitude) async{
    String url =
        'https://www.google.com/maps/dir/?api=1&origin=${_getXController.latitude},${_getXController.longitude}&destination=$destiLatitude,$destiLongitude&travelmode=driving';
    if (await launchUrl(Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }



  ///*
  ///
  ///
  createServiceContainer() {

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
          top: 22.0, left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "We haven't found any services in your account, please creates services to receive bookings",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 13.0,
                color: MyColor.textGrey,
                fontFamily: 'montserrat_medium'),
          ),

          SizedBox(height: 15,),
          ElevatedButton(
              onPressed: () {
                Get.to(VendorCategoriesScreen());
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  elevation: 5),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "Create Your Service",
                  style: const TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                      fontFamily: 'montserrat_medium'),
                ),
              )),
        ],
      ),
    );
  }




  ///*
  ///
  ///
  Widget notificationCountWidget() {
    return InkWell(
      onTap: () async{
       var nav = await Get.to(() => NotificationListScreen(userType: 'Vendor',));
       if(nav == null){
         //recall when comeback from notification list to update notification count
         _getXController.hitNotificationCountApi();
       }
      },
      child: Container(
        width: 40,
        height: 70,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 5,
              child: Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
              ),
            ),

            _getXController.notificationCount != 0?
            Positioned(
              top: 15,
              right: 7,
              child: Container(
                height: 18,
                width: 18,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyColor.orangeColor,
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Text(
                  _getXController.notificationCount.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'roboto_bold',
                      fontSize: MyDimens.textSize10),
                ),
              ),
            ):
            SizedBox()
          ],
        ),
      ),
    );

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
            yesFunction: (){
              SystemNavigator.pop();
            },
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
  /// if you enable locationService and not allowing deviceLocation Permission
  /// then you will get Exception popup with message
  /// "User denied Permission  to access the device's location"
  void setInitialLocation() async {
    _progressDialog = ProgressDialog(context: context);
    _progressDialog.show(
      msg: "Please wait...",
      max: 100,
      progressBgColor: Colors.yellow,
      backgroundColor: MyColor.themeBlue,
      msgColor: Colors.white,
      msgFontSize: MyDimens.textSize18,
      msgFontWeight: FontWeight.bold,);


    await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.best)
        .then((geo.Position position) {

      setState(() {
        _getXController.latitude = position.latitude;
        _getXController.longitude = position.longitude;
      });

      Navigator.pop(context);

      Future.delayed(Duration.zero, () async {
        _getXController.hitViewProfileApi();
      });

    }).catchError((e) {
      print(e);
      Future.delayed(Duration.zero, () async {
        _getXController.hitViewProfileApi();
      });
      Navigator.pop(context);
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
  ///check and request for location permission
  /// Location permission is required when your job is start
  /// if you don't allow location permission then your running job will not show
  checkAndRequestPermissions() async{
    permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied ) {
      permission = await geo.Geolocator.requestPermission();

      if (permission == geo.LocationPermission.denied) {
        log('Location_Permission : LocationPermission.denied');

        //if user denied permission then show dialog with info why location is required
        // and if user click on Ok button
        // again call checkAndRequestPermissions(); to show LocationPermission Popup
        showLocationPermssionDialog("denied");
        Future.delayed(Duration.zero, () async {
          _getXController.hitViewProfileApi();
        });

      }else if(permission == geo.LocationPermission.deniedForever){
        log('Location_Permission : ' + permission.toString());

        // when user check Don't Ask i.e DeniedForever
        // then show dialog with info why location permission is required
        // if user click on Ok button
        // then check for LocationService by calling checkLocationService();
        showLocationPermssionDialog("deniedForever");

        Future.delayed(Duration.zero, () async {
          _getXController.hitViewProfileApi();
        });

      }else if(permission == geo.LocationPermission.always || permission == geo.LocationPermission.whileInUse){
        log('Location_Permission : ' + permission.toString());
        checkLocationService();

      }
    }else{
      // check and request locationService
      checkLocationService();
    }

  }

  ///*
  ///
  /// if user denied permission then show dialog with info why location is required
  /// and if user click on Ok button
  /// again call checkAndRequestPermissions(); to show LocationPermission Popup
  /// when user check Don't Ask i.e DeniedForever
  /// then show dialog with info why location permission is required
  /// if user click on Ok button
  /// then check for LocationService by calling checkLocationService();
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
  /// check isServiceEnable status by calling location.serviceEnabled();
  /// if already enable then call setInitialLocation();
  /// if not enable then Request for service enable by calling location.requestService();
  /// and then again check isServiceEnable if user allow then call setInitialLocation();
  /// if not allow then show showLocationServiceDialog() with message
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
  /// if user click on No thanks
  /// then show this popup with message
  /// "To access your current location please turn on location."
  void showLocationServiceDialog() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => PermissionDialog(
            my_context: Get.context!,
            msg: "To access your current location please turn on location.",
            okFunction: checkLocationService,
            cancelFunction: noFunction));

  }






}
