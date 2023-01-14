import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/utils/app_snackbar.dart';

class GetLocationService extends GetxController {
  bool isLoading = false;
  String? address;
  translateAddress() async {
    var placemarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    address =
        " ${placemarks.first.locality} ${placemarks.first.administrativeArea} , ${placemarks.first.country} ";
  }

  Position? position;
  Future<Position> determinePosition() async {
    LocationPermission permission;

    try {
      isLoading = true;
      update();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        position = await Geolocator.getCurrentPosition();

        await translateAddress();
        isLoading = false;
        update();
        return position!;
      } else {
        await Geolocator.requestPermission();
        return position!;
      }
    } catch (e) {
      AppSnackbar.snackBar(
        title: "error",
        message: e.toString(),
      );
      return position!;
    }
  }
}
