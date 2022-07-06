import 'package:door_ap/common/network/url.dart';
import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/customer/controller/customer_favourite_vendors_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';

class CustomerFavouriteScreen extends StatefulWidget {
  const CustomerFavouriteScreen({Key? key}) : super(key: key);

  @override
  _CustomerFavouriteScreenState createState() => _CustomerFavouriteScreenState();
}

class _CustomerFavouriteScreenState extends State<CustomerFavouriteScreen> {

  CustomerFavouriteVendorsController _getXController = Get.put(CustomerFavouriteVendorsController());


  @override
  void initState() {
    // TODO: implement initState
    _getXController.refreshPage = refreshPage;
    _getXController.vendorsData!.clear();

    Future.delayed(Duration.zero, () async {
      _getXController.hitFavouriteVendorsApi();
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
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: AppBar(
/*          leading: InkWell(
              onTap: (){
                Get.off(() => (context));
              },
              child: Icon(Icons.arrow_back_ios)),*/
          elevation: 5,
          shadowColor: MyColor.textGrey,
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: MyColor.themeBlue, // Navigation bar
            statusBarColor: MyColor.themeBlue, // Status bar
          ),
          centerTitle: true,
          title: const Text(
            "Favourites",
            style: TextStyle(
                fontSize: MyDimens.textSize20,
                color: Colors.white,
                fontFamily: 'roboto_medium'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Icon(Icons.search),
            )
          ],
        ),
        body: Column(
          children: [
            _getXController.vendorsData != null && _getXController.vendorsData!.isNotEmpty?
            vendorsListWidget()
                : Expanded(
                  child: Center(child: Text("no vendors are found",
              style: TextStyle(fontSize: MyDimens.textSize14, color: MyColor.labelGrey, fontFamily: 'sf_pro_semibold'),),),
                )
          ],
        )
      ),
    );
  }


  ///*
  ///
  ///
  vendorsListWidget() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: SingleChildScrollView(
          child: LayoutGrid(
              gridFit : GridFit.loose,
              columnSizes: [1.fr, 1.fr,],
              rowSizes: List<IntrinsicContentTrackSize>.generate(
                  (_getXController.vendorsData!.length / 2).round(),
                      (int index) => auto),
              rowGap: 10,
              columnGap: 5,
              children: [
                for (var index = 0; index < _getXController.vendorsData!.length; index++)
                  InkWell(
                    /*onTap: (){
                      Get.to(() =>CustomerVendorProfileScreen(vendorId: _getXController.vendorsData![index].fkVendorId.toString(),
                          categoryId: int.parse(_getXController.categoryId),
                          currentAddress: widget.currentAddress,
                          country: widget.country));
                    },*/
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            color: MyColor.themeBlue
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 175,
                              child: Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        child: _getXController.vendorsData![index].fkVendorProfileImage == "" ?
                                        Image(image:  noImage,
                                          height: 150.0, fit: BoxFit.fill,)
                                            :
                                        Image.network(baseImageUrl + _getXController.vendorsData![index].fkVendorProfileImage!,
                                          height: 150.0, fit: BoxFit.fill,
                                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                            return Image(
                                                image: noImage, height: 150, fit: BoxFit.fill);
                                          },)),
                                  ),

/*
                              Positioned(
                                bottom: 5,
                                  right: 15,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50), ),
                                elevation: 5,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: MyColor.inactiveOtp
                                  ),
                                  child: Image(image: messageIcon,),
                                ),
                              )),
*/

                                  //like dislike
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: InkWell(
                                      onTap: (){
                                        /*setState(() {
                                          _getXController.vendorsData![index].likeDislike = !_getXController.vendorsData![index].likeDislike!;
                                          _getXController.hitLikeDislikeApi(_getXController.vendorsData![index].fkVendorId!,
                                              _getXController.vendorsData![index].likeDislike.toString().capitalizeFirst!);
                                        });*/
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50),),
                                        elevation: 5,
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: MyColor.inactiveOtp
                                          ),
                                          child: Icon(
                                              Icons.favorite,
                                              color: _getXController.vendorsData![index].likeDislike! ? Colors.red : Colors.black26),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            //rating
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, ),
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: Colors.white, size: 20.0,),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      _getXController.vendorsData![index].rating!.toString(),
                                      style: TextStyle(
                                          fontSize: MyDimens.textSize12,
                                          color: Colors.white,
                                          fontFamily: 'sf_pro_regular'
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            //vendor name
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      _getXController.vendorsData![index].fkVendorFullName!,
                                      style: TextStyle(
                                          fontSize: MyDimens.textSize14,
                                          color: Colors.white,
                                          fontFamily: 'roboto_bold'
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  )
              ]
          ),
        ),
      ),
    );
  }
}
