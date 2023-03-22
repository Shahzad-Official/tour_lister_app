import 'package:get/get.dart';

import '../../services/get_events_data.dart';

class ManageBookingsController extends GetxController {
  GetEventsData eventsData = GetEventsData();
  int currentIndex = 0;
  changeIndex(int index) {
    currentIndex = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    eventsData.getData();
  }
}
