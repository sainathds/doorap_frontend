import 'dart:developer';

import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/customer/controller/customer_all_categories_controller.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:door_ap/customer/screen/customer_vendors_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CustomerAllCategoryScreen extends StatefulWidget {

  CustomerAddressModel? customerAddressModel;

  CustomerAllCategoryScreen({Key? key, required this.customerAddressModel,}) : super(key: key);

  @override
  _CustomerAllCategoryScreenState createState() =>
      _CustomerAllCategoryScreenState();
}

class _CustomerAllCategoryScreenState extends State<CustomerAllCategoryScreen> {
  CustomerAllCategoriesController _getXController = Get.put(CustomerAllCategoriesController());

  @override
  void initState() {
    // TODO: implement initState

    //get all category
    Future.delayed(Duration.zero, () async {
      _getXController.hitCategoriesApi();
    });
    _getXController.refreshPage = refreshPage;
    _getXController.categoriesData.clear();
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
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
          appBar: AppBar(
            /*leading: InkWell(
              onTap: (){
                Get.back();

              },
              child: Icon(Icons.arrow_back_ios, color: Colors.white,)),
*/
            elevation: 5,
            shadowColor: MyColor.textGrey,
            systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarColor: MyColor.themeBlue, // Navigation bar
              statusBarColor: MyColor.themeBlue, // Status bar
            ),
            centerTitle: true,
            title: const Text(
              "All Categories",
              style: TextStyle(
                  fontSize: MyDimens.textSize20,
                  color: Colors.white,
                  fontFamily: 'roboto_medium'),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 15.0),
            child: Column(
              children: [
                // searchWidget(),
                _getXController.categoriesData.isNotEmpty
                    ? getCustomGridLayout()
                    : Center(
                        child: Text("no categories are available"),
                      )
              ],
            ),
          )),
    );
  }

  ///*
  ///
  ///
  Widget searchWidget() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 24.0),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Colors.black),
        child: TextFormField(
          // controller: _getXController.searchEditController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              hintText: MyString.search,
              hintStyle: const TextStyle(
                  fontSize: MyDimens.textSize12,
                  color: Colors.grey,
                  fontFamily: 'montserrat_semiBold'),
              prefixIcon: Image(
                image: leftSearchIcon,
              ),
              suffixIcon: Image(
                image: searchGoIcon,
              )),
        ));
  }

  ///*
  ///
  ///
  getCustomGridLayout() {
    return SingleChildScrollView(
      child: LayoutGrid(
        columnSizes: [1.fr, 1.fr, 1.fr],
        rowSizes: List<IntrinsicContentTrackSize>.generate(
            (_getXController.categoriesData.length / 2).round(),
            (int index) => auto),
        rowGap: 15,
        children: [
          for (var index = 0;
              index < _getXController.categoriesData.length;
              index++)
            InkWell(
              onTap: () {

                //by selecting category redirect to CustomerVendorsScreen
                Get.to(() => CustomerVendorsScreen(serviceOrCategoryName: _getXController.categoriesData[index]!.categoryName!,
                    categoryId: _getXController.categoriesData[index]!.id.toString(),
                    customerAddressModel: widget.customerAddressModel!));
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
    );
  }

}
