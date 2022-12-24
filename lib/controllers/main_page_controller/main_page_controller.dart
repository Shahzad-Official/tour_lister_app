import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/views/main_screens/screens/create_tour.dart';
import 'package:tour_lister_app/views/main_screens/screens/manage_tours.dart';

class MainPageController extends GetxController {
  int currentIndex = 0;
  List<Widget> mainScreens = [
    CreateTour(),
    ManageTours(),
    Text("data"),
    Text("data"),
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
