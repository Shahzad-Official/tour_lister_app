import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/controllers/main_screens_controllers/manage_tours_controller.dart';
import 'package:tour_lister_app/widgets/app_input_field.dart';
import 'package:tour_lister_app/widgets/containers/single_tour_container.dart';

class ManageTours extends StatelessWidget {
  ManageTours({Key? key}) : super(key: key);
  final ManageToursController toursController =
      Get.put(ManageToursController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPadding.defaultPadding,
        child: Column(
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
                  toursController.eventsData.eventList.length, (index) {
                return Column(
                  children: [
                    AppPadding.heightSpace30,
                    SingleTourContainer(
                      eventName:
                          toursController.eventsData.eventList[index].name!,
                      location:
                          toursController.eventsData.eventList[index].location!,
                      picUrl: toursController
                          .eventsData.eventList[index].coverImage!,
                      isLive:
                          toursController.eventsData.eventList[index].isLive!,
                      startDate: toursController
                          .eventsData.eventList[index].startPrice!,
                      endDate:
                          toursController.eventsData.eventList[index].endPrice!,
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
