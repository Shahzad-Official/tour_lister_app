import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/models/packages/packages_model.dart';
import 'package:tour_lister_app/services/get_events_data.dart';
import 'package:tour_lister_app/services/location_services/get_location_service.dart';
import 'package:tour_lister_app/services/package_services/delete_package_service.dart';
import 'package:tour_lister_app/services/package_services/get_all_packages.dart';

class ManagePackagesController extends GetxController {
  bool isLoading = false;
  bool isSearching = false;
  GetLocationService locationService = GetLocationService();
  final DeletePackageService _deletePackage = DeletePackageService();
  final GetAllPackages _getAllPackages = GetAllPackages();
  GetEventsData eventsData = GetEventsData();
  List<String> addressList = [];
  List<PackagesModel>? newPackagesList;
  searchPackages(String query) async {
    if (newPackagesList != null) {
      newPackagesList!.clear();
      isSearching = true;
      update();
      await _getAllPackages.getAllPackages();
      var list = _getAllPackages.allPackages.where((element) {
        return element.packageName!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      newPackagesList = list;
      isSearching = false;
      update();
    }
  }

  deletePackage(String packageId) async {
    isLoading = true;
    update();
    await _deletePackage.deletePackage(packageId);
    isLoading = false;
    update();
  }

  translateAddress(List<PackagesModel> dataList) async {
    addressList.clear();

    for (PackagesModel i in dataList) {
      locationService.translateAddress(
        i.location!.latitude!,
        i.location!.longitude!,
      );
      addressList.add(locationService.address!);
    }

    update();
  }
}
