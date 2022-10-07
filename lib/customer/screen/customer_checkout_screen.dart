import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_constants.dart';
import 'package:door_ap/common/utils/my_place_picker.dart';
import 'package:door_ap/common/utils/my_shared_preference.dart';
import 'package:door_ap/customer/controller/customer_checkout_controller.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:door_ap/customer/model/response/customer_get_cart_item_response.dart';
import 'package:door_ap/customer/screen/customer_change_address_screen.dart';
import 'package:door_ap/customer/screen/customer_order_details_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:http/http.dart' as http;

class CustomerCheckoutScreen extends StatefulWidget {
  late CustomerAddressModel? customerAddressModel;
  late int? vendorId;
  late int? categoryId;
  late List<CartData>? cartData;
  late String? bookTime;
  String bookDate;
  late String? vendorName;
  late String? categoryName;
  Calculation calculation;


  CustomerCheckoutScreen(
      {Key? key,
        this.customerAddressModel,
        this.vendorId,
        this.categoryId,
        this.cartData,
        this.bookTime,
        required this.bookDate,
        this.vendorName,
        this.categoryName,
        required this.calculation
        }) : super(key: key);

  @override
  _CustomerCheckoutScreenState createState() => _CustomerCheckoutScreenState();


}

class _CustomerCheckoutScreenState extends State<CustomerCheckoutScreen> {
  CustomerCheckoutController _getXController = Get.put(CustomerCheckoutController());
  late GoogleMapController mapController;
  late LatLng startLocation;


  @override
  void initState() {
    // TODO: implement initState

    PluginGooglePlacePicker.initialize(
        androidApiKey: MyString.googleApiKey);

    MySharedPreference.getInstance();

    _getXController.isPaymentSucceeded = false;
    _getXController.makePayment = makePayment;

    setBookOrderRequestBody();


    super.initState();
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
            headerWidget(),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    profileDataWidget(),

                    Container(
                      margin: EdgeInsets.only( top: 10.0, bottom: 20.0),
                      height: 2.0,
                      color: Colors.black26,
                    ),

                    cartDataWidget(),

                    Container(
                      margin: EdgeInsets.only( top: 20.0, bottom: 15.0),
                      height: 2.0,
                      color: Colors.black26,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        children: [
                          Text('Change Address '),
                          Icon(Icons.edit_location_outlined, color: MyColor.themeBlue,),
                        ],
                      ),
                    ),

                    SizedBox(height: 5.0,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: locationField(),
                    ),

