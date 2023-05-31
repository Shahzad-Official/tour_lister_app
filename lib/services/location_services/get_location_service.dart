import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:map_address_picker/map_address_picker.dart';
import 'package:map_address_picker/models/location_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tour_lister_app/utils/app_snackbar.dart';

class GetLocationService extends GetxController {
  double? latitude, longitude;
  LocationResult? position;
  Position? currentPosition;
  bool isLoading = false;
  String? address;
  translateAddress(double latitude, double longitude) async {
    var placemarks = await placemarkFromCoordinates(latitude, longitude);
    address = "${placemarks.first.locality} ${placemarks.first.administrativeArea} , ${placemarks.first.country} ";
  }

  determinePosition(BuildContext context) async {
    try {
      isLoading = true;
      update();

      position = await showLocationPicker(
        context,
        mapType: MapType.normal,
        requiredGPS: true,
        automaticallyAnimateToCurrentLocation: true,
        initialCenter: const LatLng(-40.9006, 174.8860),
        desiredAccuracy: LocationAccuracy.best,
        title: "Pick your location",
        layersButtonEnabled: true,
        initialZoom: 16,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );

      await translateAddress(
        position!.latLng!.latitude,
        position!.latLng!.longitude,
      );
      isLoading = false;
      update();
      return position!;
    } catch (e) {
      AppSnackbar.snackBar(
        title: "error",
        message: e.toString(),
      );
    }
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
