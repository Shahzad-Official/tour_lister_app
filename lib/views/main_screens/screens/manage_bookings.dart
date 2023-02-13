import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/controllers/bookings_controllers/manage_bookings_controller.dart';
import 'package:tour_lister_app/models/lister_profile/profile_model.dart';
import 'package:tour_lister_app/services/get_user_data.dart';
import 'package:tour_lister_app/views/bookings/ongoing_bookings/ongoing_bookings.dart';

import 'package:tour_lister_app/widgets/app_button.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/dummy_data.dart';
import '../../../services/package_services/get_all_packages.dart';
import '../../../widgets/app_cached_image.dart';
import '../../../widgets/app_text.dart';
import '../../bookings/completed_bookings/completed_bookings.dart';

class ManageBookings extends StatefulWidget {
  const ManageBookings({
    Key? key,
  }) : super(key: key);

  @override
  State<ManageBookings> createState() => _ManageBookingsState();
}

class _ManageBookingsState extends State<ManageBookings> {
  TextEditingController textEditingController = TextEditingController();
  GetAllPackages getAllPackages = GetAllPackages();
  final GetUserData _userData = GetUserData();
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
                        FutureBuilder<ProfileModel>(
                            future: _userData.getUserData(
                                FirebaseAuth.instance.currentUser!.uid),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              if (snapshot.hasData) {
                                return AppCircularCachedImage(
                                  picUrl: snapshot.data!.profile!,
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primarycolor,
                                  ),
                                );
                              }
                            }),
                      ],
                    ),
                    AppPadding.heightSpace30,
                    AppPadding.heightSpace10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoundButton(
                          width: MediaQuery.of(context).size.width * 0.4,
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
                          fontSize: 13,
                        ),
                        RoundButton(
                          width: MediaQuery.of(context).size.width * 0.42,
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
                          fontSize: 13,
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