                    // mapWidget(),
                    SizedBox(height: 20.0,),
                    calculationWidget()

                  ],
                ),
              ),
            ),

            Container(
              // margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                // color: Colors.white,
               /* boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 7,
                    blurRadius: 2,
                    offset: Offset(0, 7), // changes position of shadow
                  ),
                ],*/
              ),
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex:2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          '\$' + widget.calculation.totalAmount.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MyDimens.textSize15,
                              color: MyColor.themeBlue,
                              fontFamily: 'montserrat_semiBold'),
                        ),

                        Text(
                          'Duration ' + widget.calculation.averageTime.toString() + ' Hrs',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MyDimens.textSize15,
                              color: MyColor.textGrey,
                              fontFamily: 'montserrat_semiBold'),
                        ),
                      ],
                    ),
                  ),

                  _getXController.isPaymentSucceeded?
                      Text('Payment saved', style: TextStyle(color: Colors.green, fontFamily: 'roboto_bold', fontSize: MyDimens.textSize15),)

                      :
                  Expanded(
                    child: Container(
                      height: 40,
                      child: ElevatedButton(
                          onPressed: (){
                            _getXController.hitCreatePaymentIntentApi(widget.calculation.totalAmount!);
                          },
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),),
                              elevation: 5),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text("Pay",
                              style: const TextStyle(
                                  fontSize: MyDimens.textSize15,
                                  color: Colors.white,
                                  fontFamily: 'sf_pro_bold'
                              ),),
                          )),
                    ),
                  ),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: (){
                            if(_getXController.isPaymentSucceeded){
                              _getXController.hitBookingOrderApi();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(),
                              elevation: 0,
                              primary: _getXController.isPaymentSucceeded? MyColor.themeBlue: MyColor.lightBgGrey),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text("Place Order",
                              style: TextStyle(
                                  fontSize: MyDimens.textSize15,
                                  color: _getXController.isPaymentSucceeded? Colors.white: MyColor.selectedOtp,
                                  fontFamily: 'sf_pro_bold'
                              ),),
                          )),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  ///*
  ///
  ///
  Widget headerWidget() {
    return Container(
      width: double.infinity,
      color: MyColor.themeBlue,
      padding:
      const EdgeInsets.only(top: 15.0, left: 23.0, right: 23.0, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              Text(
                'Checkout',
                style: const TextStyle(
                    fontSize: MyDimens.textSize20,
                    color: Colors.white,
                    fontFamily: 'roboto_medium'),
              ),
              const SizedBox(
                height: 16,
                width: 18,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  _getXController.address,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: MyDimens.textSize12,
                      color: Colors.white,
                      fontFamily: 'roboto_medium'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  //
  ///
  ///
  ///
  profileDataWidget() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.vendorName!,
                  style: TextStyle(
                      fontSize: MyDimens.textSize22,
                      color: Colors.black,
                      fontFamily: 'roboto_bold'),
                ),
                Text(
                  widget.categoryName!,
                  style: TextStyle(
                      fontSize: MyDimens.textSize16,
                      color: MyColor.textGrey,
                      fontFamily: 'roboto_medium'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


  ///*
  ///
  ///
  cartDataWidget() {
    return
      ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return Divider();
          },
          shrinkWrap: true,
          itemCount: widget.cartData!.length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0 , right: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Text(
                                widget.cartData![index].fkVenderServiceFkServiceServiceName!,
                                style: TextStyle(
                                    fontSize: MyDimens.textSize16,
                                    color: Colors.black,
                                    fontFamily: 'roboto_bold'
                                ),
                              ),

                              SizedBox(height: 5,),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Price : \$' + widget.cartData![index].price!.toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: MyDimens.textSize12,
                                        color: Colors.black,
                                        fontFamily: 'roboto_medium'
                                    ),
                                  ),

                                  SizedBox(width: 20.0,),
                                  Text(
                                    'Qty: ' + widget.cartData![index].quantity.toString(),
                                    style: TextStyle(
                                        fontSize: MyDimens.textSize12,
                                        color: MyColor.black50,
                                        fontFamily: 'roboto_medium'
                                    ),
                                  ),
                                ],
                              ),

                            ],),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            );
          });
  }


  ///*
  ///
  ///
  mapWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      height: 400.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.center,

        children: [

          GoogleMap(              //Map widget from google_maps_flutter package
            zoomGesturesEnabled: true, //enable Zoom in, out on map
            initialCameraPosition: CameraPosition( //innital position in map
              target: startLocation, //initial position
              zoom: 16.0, //initial zoom level
            ),
            mapType: MapType.normal, //map type
            onMapCreated: (controller) { //method called when map is created
              setState(() {
                mapController = controller;
              });
            },
          gestureRecognizers: < Factory < OneSequenceGestureRecognizer >> [
            new Factory < OneSequenceGestureRecognizer > (
                  () => new EagerGestureRecognizer(),
            ),
          ].toSet(),

            onCameraMove: (position) {
              _getXController.latitude = position.target.latitude;
              _getXController.longitude = position.target.longitude;
              },

            onCameraIdle: (){
              getAddress();

            },
          ),



          Icon(Icons.flag, color: Colors.black,)

        ],
      ),
    );

  }


  ///*
  /// Location Field
  Widget locationField() {
    return TextFormField(
      readOnly: true,
      onTap: () async{
        // dynamic nav = await Get.to(() => CustomerChangeAddressScreen(latitude: widget.latitude!, longitude: widget.longitude!));

        Route route = MaterialPageRoute(builder: (context) =>
                CustomerChangeAddressScreen(customerAddressModel: widget.customerAddressModel!));
         LatLng latLng = await Navigator.of(context)
            .push(route);

         log("NAV" + latLng.toString());

         setState(() {
           _getXController.latitude = latLng.latitude;
           _getXController.longitude = latLng.longitude;
            getAddress();
          });

      },
      controller: _getXController.locationEditController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: fieldStyle(),
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        border: OutlineInputBorder(),
        // labelText: MyString.location!.toUpperCase(),
        // labelStyle: labelStyle(),
        hintText: MyString.selectYourLocation,
        // errorText: _getXController.isLocationEmpty ? "Please Select location" : null ,
      ),
      onEditingComplete: (){
        // _getXController.address1Focus.requestFocus();
      },
    );
  }

  ///*
  ///
  TextStyle fieldStyle(){
    return const TextStyle(
        fontSize: MyDimens.textSize14,
        color: MyColor.fieldGrey,
        fontFamily: 'sf_pro_regular'
    );
  }

  ///*
  ///
  TextStyle labelStyle(){
    return const TextStyle(
        fontSize: MyDimens.textSize10,
        color: MyColor.labelGrey,
        fontFamily: 'sf_pro_semibold'
    );
  }


  ///*
  ///
  ///
  calculationWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Payment Summary :',
                style: TextStyle(
                    fontSize: MyDimens.textSize18,
                    color: MyColor.themeBlue,
                    fontFamily: 'roboto_bold'
                ),),
            ],
          ),

          //total Item
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Total Item',
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: Colors.black,
                      fontFamily: 'roboto_medium'
                  ),),
              ),

              Text(widget.calculation.itemCount.toString() ,
                style: TextStyle(
                    fontSize: MyDimens.textSize14,
                    color: Colors.black,
                    fontFamily: 'roboto_bold'
                ),),
            ],
          ),

          //total price
          SizedBox(height: 5.0,),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Total Price ',
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: Colors.black,
                      fontFamily: 'roboto_medium'
                  ),),
              ),

              Text('\$' + widget.calculation.subTotal!.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: MyDimens.textSize14,
                    color: Colors.black,
                    fontFamily: 'roboto_bold'
                ),),
            ],
          ),

          SizedBox(height: widget.calculation.discount == 0? 0 : 5.0,),

          widget.calculation.discount == 0?
              SizedBox():
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Discount ',
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: Colors.black,
                      fontFamily: 'roboto_medium'
                  ),),
              ),

              Text('\$' + widget.calculation.discount!.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: MyDimens.textSize14,
                    color: Colors.black,
                    fontFamily: 'roboto_bold'
                ),),
            ],
          ),

          //convenience fees
          SizedBox(height: 5.0,),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Convenience Fees ',
                  style: TextStyle(
                      fontSize: MyDimens.textSize14,
                      color: Colors.black,
                      fontFamily: 'roboto_medium'
                  ),),
              ),

              Text('\$' + widget.calculation.convenienceFee!.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: MyDimens.textSize14,
                    color: Colors.black,
                    fontFamily: 'roboto_bold'
                ),),
            ],
          ),

          //grand total
          SizedBox(height: 20.0,),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text('Total Amount',
                  style: TextStyle(
                      fontSize: MyDimens.textSize16,
                      color: Colors.black,
                      fontFamily: 'roboto_bold'
                  ),),
              ),

              Text( '\$' + widget.calculation.totalAmount!.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: MyDimens.textSize16,
                    color: Colors.black,
                    fontFamily: 'roboto_bold'
                ),),
            ],
          ),

        ],
      ),
    );
  }


  ///*
  ///
  ///
