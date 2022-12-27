import 'package:get/get.dart';
import 'package:tour_lister_app/services/get_events_data.dart';

class ManageToursController extends GetxController {
  GetEventsData eventsData = GetEventsData();
  @override
  void onInit() {
    super.onInit();
    eventsData.getData();
  }
}
