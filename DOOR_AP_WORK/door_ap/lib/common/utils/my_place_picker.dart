import 'dart:developer';

import 'package:door_ap/common/resources/my_string.dart';
import 'package:flutter/material.dart';
import 'package:google_places_picker/google_places_picker.dart';

class MyPlacePicker {

  /*static Future<LocationResult> showPlacePicker(BuildContext context) async {

    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker(MyString.googleApiKey)));

    return result;
  }*/


  static Future<Place> showPlacePicker() async{
    return await PluginGooglePlacePicker.showAutocomplete(
        mode: PlaceAutocompleteMode.MODE_OVERLAY,
        typeFilter: TypeFilter.ESTABLISHMENT);

  }

}