/*
  void getAddress() async{
    List<Placemark> placemarks = await placemarkFromCoordinates(
        _getXController.latitude,
        _getXController.longitude);

    Placemark place = placemarks[0];
    String currentAddress = " ${place.subLocality},"           //Pimple Gurav,
        "${place.locality},"                //Pimpri-Chinchwad,
        "${place.postalCode}";            //411061

    _getXController.city = "${place.locality}";
    _getXController.zipCode = "${place.postalCode}";


    log("Checkout Address : " + currentAddress);
    log("Checkout City : " + _getXController.city);
    log("Checkout ZipCode : " + _getXController.city);

    setState(() {
      _getXController.locationEditController.text = currentAddress;
      _getXController.address = currentAddress;
    });

  }
*/


  ///*
  ///
  /// Enable geocoding api from google developer console
  void getAddress() async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=${MyString.googleApiKey}&language=en&latlng=${_getXController.latitude},${_getXController.longitude}';
    log("URL ADDR"  + url);

    if(_getXController.latitude != null && _getXController.longitude != null){
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

        setState(() {
          _getXController.locationEditController.text = _formattedAddress;
          _getXController.address = _formattedAddress;
          _getXController.countryName = countries[0];
          _getXController.city = localities[0];
          _getXController.zipCode = postalCode[0];

          log("Checkout Address : " + _getXController.address);
        log("Checkout Country : " + _getXController.countryName);
        log("Checkout City : " + _getXController.city);
        log("Checkout ZipCode : " + _getXController.zipCode);
        });
      }
    }
  }


  ///*
  ///
  ///
  void setBookOrderRequestBody() {
    _getXController.requestModel.customerId = MySharedPreference.getInt(MyConstants.keyUserId);
    _getXController.requestModel.vendorId = widget.vendorId;
    _getXController.requestModel.categoryId = widget.categoryId;

    //calculation data
    _getXController.requestModel.quantity = widget.calculation.itemCount;
    _getXController.requestModel.subTotal = widget.calculation.subTotal;
    _getXController.requestModel.discount = widget.calculation.discount;
    _getXController.requestModel.convenienceFee = widget.calculation.convenienceFee;
    _getXController.requestModel.totalAmount = widget.calculation.totalAmount;
    _getXController.requestModel.duration = widget.calculation.averageTime;
    _getXController.requestModel.promocode = MySharedPreference.getString(MyConstants.keyPromoCode);  //check
    _getXController.requestModel.appliedId = widget.calculation.appliedId;


    //Complete address
    _getXController.locationEditController.text = widget.customerAddressModel!.address;
    _getXController.address = widget.customerAddressModel!.address;
    _getXController.city = widget.customerAddressModel!.city;
    _getXController.zipCode = widget.customerAddressModel!.zipCode;
    _getXController.latitude = widget.customerAddressModel!.latitude;
    _getXController.longitude = widget.customerAddressModel!.longitude;
    _getXController.countryName = widget.customerAddressModel!.countryName;

    _getXController.requestModel.vendorServicesId = <int>[];
    //cart and vendor country data
    for(int index = 0; index < widget.cartData!.length; index++ ){
      _getXController.requestModel.vendorServicesId!.add(widget.cartData![index].fkVenderService!);
    }
    _getXController.requestModel.vendorCountryId = widget.cartData![0].fkVendorFkCountry;
    _getXController.requestModel.vendorCountryName = widget.cartData![0].fkVendorFkCountryCountryName;

    //current booking date Time
    DateTime nowDateTime = DateTime.now();
    String currentDate = nowDateTime.year.toString() +'-'+ nowDateTime.month.toString().padLeft(2, "0") +'-'+ nowDateTime.day.toString().padLeft(2, "0");
    log('BookingCurrent Date :' + currentDate);
    _getXController.requestModel.currentBookingDate = currentDate;

    String currentTime = nowDateTime.hour.toString().padLeft(2, "0") +':'+ nowDateTime.minute.toString().padLeft(2, "0") +':'+ nowDateTime.second.toString().padLeft(2, "0");
    log('BookingCurrent Time :' + currentTime);
    _getXController.requestModel.currentBookingTime = currentTime;

    //booking date time
    _getXController.requestModel.bookingDate = widget.bookDate;
    _getXController.requestModel.bookingStartTime = widget.bookTime;
    DateTime time = DateTime.parse(widget.bookDate + " " + widget.bookTime!);
    DateTime endTime = time.add(new Duration(hours: widget.calculation.averageTime!));  //avg time == total time
    _getXController.requestModel.bookingEndTime = endTime.hour.toString().padLeft(2, "0") + ":" + endTime.minute.toString().padLeft(2, "0");

    log("EndTime Date= " + endTime.toString());
    log("EndTime Time = " + _getXController.requestModel.bookingEndTime!);

  }





  ///*
  ///
  ///
  Future<void> makePayment() async {
    try {

      BillingDetails billingDetails = BillingDetails(
          email: MySharedPreference.getString(MyConstants.keyEmail)
      );
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            billingDetails: billingDetails,
            paymentIntentClientSecret: _getXController.stripeClientSecretKey,
            customerId: _getXController.stripeCustomerId,
            customerEphemeralKeySecret: _getXController.stripeEphemeralKeySecret,
            style: ThemeMode.dark,
            merchantDisplayName: 'Doorap Stripe Test',
          ));

      displayPaymentSheet(billingDetails);

    } catch (e) {
      log('makePayment Exception : ' + e.toString());
    }
  }


  ///*
  ///
  ///
  displayPaymentSheet(BillingDetails billingDetails) async {
    try{
      await Stripe.instance.presentPaymentSheet();
      setState(() {});

      PaymentIntent paymentIntent = await Stripe.instance.retrievePaymentIntent(_getXController.stripeClientSecretKey);

      log( 'PAYMENT_INTENT _STATUS' + paymentIntent.status.toString());
      log( 'PAYMENT_INTENT _AMOUNT' + paymentIntent.amount.toString());

      if(paymentIntent.status == PaymentIntentsStatus.Succeeded){
        _getXController.isPaymentSucceeded = true;
        setState(() {
        });
      }
    }catch(exception){
      log('displayPaymentSheet Exception  ' + exception.toString());
    }

  }

}
