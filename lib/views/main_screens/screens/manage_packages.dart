import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/dummy_data.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/controllers/package_controllers/manage_package_controller.dart';
import 'package:tour_lister_app/services/location_services/get_location_service.dart';
import 'package:tour_lister_app/services/registration/login_service.dart';
import 'package:tour_lister_app/views/packages/edit_package.dart';
import 'package:tour_lister_app/widgets/app_button.dart';
import 'package:tour_lister_app/widgets/app_input_field.dart';
import 'package:tour_lister_app/widgets/app_text.dart';
import 'package:tour_lister_app/widgets/containers/single_package_container.dart';

class ManagePackages extends StatelessWidget {
  const ManagePackages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPadding.defaultPadding,
        child: GetBuilder<ManagePackagesController>(
            init: ManagePackagesController(),
            builder: (toursController) {
              return Column(
                children: [
                  AppPadding.heightSpace30,
                  AppInputField(
                    hintText: "search for tours",
                    contentPadding: const EdgeInsets.only(top: 20),
                    prefixIcon: InkWell(
                      onTap: () async {
                        await LoginService().faceBookLoginService();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: SvgPicture.string(
                          SvgIcons.search,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(
                        toursController.eventsData.eventList.length, (index) {
                      return Column(
                        children: [
                          AppPadding.heightSpace30,
                          SinglePackageContainer(
                            onCancel: () {
                              toursController.cancelLiveStatus(index);
                            },
                            onDelete: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: AppText(text: "Are You Sure?"),
                                    actions: [
                                      RoundButton(
                                        text: "Cancel",
                                        onTap: () => Navigator.pop(context),
                                      ),
                                      RoundButton(
                                        text: "Delete",
                                        onTap: () {
                                          toursController.deletePackage(
                                              index, context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onEdit: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditPackage(
                                      picUrl: toursController.eventsData
                                          .eventList[index].coverImage!,
                                      endDate: toursController
                                          .eventsData.eventList[index].endDate!,
                                      endTime: "12:00 pm",
                                      pkgLocation: toursController.eventsData
                                          .eventList[index].location!,
                                      pkgName: toursController
                                          .eventsData.eventList[index].name!,
                                      startDate: toursController.eventsData
                                          .eventList[index].startDate!,
                                      startTime: "6:00 am",
                                    ),
                                  ));
                            },
                            eventName: toursController
                                .eventsData.eventList[index].name!,
                            location: toursController
                                .eventsData.eventList[index].location!,
                            picUrl: toursController
                                .eventsData.eventList[index].coverImage!,
                            isLive: toursController
                                .eventsData.eventList[index].isLive!,
                            startDate: toursController
                                .eventsData.eventList[index].startDate!,
                            endDate: toursController
                                .eventsData.eventList[index].endDate!,
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
