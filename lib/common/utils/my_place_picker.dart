
import 'package:google_places_picker/google_places_picker.dart';

class MyPlacePicker {


  ///
  ///
  /// enable Places Api From Google Developer console
  /// use to open google place picker to search for address
  ///
  static Future<Place> showPlacePicker() async{
    return await PluginGooglePlacePicker.showAutocomplete(
        mode: PlaceAutocompleteMode.MODE_OVERLAY,
        typeFilter: TypeFilter.ESTABLISHMENT);
  }
}