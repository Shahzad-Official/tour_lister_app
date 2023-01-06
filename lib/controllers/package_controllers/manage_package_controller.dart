import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/services/get_events_data.dart';

class ManagePackagesController extends GetxController {
  GetEventsData eventsData = GetEventsData();
  @override
  void onInit() {
    super.onInit();
    eventsData.getData();
  }

  deletePackage(index, context) {
    eventsData.eventList.removeAt(index);
    Navigator.pop(context);
    update();
  }

  cancelLiveStatus(index) {
    eventsData.eventList[index].isLive = false;
    update();
  }
}
