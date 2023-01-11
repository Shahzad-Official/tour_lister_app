import 'package:get/get.dart';
import 'package:tour_lister_app/controllers/main_page_controller/main_page_controller.dart';

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
