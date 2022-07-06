
import 'dart:developer';

import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/customer/controller/customer_home_controller.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:door_ap/customer/screen/customer_vendors_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:get/get.dart';

import 'cuatomer_cart_summary_screen.dart';
import 'customer_all_category_screen.dart';
import 'customer_all_services_screen.dart';

class CustomerHomeScreen extends StatefulWidget {

  CustomerAddressModel? customerAddressModel;

  CustomerHomeScreen({Key? key, required this.customerAddressModel,}) : super(key: key);

  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  CustomerHomeController _getXController = Get.put(CustomerHomeController());

  @override
  void initState() {
    // TODO: implement initState
    _getXController.categoriesData.clear();
    _getXController.bannerData.clear();
    _getXController.refreshPage = refreshPage;

    Future.delayed(Duration.zero, () async {
      _getXController.hitCartCountApi();
    });

    Future.delayed(Duration.zero, () async {
      _getXController.hitCategoriesApi();
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          /*leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Image(
              image: custHamburgerIcon,
              height: 48,
              width: 48,
            ),
          ),*/
          title: Row(
            children: [
              const Icon(
                Icons.location_on_sharp,
                color: MyColor.themeBlue,
              ),
              Expanded(child: Text(widget.customerAddressModel!.address, style: labelStyle(), maxLines: 1,)),
            ],
          ),
          actions: [

            cartIconWidget(),

            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.notifications_none_rounded,
                color: MyColor.themeBlue,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                searchWidget(),

                // categoriesWidget(),

                _getXController.categoriesData.isNotEmpty
                    ? customGridCategoriesWidget()
                    : SizedBox(),

                _getXController.bannerData.isNotEmpty
                    ? bannerWidget()
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///*
  ///
  TextStyle labelStyle() {
    return const TextStyle(
        fontSize: MyDimens.textSize14,
        color: MyColor.textThemeBlue,
        fontFamily: 'sf_pro_semibold');
  }

  ///*
  ///
  ///
  Widget searchWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: Colors.black),
      child: Column(
        children: [
          Text(
            MyString.whatKindOfService,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MyDimens.textSize22,
                color: Colors.white,
                fontFamily: 'montserrat_semiBold'),
          ),
          Text(
            MyString.doYouNeed,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MyDimens.textSize22,
                color: Colors.white,
                fontFamily: 'montserrat_semiBold'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 19.0),
            child: Container(
              height: 45,
              child: TextFormField(
                controller: _getXController.searchEditController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    hintText: MyString.search,
                    hintStyle: const TextStyle(
                        fontSize: MyDimens.textSize12,
                        color: Colors.grey,
                        fontFamily: 'montserrat_semiBold'),
                    prefixIcon: Image(
                      image: leftSearchIcon,
                    ),
                    suffixIcon: InkWell(
                      onTap: () async{
                        var nav =  await Get.to(() => CustomerAllServicesScreen(
                            searchQuery : _getXController.searchEditController.text.trim(),
                            customerAddressModel: widget.customerAddressModel!));


                        if (nav == true || nav == null) {
                          _getXController.hitCartCountApi();
                        }
                      },
                      child: Image(
                        image: searchGoIcon,
                      ),
                    )),
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
  Widget categoriesWidget() {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 33.0, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  MyString.categories!,
                  style: TextStyle(
                      fontSize: MyDimens.textSize22,
                      color: Colors.black,
                      fontFamily: 'roboto_bold'),
                ),
                Text(
                  MyString.seeAll!,
                  style: TextStyle(
                      fontSize: MyDimens.textSize12,
                      color: MyColor.textGrey,
                      fontFamily: 'montserrat_semiBold'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 20),
                  itemCount: _getXController.categoriesData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        // Get.off( () => VendorServicesScreen(selectedCategData: _getXController.categoriesData[index]!));
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: _getXController.categoriesData[index]!
                                          .categoryImage ==
                                      ""
                                  ? Image(
                                      image: noProfileImg,
                                      width: 90.0,
                                      height: 100.0,
                                      fit: BoxFit.fill,
                                    )
                                  : Image(
                                      image: NetworkImage(baseImageUrl +
                                          _getXController.categoriesData[index]!
                                              .categoryImage!),
                                      width: 90,
                                      height: 100,
                                    )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            _getXController
                                .categoriesData[index]!.categoryName!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: MyDimens.textSize13,
                                color: MyColor.themeBlue,
                                fontFamily: 'montserrat_medium'),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  bannerWidget() {
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(vertical: 20.0),
      /*decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15)
      ),*/
      child: Swiper(
        containerHeight: 150,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  baseImageUrl +
                      _getXController.bannerData[index]!.bannerImage!,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Image(
                        image: noImage, fit: BoxFit.fitWidth);
                  },
                )),
          );
        },
        itemCount: _getXController.bannerData.length,
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: new DotSwiperPaginationBuilder(
              color: Colors.grey, activeColor: MyColor.themeBlue),
        ),
      ),
    );
  }

  ///*
  ///
  ///
  customGridCategoriesWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                MyString.categories!,
                style: TextStyle(
                    fontSize: MyDimens.textSize22,
                    color: Colors.black,
                    fontFamily: 'roboto_bold'),
              ),
              InkWell(
                onTap: () async {
                  var nav =  await Get.to(
                      CustomerAllCategoryScreen(
                          customerAddressModel: widget.customerAddressModel!));

                  if (nav == true || nav == null) {
                    _getXController.hitCartCountApi();
                  }
                  },
                child: Text(
                  MyString.seeAll!,
                  style: TextStyle(
                      fontSize: MyDimens.textSize12,
                      color: MyColor.textGrey,
                      fontFamily: 'montserrat_semiBold'),
                ),
              ),
            ],
          ),
        ),
        LayoutGrid(
          gridFit : GridFit.loose,
          // set some flexible track sizes based on the crossAxisCount
          columnSizes: [1.fr, 1.fr, 1.fr],
          // set all the row sizes to auto (self-sizing height)
          rowSizes: _getXController.categoriesData.length <= 3
              ? [auto]
              : [auto, auto],
          columnGap: 5,
          rowGap: 15,
          children: [
            for (var index = 0; index < 6; index++)
              InkWell(
                onTap: () async {
                  var nav = await Get.to(() => CustomerVendorsScreen(
                                                      serviceOrCategoryName: _getXController.categoriesData[index]!.categoryName!,
                                                      categoryId: _getXController.categoriesData[index]!.id.toString(),
                                                      customerAddressModel: widget.customerAddressModel!));

                   if (nav == true || nav == null) {
                     _getXController.hitCartCountApi();
                   }
                  },
                child: Center(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: _getXController
                                    .categoriesData[index]!.categoryImage ==
                                ""
                            ? Image(
                                image: noImage,
                                // width: 101.0,
                                height: 114.0,
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                baseImageUrl +
                                    _getXController
                                        .categoriesData[index]!.categoryImage!,
                                // width: 101.0,
                                height: 114.0,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Image(
                                      image: noImage,
                                      // width: 101,
                                      height: 114,
                                      fit: BoxFit.fill);
                                },
                              ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        _getXController.categoriesData[index]!.categoryName!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: MyDimens.textSize13,
                            color: MyColor.themeBlue,
                            fontFamily: 'montserrat_medium'),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }


  ///*
  ///
  ///
  Widget cartIconWidget() {
    return InkWell(
      onTap: () async{
        if(_getXController.cartCount != 0){
          var nav = await Get.to(() => CustomerCartSummaryScreen(
            categoryId: _getXController.categoryId,
            vendorId: _getXController.vendorId,
              customerAddressModel: widget.customerAddressModel!
          ));

          if (nav == true || nav == null) {
            _getXController.hitCartCountApi();
          }
        }
      },
      child: Container(
        width: 50,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 5,
              child: Icon(
                Icons.shopping_cart_outlined,
                color: MyColor.themeBlue,
              ),
            ),

            _getXController.cartCount != 0?
            Positioned(
              top: 10,
              right: 15,
              child: Container(
                height: 18,
                width: 18,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyColor.orangeColor,
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Text(
                  _getXController.cartCount.toString(),
                  style: TextStyle(
                      color: MyColor.themeBlue,
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




}
