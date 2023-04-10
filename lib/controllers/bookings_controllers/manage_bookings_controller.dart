import 'package:get/get.dart';

import '../../models/booking_model.dart';
import '../../services/get_events_data.dart';

class ManageBookingsController extends GetxController {
  GetEventsData eventsData = GetEventsData();
  int currentIndex = 0;
  changeIndex(int index) {
    currentIndex = index;
    update();
  }

  List<BookingModel> allBookings = [];

  searchBooking({
    String query = "",
    required List<BookingModel> allBooking,
  }) {
    allBookings = allBooking
        .where(
          (element) => element.eventName!.toLowerCase().contains(
                query.trim().toLowerCase(),
              ),
        )
        .toList();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    eventsData.getData();
  }
}
