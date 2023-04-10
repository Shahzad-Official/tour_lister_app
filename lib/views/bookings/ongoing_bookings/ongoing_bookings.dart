import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/controllers/bookings_controllers/manage_bookings_controller.dart';
import 'package:tour_lister_app/models/booking_model.dart';
import 'package:tour_lister_app/models/packages/packages_model.dart';
import 'package:tour_lister_app/services/package_services/get_all_packages.dart';
import 'package:tour_lister_app/utils/date_format.dart';
import 'package:tour_lister_app/views/users_in_package/users_in_package.dart';
import 'package:tour_lister_app/widgets/app_button.dart';
import 'package:tour_lister_app/widgets/rating_bar/package_rating_bar.dart';

import '../../../constants/app_paddings.dart';
import '../../../constants/svg_icons.dart';
import '../../../widgets/app_input_field.dart';
import '../../../widgets/containers/single_package_container.dart';

class OngoingBookings extends StatelessWidget {
  final List<BookingModel> allBookings;
  OngoingBookings({
    Key? key,
    required this.allBookings,
  }) : super(key: key);
  final GetAllPackages getPackageData = GetAllPackages();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageBookingsController>(
        init: ManageBookingsController(),
        builder: (_) {
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
                children: List.generate(allBookings.length, (index) {
                  return Column(
                    children: [
                      AppPadding.heightSpace30,
                      FutureBuilder<PackagesModel>(
                          future: getPackageData
                              .getPackageData(allBookings[index].tourId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return SinglePackageContainer(
                                eventName: allBookings[index].eventName!,
                                location: snapshot.data!.location!.address!,
                                picUrl: snapshot.data!.thumbnailUrl,
                                ratingBar: const PackageRatingBar(),
                                bottomButton: Align(
                                  alignment: Alignment.bottomRight,
                                  child: RoundButton(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UsersInPackage(
                                            bookingDetails: allBookings[index],
                                          ),
                                        ),
                                      );
                                    },
                                    text: "view",
                                  ),
                                ),
                                startDate: CustomDateFormat.formatedDate(
                                  formatPattern: "dd MMM",
                                  date: snapshot.data!.startDate.toString(),
                                ),
                                endDate: CustomDateFormat.formatedDate(
                                  formatPattern: "dd MMM",
                                  date: snapshot.data!.endDate.toString(),
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ],
                  );
                }),
              ),
            ],
          );
        });
  }
}
