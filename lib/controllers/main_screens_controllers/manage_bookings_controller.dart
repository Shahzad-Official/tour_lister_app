import 'package:get/get.dart';

class ManageBookingsController extends GetxController {
  int currentIndex = 0;
  changeIndex(int index) {
    currentIndex = index;
    update();
  }
}
