import 'dart:developer';

import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:door_ap/customer/screen/customer_account_screen.dart';
import 'package:door_ap/customer/screen/customer_all_category_screen.dart';
import 'package:door_ap/customer/screen/customer_favourite_vendors_screen.dart';
import 'package:door_ap/customer/screen/customer_home_screen.dart';
import 'package:door_ap/customer/screen/customer_my_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class CustomerMainScreen extends StatefulWidget {
  const CustomerMainScreen({Key? key}) : super(key: key);

  @override
  _CustomerMainScreenState createState() => _CustomerMainScreenState();
}

class _CustomerMainScreenState extends State<CustomerMainScreen> {
  late ProgressDialog _progressDialog;

  int _currentIndex = 0;
  // String country = "";
  // String currentAddress = "";
  // late Position _currentPosition;
  // double latitude = 0.0;
  // double longitude = 0.0 ;
  late CustomerAddressModel _customerAddressModel;

  List<Widget> _pages = <Widget>[];

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      setInitialLocation();
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages != null && _pages.isNotEmpty ? IndexedStack(
        index: _currentIndex,
        children: _pages,
      ): SizedBox(),

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),

        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),

          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (int index){
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.home, color: MyColor.themeBlue,),
                  icon: Icon(Icons.home, color: MyColor.fieldBorderGrey,),
                  label: ""),

              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.category, color: MyColor.themeBlue,),
                  icon: Icon(Icons.category, color: MyColor.fieldBorderGrey),
                  label: ""),

              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.reorder_sharp, color: MyColor.themeBlue,),
                  icon: Icon(Icons.reorder_sharp, color: MyColor.fieldBorderGrey),
                  label: ""),

              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.favorite, color: MyColor.themeBlue,),
                  icon: Icon(Icons.favorite, color: MyColor.fieldBorderGrey),
                  label: ""),

              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.person, color: MyColor.themeBlue,),
                  icon: Icon(Icons.person, color: MyColor.fieldBorderGrey),
                label: ""),

            ],
          ),
        ),
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
      log("Main Address : " + _customerAddressModel.address);
      log("Main Country : " + _customerAddressModel.countryName);

      _progressDialog.close();

      _pages.clear();
      _pages.add(CustomerHomeScreen(customerAddressModel: _customerAddressModel));
      _pages.add( CustomerAllCategoryScreen(customerAddressModel: _customerAddressModel));
      _pages.add(CustomerMyOrderScreen());
      _pages.add(CustomerFavouriteScreen());
      _pages.add(CustomerAccountScreen());
      setState(() {});

    } catch (e) {
      print(e);
    }

  }


}

