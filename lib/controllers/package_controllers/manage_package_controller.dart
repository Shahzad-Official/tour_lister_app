import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/services/get_events_data.dart';
import 'package:tour_lister_app/services/location_services/get_location_service.dart';

class ManagePackagesController extends GetxController {
  GetLocationService locationService = GetLocationService();
  GetEventsData eventsData = GetEventsData();

  @override
  void onInit() {
    super.onInit();
    eventsData.getData();
    locationService.determinePosition();
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
