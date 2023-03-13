import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/controllers/package_controllers/create_package_controller.dart';

import '../../views/lister_profile/lister_account.dart';
import '../../views/main_screens/screens/create_package.dart';
import '../../views/main_screens/screens/manage_bookings.dart';
import '../../views/main_screens/screens/manage_packages.dart';

class MainPageController extends GetxController {
  int currentIndex = 0;
  final CreatePackageController _controller =
      Get.put(CreatePackageController());

  List<Widget> mainScreens = [
    CreatePackage(),
    ManagePackages(),
    const ManageBookings(),
    ListerAccount(),
  ];

  List<String> mainScreensTitle = [
    "Create Package",
    "All Packages",
    "Ongoing Bookings",
    "Account",
  ];
  changeScreen(int index) {
    if (!_controller.isLoading) {
      currentIndex = index;
      update();
    } else {}
  }
}
