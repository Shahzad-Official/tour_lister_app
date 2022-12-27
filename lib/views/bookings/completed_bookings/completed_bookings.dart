import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/dummy_data.dart';
import 'package:tour_lister_app/services/get_events_data.dart';
import 'package:tour_lister_app/widgets/app_cached_image.dart';

import '../../../constants/app_paddings.dart';
import '../../../constants/svg_icons.dart';
import '../../../controllers/main_screens_controllers/manage_bookings_controller.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_input_field.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/containers/single_tour_container.dart';

class CompletedBookings extends StatelessWidget {
  CompletedBookings({Key? key}) : super(key: key);
  final ManageBookingsController _bookingsController =
      Get.put(ManageBookingsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppInputField(
          hintText: "search for tours",
          contentPadding: const EdgeInsets.only(top: 20),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: SvgPicture.string(
              SvgIcons.search,
            ),
          ),
        ),
        Column(
          children: List.generate(
              _bookingsController.eventsData.eventList.length, (index) {
            return Column(
              children: [
                AppPadding.heightSpace30,
                SingleTourContainer(
                  eventName:
                      _bookingsController.eventsData.eventList[index].name!,
                  location:
                      _bookingsController.eventsData.eventList[index].location!,
                  picUrl: _bookingsController
                      .eventsData.eventList[index].coverImage!,
                  bottomButton: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundButton(
                        text: "Duplicate",
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      RoundButton(
                        text: "Relist Tour",
                      ),
                    ],
                  ),
                  startDate: "12 Mar",
                  endDate: "2 May",
                ),
              ],
            );
          }),
        ),
        AppPadding.heightSpace20,
      ],
    );
  }
}
