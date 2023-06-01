import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/vendor/controller/vendor_categories_controller.dart';
import 'package:door_ap/vendor/screen/vendor_services_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';

class VendorCategoriesScreen extends StatefulWidget {
  const VendorCategoriesScreen({Key? key}) : super(key: key);

  @override
  _VendorCategoriesScreenState createState() => _VendorCategoriesScreenState();
}

class _VendorCategoriesScreenState extends State<VendorCategoriesScreen> {

  VendorCategoriesController _getXController = Get.put(VendorCategoriesController());

  @override
  void initState() {
    // TODO: implement initState

    _getXController.refreshPage = refreshPage;
    Future.delayed(Duration.zero, () async {
      _getXController.hitCategoriesApi();
    });
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
    return SafeArea(child: Scaffold(
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

                  Text(MyString.allCategories!,
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
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 23, bottom: 23,),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
                  color: Colors.white,
                ),
                child: _getXController.categoriesData.isNotEmpty?
                  /*getGridLayout()*/ getCustomGridLayout()
                    :Center(child: Text("no categories are available"),)
              ),
            )
          ],
        ),
      ),
    ));
  }

  ///*
  ///
  ///
  getGridLayout() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 20),
        itemCount: _getXController.categoriesData.length,
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap: (){
              //select category and redirect to VendorServiceScreen to add service in your account
              Get.off( () => VendorServicesScreen(selectedCategData: _getXController.categoriesData[index]!));
            },
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: _getXController.categoriesData[index]!.categoryImage == "" ?
                    Image(image:  noProfileImg,
                      width: 90.0, height: 100.0, fit: BoxFit.fill,)

                        : Image(image:

                    NetworkImage(baseImageUrl + _getXController.categoriesData[index]!.categoryImage!),
                      width: 90, height: 100,)),

                SizedBox(height: 5.0,),
                Text(_getXController.categoriesData[index]!.categoryName!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MyDimens.textSize13,
                      color: MyColor.themeBlue,
                      fontFamily: 'montserrat_medium'
                  ),),
              ],
            ),
          );
        });
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
          rowGap: 20,
        children: [
          for (var index = 0; index < _getXController.categoriesData.length; index++)
            InkWell(
            onTap: (){
              Get.off( () => VendorServicesScreen(selectedCategData: _getXController.categoriesData[index]!));
            },
            child: Center(
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: _getXController.categoriesData[index]!.categoryImage == "" ?
                      Image(image:  noImage,
                        width: 90.0, height: 100.0, fit: BoxFit.fill,)
                          :
                      Image.network(baseImageUrl + _getXController.categoriesData[index]!.categoryImage!,
                          width: 90.0, height: 100.0,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Image(
                              image: noImage, width: 90, height: 100, fit: BoxFit.fill);
                        },)),

                  SizedBox(height: 5.0,),
                  Text(_getXController.categoriesData[index]!.categoryName!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MyDimens.textSize13,
                        color: MyColor.themeBlue,
                        fontFamily: 'montserrat_medium'
                    ),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
