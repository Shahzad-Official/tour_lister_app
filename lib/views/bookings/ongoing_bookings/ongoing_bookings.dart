import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/controllers/bookings_controllers/manage_bookings_controller.dart';
import 'package:tour_lister_app/views/users_in_package/users_in_package.dart';
import 'package:tour_lister_app/widgets/app_button.dart';
import 'package:tour_lister_app/widgets/rating_bar/package_rating_bar.dart';

import '../../../constants/app_paddings.dart';
import '../../../constants/svg_icons.dart';
import '../../../widgets/app_input_field.dart';
import '../../../widgets/containers/single_package_container.dart';

class OngoingBookings extends StatelessWidget {
  final ManageBookingsController _bookingsController =
      Get.put(ManageBookingsController());
  OngoingBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppPadding.heightSpace30,
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
                SinglePackageContainer(
                  eventName:
                      _bookingsController.eventsData.eventList[index].name!,
                  location:
                      _bookingsController.eventsData.eventList[index].location!,
                  picUrl: _bookingsController
                      .eventsData.eventList[index].coverImage!,
                  ratingBar: const PackageRatingBar(),
                  bottomButton: Align(
                    alignment: Alignment.bottomRight,
                    child: RoundButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UsersInPackage(
                              tourName: _bookingsController
                                  .eventsData.eventList[index].name!,
                              users: _bookingsController
                                  .eventsData.eventList[index].users!,
                            ),
                          ),
                        );
                      },
                      text: "view",
                    ),
                  ),
                  startDate: "12 Mar",
                  endDate: "2 May",
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
