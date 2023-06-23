import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetLocationService extends GetxController {
  var initialPosition = const LatLng(-33.8567844, 151.213108);
  double? latitude, longitude;
  LatLng? position;
  Position? currentPosition;
  bool isLoading = false;
  String? address;
  translateAddress(double latitude, double longitude) async {
    var placemarks = await placemarkFromCoordinates(latitude, longitude);
    address = "${placemarks.first.locality} ${placemarks.first.administrativeArea} , ${placemarks.first.country} ";
  }

  determinePosition(BuildContext context) async {
    isLoading = true;
    update();
    await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition();
    // ignore: use_build_context_synchronously
    position = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: "AIzaSyDq33g2UnBUqsMbCPvHT8imFd20IsLuel0",
          hintText: "Find a place ...",
          searchingText: "Please wait ...",
          selectText: "Select place",
          outsideOfPickAreaText: "Place not in area",
          useCurrentLocation: true,
          selectInitialPosition: true,
          usePinPointingSearch: true,
          usePlaceDetailSearch: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          initialPosition: initialPosition,
          onPlacePicked: (value) {
            address = value.formattedAddress;
            position = LatLng(value.geometry!.location.lat, value.geometry!.location.lng);
            Navigator.pop(context);
          },
        ),
      ),
    );

    isLoading = false;
    update();
  }

  storeCurrentLocationCoordinates() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    latitude = preferences.getDouble("latitude");
    longitude = preferences.getDouble("longitude");
    if (latitude == null || longitude == null) {
      await Geolocator.requestPermission();
      currentPosition = await Geolocator.getCurrentPosition();
      preferences.setDouble("latitude", currentPosition!.latitude);
      preferences.setDouble("longitude", currentPosition!.longitude);
      debugPrint(latitude.toString());
      debugPrint(longitude.toString());
    } else {
      debugPrint("Error");
    }
  }
}
