import 'dart:convert';
import 'dart:developer';

import 'package:door_ap/common/resources/my_assets.dart';
import 'package:door_ap/common/resources/my_colors.dart';
import 'package:door_ap/common/resources/my_dimens.dart';
import 'package:door_ap/common/resources/my_string.dart';
import 'package:door_ap/common/utils/my_place_picker.dart';
import 'package:door_ap/customer/model/others/customer_address_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:http/http.dart' as http;

class CustomerChangeAddressScreen extends StatefulWidget {

  CustomerAddressModel customerAddressModel;

  CustomerChangeAddressScreen(
      {Key? key, required this.customerAddressModel, })
      : super(key: key);

  @override
  _CustomerChangeAddressScreenState createState() =>
      _CustomerChangeAddressScreenState();
}

class _CustomerChangeAddressScreenState
    extends State<CustomerChangeAddressScreen> {
  late GoogleMapController mapController;
  late LatLng startLocation;

  double latitude = 0.0;
  double longitude = 0.0;
  String address = "";


  @override
  void initState() {
    // TODO: implement initState
    PluginGooglePlacePicker.initialize(androidApiKey: MyString.googleApiKey,iosApiKey: MyString.googleApiKey);

    latitude = widget.customerAddressModel.latitude;
    longitude = widget.customerAddressModel.longitude;
    address = widget.customerAddressModel.address;
    startLocation = LatLng(latitude, longitude);
    // getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                color: MyColor.themeBlue,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      InkWell(
                        onTap: (){
                       Navigator.pop(context);
                      },
                        child: Icon(Icons.arrow_back_ios, color: Colors.white,),),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            address,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: MyDimens.textSize14,
                                color: Colors.white,
                                fontFamily: 'montserrat_medium',
                                ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() async {
                            Place place = await MyPlacePicker.showPlacePicker();
                            // address = place.address!;
                            latitude = place.latitude;
                            longitude = place.longitude;

                            startLocation =
                            LatLng(latitude, longitude);
                            mapController.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    target: startLocation, zoom: 17)));
                          });
                        },
                        child: Icon(
                          Icons.edit_location_outlined,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GoogleMap(
                    zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                      target: startLocation,
                      zoom: 16.0,
                    ),
                    mapType: MapType.normal,
                    onMapCreated: (controller) {
                      setState(() {
                        mapController = controller;
                      });
                    },
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                       Factory<OneSequenceGestureRecognizer>(
                        () =>  EagerGestureRecognizer(),
                      ),
                    },
                    onCameraMove: (position) {
                      setState(() {
                        latitude = position.target.latitude;
                        longitude = position.target.longitude;
                        startLocation = LatLng(latitude, longitude);
                      });
                      log("CHANGE " + latitude.toString() + " : " + longitude.toString()); //ithe bgh update vala print kel me
                    },
                    onCameraIdle: () {
                      getAddress();
                    },
                  ),
                  Image(
                    image: mapPinIc
                  ),

                  Positioned(
                    bottom: 30.0,
                    left: 20.0,
                    right: 20.0,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 22.0),
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context, startLocation);
                            },
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),),
                              elevation: 5),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text("Change Address",
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
          ],
        ),
      ),
    );
  }

  ///*
  ///
  ///
/*
  void getAddress() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude,longitude);

    Placemark place = placemarks[0];
    String currentAddress = " ${place.subLocality}," //Pimple Gurav,
        "${place.locality}," //Pimpri-Chinchwad,
        "${place.postalCode}"; //411061

    log("Change_Address_screen : " + currentAddress);
    setState(() {
      address = currentAddress;
    });
  }
*/


  ///*
  ///
  /// Enable geocoding api from google developer console
  void getAddress() async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
      final url = '$_host?key=${MyString.googleApiKey}&language=en&latlng=$latitude,$longitude';
      if(latitude != null && longitude != null){
        var response = await http.get(Uri.parse(url));
        if(response.statusCode == 200) {
          print(response.body);
          Map data = jsonDecode(response.body);
          String _formattedAddress = data["results"][0]["formatted_address"];
          log("AddressResponse ==== $_formattedAddress");
          setState(() {
            address = _formattedAddress;
          });
        } else return null;
      } else return null;
    }




}


