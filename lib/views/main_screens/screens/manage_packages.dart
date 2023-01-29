import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/controllers/package_controllers/manage_package_controller.dart';
import 'package:tour_lister_app/models/packages/packages_model.dart';
import 'package:tour_lister_app/services/package_services/get_all_packages.dart';
import 'package:tour_lister_app/utils/app_navigation.dart';
import 'package:tour_lister_app/views/packages/edit_package.dart';
import 'package:tour_lister_app/widgets/app_button.dart';
import 'package:tour_lister_app/widgets/app_input_field.dart';
import 'package:tour_lister_app/widgets/app_text.dart';
import 'package:tour_lister_app/widgets/containers/single_package_container.dart';

class ManagePackages extends StatelessWidget {
  ManagePackages({Key? key}) : super(key: key);
  final GetAllPackages _getAllPackages = GetAllPackages();

  final ManagePackagesController _packagesController = Get.put(
    ManagePackagesController(),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPadding.defaultPadding,
        child: Column(
          children: [
            AppPadding.heightSpace30,
            AppInputField(
              onChanged: (query) async {
                await _packagesController.searchPackages(query);
              },
              hintText: "search for tours",
              contentPadding: const EdgeInsets.only(top: 20),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: SvgPicture.string(
                  SvgIcons.search,
                ),
              ),
            ),
            FutureBuilder<List<PackagesModel>>(
              future: _getAllPackages.getAllPackages(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: AppText(text: "No Package Available"),
                    );
                  } else {
                    return GetBuilder<ManagePackagesController>(
                        init: ManagePackagesController(),
                        builder: (packageController) {
                          return packageController.isSearching
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Column(
                                  children: List.generate(
                                      packageController.newPackagesList != null
                                          ? packageController
                                              .newPackagesList!.length
                                          : snapshot.data!.length, (index) {
                                    return Column(
                                      children: [
                                        AppPadding.heightSpace30,
                                        SinglePackageContainer(
                                          onCancel: () {},
                                          onDelete: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  actionsAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  title: AppText(
                                                      text: "Are You Sure?"),
                                                  actions: [
                                                    RoundButton(
                                                      width: 150,
                                                      text: "Cancel",
                                                      onTap: () =>
                                                          Navigate.back(
                                                              context),
                                                    ),
                                                    AppPadding.heightSpace20,
                                                    GetBuilder<
                                                        ManagePackagesController>(
                                                      init:
                                                          ManagePackagesController(),
                                                      builder: (_) {
                                                        return RoundButton(
                                                          isLoading:
                                                              _.isLoading,
                                                          width: 150,
                                                          text: "Delete",
                                                          onTap: _.isLoading
                                                              ? null
                                                              : () async {
                                                                  await _
                                                                      .deletePackage(
                                                                    packageController.newPackagesList !=
                                                                            null
                                                                        ? packageController
                                                                            .newPackagesList![
                                                                                index]
                                                                            .packageId!
                                                                        : snapshot
                                                                            .data![index]
                                                                            .packageId!,
                                                                  );

                                                                  Get.back();
                                                                },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          onEdit: () {
                                            Navigate.to(
                                              context,
                                              EditPackage(
                                                picUrl: packageController
                                                            .newPackagesList !=
                                                        null
                                                    ? packageController
                                                        .newPackagesList![index]
                                                        .thumbnailUrl!
                                                    : snapshot.data![index]
                                                        .thumbnailUrl!,
                                                endDate: snapshot
                                                    .data![index].endDate!,
                                                endTime: snapshot
                                                    .data![index].endTime!,
                                                pkgLocation: snapshot
                                                    .data![index]
                                                    .location!
                                                    .address!,
                                                pkgName: snapshot
                                                    .data![index].packageName!,
                                                startDate: snapshot
                                                    .data![index].startDate!,
                                                startTime: snapshot
                                                    .data![index].startTime!,
                                              ),
                                            );
                                          },
                                          eventName: snapshot
                                              .data![index].packageName!,
                                          location: snapshot
                                              .data![index].location!.address!,
                                          picUrl: snapshot
                                              .data![index].thumbnailUrl!,
                                          isLive: snapshot.data![index].isLive!,
                                          startDate:
                                              snapshot.data![index].startDate!,
                                          endDate:
                                              snapshot.data![index].endDate!,
                                        ),
                                      ],
                                    );
                                  }),
                                );
                        });
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
