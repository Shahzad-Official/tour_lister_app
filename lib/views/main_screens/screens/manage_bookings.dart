import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/controllers/main_screens_controllers/manage_bookings_controller.dart';
import 'package:tour_lister_app/views/bookings/ongoing_bookings/ongoing_bookings.dart';

import 'package:tour_lister_app/widgets/app_button.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/dummy_data.dart';
import '../../../widgets/app_cached_image.dart';
import '../../../widgets/app_text.dart';
import '../../bookings/completed_bookings/completed_bookings.dart';

class ManageBookings extends StatelessWidget {
  const ManageBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageBookingsController>(
        init: ManageBookingsController(),
        builder: (controller) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(170),
              child: Container(
                color: AppColors.backgroundcolor,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: controller.currentIndex == 0
                              ? "Ongoing \nBookings"
                              : "Completed \nBookings",
                          fontWeight: FontWeight.w600,
                          fontSize: 23,
                          textcolor: Colors.black,
                        ),
                        AppCircularCachedImage(
                          picUrl: DummyData.profilePic,
                        ),
                      ],
                    ),
                    AppPadding.heightSpace30,
                    AppPadding.heightSpace10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RoundButton(
                          onTap: () {
                            controller.changeIndex(0);
                          },
                          text: "Ongoing Bookings",
                          buttonColor: controller.currentIndex == 0
                              ? AppColors.primarycolor
                              : AppColors.backgroundcolor,
                          textColor: controller.currentIndex == 0
                              ? AppColors.backgroundcolor
                              : AppColors.primarycolor,
                          fontSize: 15,
                        ),
                        RoundButton(
                          onTap: () {
                            controller.changeIndex(1);
                          },
                          text: "Completed Bookings",
                          buttonColor: controller.currentIndex == 1
                              ? AppColors.primarycolor
                              : AppColors.backgroundcolor,
                          textColor: controller.currentIndex == 1
                              ? AppColors.backgroundcolor
                              : AppColors.primarycolor,
                          fontSize: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: AppPadding.defaultPadding,
                child: Column(
                  children: [
                    AppPadding.heightSpace10,
                    controller.currentIndex == 0
                        ? OngoingBookings()
                        : CompletedBookings(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
