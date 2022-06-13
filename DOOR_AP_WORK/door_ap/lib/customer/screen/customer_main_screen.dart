import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/customer/screen/customer_account_screen.dart';
import 'package:door_ap/customer/screen/customer_all_category_screen.dart';
import 'package:door_ap/customer/screen/customer_favourite_screen.dart';
import 'package:door_ap/customer/screen/customer_home_screen.dart';
import 'package:door_ap/customer/screen/customer_my_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomerMainScreen extends StatefulWidget {
  const CustomerMainScreen({Key? key}) : super(key: key);

  @override
  _CustomerMainScreenState createState() => _CustomerMainScreenState();
}

class _CustomerMainScreenState extends State<CustomerMainScreen> {

  int _currentIndex = 0;
  int _pState = 0;
  bool canback = false;


  final List<Widget> _pages = <Widget>[
    const CustomerHomeScreen(),
    const CustomerAllCategoryScreen(),
    const CustomerMyOrderScreen(),
    const CustomerFavouriteScreen(),
    const CustomerAccountScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
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



}

