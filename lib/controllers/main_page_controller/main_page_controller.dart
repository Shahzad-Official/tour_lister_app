import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/views/lister_profile/account.dart';
import 'package:tour_lister_app/views/main_screens/screens/create_tour.dart';
import 'package:tour_lister_app/views/main_screens/screens/manage_tours.dart';
import 'package:tour_lister_app/views/bookings/ongoing_bookings/ongoing_bookings.dart';

class MainPageController extends GetxController {
  int currentIndex = 0;
  List<Widget> mainScreens = [
    CreateTour(),
    ManageTours(),
    OngoingBookings(),
    Account(),
  ];
  List<String> mainScreensTitle = [
    "Create Tour",
    "All Tours",
    "Ongoing Bookings",
    "Account",
  ];
  changeScreen(int index) {
    currentIndex = index;
    update();
  }
}
