import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/dummy_data.dart';

import '../../views/lister_profile/lister_account.dart';
import '../../views/main_screens/screens/create_package.dart';
import '../../views/main_screens/screens/manage_bookings.dart';
import '../../views/main_screens/screens/manage_packages.dart';

class MainPageController extends GetxController {
  int currentIndex = 0;

  List<Widget> mainScreens = [
    const CreatePackage(),
    const ManagePackages(),
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
    currentIndex = index;
    update();
  }
}
