import 'package:tour_lister_app/constants/dummy_data.dart';
import 'package:tour_lister_app/models/packages/packages_model.dart';

class GetEventsData {
  List<EventModel> eventList = [];
  getData() {
    eventList.clear();
    for (var i in DummyData.eventsData) {
      eventList.add(EventModel.fromJson(i));
    }
    return eventList;
  }
}
