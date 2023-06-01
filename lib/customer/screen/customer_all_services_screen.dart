import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/controller/customer_all_services_controller.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:door_ap/customer/screen/customer_vendors_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CustomerAllServicesScreen extends StatefulWidget {

  String searchQuery;
  CustomerAddressModel customerAddressModel;

  CustomerAllServicesScreen({Key? key, required this.searchQuery, required this.customerAddressModel, } ) : super(key: key);

  @override
  _CustomerAllServicesScreenState createState() => _CustomerAllServicesScreenState();
}

class _CustomerAllServicesScreenState extends State<CustomerAllServicesScreen> {

  CustomerAllServicesController _getXController = Get.put(CustomerAllServicesController());

  @override
  void initState() {
    // TODO: implement initState
    MySharedPreference.getInstance();
    _getXController.searchEditController.text = widget.searchQuery;
    _getXController.refreshPage = refreshPage;
    _getXController.allServices.clear();
    Future.delayed(Duration.zero, () async {
      _getXController.hitShowAllServicesApi();
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColor.themeBlue,
    ));

    return SafeArea(
      child: Scaffold(
        body: Column(

          children: [
            headerAndSearchWidget(),

            _getXController.allServices.isNotEmpty?
                servvicesListWidget()
                : Center(child: Text("no services are available",
              style: TextStyle(fontSize: MyDimens.textSize14, color: MyColor.labelGrey, fontFamily: 'sf_pro_semibold'),),)
          ],
        ),
      ),
    );
  }

  ///*
  ///
  ///
  Widget headerAndSearchWidget() {
    return Container(
      width: double.infinity,
      color: MyColor.themeBlue,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 23.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: (){
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.white,)),

          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              height: 45,
              child: TextFormField(
                controller: _getXController.searchEditController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (query) async{
                  if(_getXController.searchEditController.text.trim().isNotEmpty){
                    _getXController.hitShowAllServicesApi();
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 15.0),
                    hintText: MyString.search,
                    hintStyle: const TextStyle(
                        fontSize: MyDimens.textSize12,
                        color: Colors.grey,
                        fontFamily: 'montserrat_semiBold'),

                    suffixIcon: InkWell(
                      onTap: (){
                        if(_getXController.searchEditController.text.trim().isNotEmpty){
                          _getXController.hitShowAllServicesApi();
                        }
                      },
                      child: Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.grey,
                      ),
                    )),

                onChanged: (value){
                  if(value.isEmpty){
                    _getXController.hitShowAllServicesApi();
                  }
                  },
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  Widget servvicesListWidget() {
    return
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
                itemCount: _getXController.allServices.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    onTap: (){
                      // Get.to(() => CustomerVendorsScreen(serviceData: _getXController.allServices[index]));
                      Get.to( () => CustomerVendorsScreen(
                          serviceOrCategoryName: _getXController.allServices[index].serviceName!,
                          categoryId: _getXController.allServices[index].fkCategory.toString(),
                          customerAddressModel: widget.customerAddressModel,
                          ));
                    },
                    child: Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                child:
                                _getXController.allServices[index].serviceImage != null && _getXController.allServices[index].serviceImage != "" ?
                                Image.network(baseImageUrl + _getXController.allServices[index].serviceImage!,
                                  width: 60, height: 60, fit: BoxFit.fill,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    return Image(
                                        image: noImage, width: 60, height: 60, fit: BoxFit.fill);
                                  },
                                   )
                                    :
                                Image(
                                    image: noImage,
                                    width: 60, height: 60, fit: BoxFit.fill)

                            ),
                          ),

                          Expanded(
                            flex:2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_getXController.allServices[index].serviceName!,
                                    style: TextStyle(
                                        fontSize: MyDimens.textSize14,
                                        color: MyColor.fieldGrey,
                                        fontFamily: 'montserrat_semiBold'
                                    ),),

                                  Text(_getXController.allServices[index].fkCategoryCategoryName!,
                                    style: TextStyle(
                                        fontSize: MyDimens.textSize12,
                                        color: MyColor.labelGrey,
                                        fontFamily: 'montserrat_semiBold'
                                    ),),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        );
  }

}
