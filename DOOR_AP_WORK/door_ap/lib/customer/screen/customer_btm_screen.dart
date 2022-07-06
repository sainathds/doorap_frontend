import 'dart:developer';

import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import 'customer_account_screen.dart';
import 'customer_all_category_screen.dart';
import 'customer_favourite_vendors_screen.dart';
import 'customer_home_screen.dart';
import 'customer_my_order_screen.dart';

class CustomerBtmScreen extends StatefulWidget {
  const CustomerBtmScreen({Key? key}) : super(key: key);

  @override
  _CustomerBtmScreenState createState() => _CustomerBtmScreenState();
}

class _CustomerBtmScreenState extends State<CustomerBtmScreen> {
  late ProgressDialog _progressDialog;
  // String country = "";
  // String currentAddress = "";
  // late Position _currentPosition;
  // double latitude = 0.0;
  // double longitude = 0.0 ;

  CustomerAddressModel _customerAddressModel = CustomerAddressModel();

  int currentPageNumber = 0;
  List<Widget> pages = <Widget>[];

  late Widget currentPage;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      setInitialLocation();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        // onTap: (int index) => _showPage(index),

        onTap: (int index){
          setState(() {
            currentPage = pages[index];
            currentPageNumber = index;
          });
        },
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

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {

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
    });



  }




  ///*
  ///
  ///
  void getAddress() async{

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _customerAddressModel.latitude,
          _customerAddressModel.longitude
      );

      Placemark place = placemarks[0];
      _customerAddressModel.address = "${place.subLocality},"           //Pimple Gurav,
          "${place.locality},"                //Pimpri-Chinchwad,
          "${place.postalCode}";            //411061

      _customerAddressModel.countryName = place.country!;
      _customerAddressModel.city = "${place.locality}";
      _customerAddressModel.zipCode = "${place.postalCode}";


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

    } catch (e) {
      print(e);
    }

  }


}
