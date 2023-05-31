import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/svg_icons.dart';
import '../../../controllers/bookings_controllers/manage_bookings_controller.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_input_field.dart';
import '../../../widgets/containers/single_package_container.dart';

class CompletedBookings extends StatelessWidget {
  CompletedBookings({Key? key}) : super(key: key);
  final ManageBookingsController _bookingsController =
      Get.put(ManageBookingsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppInputField(
          hintText: "search for pakages",
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
                SinglePackageContainer(
                  eventName:
                      _bookingsController.eventsData.eventList[index].name!,
                  location:
                      _bookingsController.eventsData.eventList[index].location!,
                  picUrl: _bookingsController
                      .eventsData.eventList[index].coverImage!,
                  bottomButton: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundButton(
                        fontSize: 10,
                        text: "Duplicate",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RoundButton(
                        fontSize: 10,
                        text: "Relist Package",
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
