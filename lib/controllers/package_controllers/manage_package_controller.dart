import 'package:get/get.dart';
import 'package:tour_lister_app/models/packages/packages_model.dart';
import 'package:tour_lister_app/services/get_events_data.dart';
import 'package:tour_lister_app/services/location_services/get_location_service.dart';
import 'package:tour_lister_app/services/package_services/delete_package_service.dart';

class ManagePackagesController extends GetxController {
  bool isLoading = false;

  bool isLive = true;
  GetLocationService locationService = GetLocationService();
  final DeletePackageService _deletePackage = DeletePackageService();
  GetEventsData eventsData = GetEventsData();
  List<String> addressList = [];
  List<PackagesModel> packageList = [];
  List<PackagesModel> newPackagesList = [];
  int selectedTabIndex = 0;
  changeCondition(int index) {
    selectedTabIndex = index;
    if (index == 0) {
      isLive = true;
      update();
    } else {
      isLive = false;
      update();
    }
  }

  searchPackages({
    required List<PackagesModel> data,
    bool islive = true,
    String query = "",
  }) async {
    newPackagesList.clear();

    newPackagesList = data.where((element) {
      return element.isLive == isLive &&
          element.packageName!
              .toLowerCase()
              .contains(query.trim().toLowerCase());
    }).toList();
    update();
  }

  deletePackage(String packageId) async {
    isLoading = true;
    update();
    await _deletePackage.deletePackage(packageId);
    isLoading = false;
    update();
  }
}
