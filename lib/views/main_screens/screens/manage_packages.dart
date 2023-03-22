import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/controllers/package_controllers/manage_package_controller.dart';
import 'package:tour_lister_app/models/packages/packages_model.dart';
import 'package:tour_lister_app/services/package_services/get_all_packages.dart';
import 'package:tour_lister_app/services/registration/login_service.dart';
import 'package:tour_lister_app/utils/app_navigation.dart';
import 'package:tour_lister_app/utils/date_format.dart';
import 'package:tour_lister_app/views/packages/edit_package.dart';
import 'package:tour_lister_app/widgets/app_button.dart';
import 'package:tour_lister_app/widgets/app_input_field.dart';
import 'package:tour_lister_app/widgets/app_text.dart';
import 'package:tour_lister_app/widgets/containers/single_package_container.dart';

class ManagePackages extends StatefulWidget {
  const ManagePackages({Key? key}) : super(key: key);

  @override
  State<ManagePackages> createState() => _ManagePackagesState();
}

class _ManagePackagesState extends State<ManagePackages>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final GetAllPackages _getAllPackages = GetAllPackages();

  final LoginService loginService = LoginService();
  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPadding.defaultPadding,
        child: GetBuilder<ManagePackagesController>(
          init: ManagePackagesController(),
          builder: (controller) {
            return Column(
              children: [
                AppPadding.heightSpace30,
                AppInputField(
                  onChanged: (query) async {
                    await controller.searchPackages(query);
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
                AppPadding.heightSpace30,
                SizedBox(
                  height: 40,
                  child: TabBar(
                    indicatorWeight: 2.5,
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _tabController,
                    onTap: (value) {
                      controller.changeCondition(value);
                    },
                    tabs: [
                      AppText(
                        text: "Live",
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      AppText(
                        text: "Draft",
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                AppPadding.heightSpace20,
                controller.isSearching
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : FutureBuilder<List<PackagesModel>>(
                        future: _getAllPackages.getAllPackages(
                          isLive: controller.isLive,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.isEmpty) {
                              return Center(
                                child: AppText(text: "No Package Available"),
                              );
                            } else {
                              return Column(
                                children: List.generate(
                                    controller.newPackagesList.isNotEmpty
                                        ? controller.newPackagesList.length
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
                                                        Navigate.back(context),
                                                  ),
                                                  AppPadding.heightSpace20,
                                                  GetBuilder<
                                                      ManagePackagesController>(
                                                    init:
                                                        ManagePackagesController(),
                                                    builder: (_) {
                                                      return RoundButton(
                                                        isLoading: _.isLoading,
                                                        width: 150,
                                                        text: "Delete",
                                                        onTap: _.isLoading
                                                            ? null
                                                            : () async {
                                                                await _
                                                                    .deletePackage(
                                                                  controller
                                                                          .newPackagesList
                                                                          .isNotEmpty
                                                                      ? controller
                                                                          .newPackagesList[
                                                                              index]
                                                                          .packageId!
                                                                      : snapshot
                                                                          .data![
                                                                              index]
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
                                              packageData: controller
                                                      .newPackagesList
                                                      .isNotEmpty
                                                  ? controller
                                                      .newPackagesList[index]
                                                  : snapshot.data![index],
                                              picUrl: controller.newPackagesList
                                                      .isNotEmpty
                                                  ? controller
                                                      .newPackagesList[index]
                                                      .thumbnailUrl!
                                                  : snapshot.data![index]
                                                      .thumbnailUrl!,
                                              endDate: controller
                                                      .newPackagesList
                                                      .isNotEmpty
                                                  ? controller
                                                      .newPackagesList[index]
                                                      .endDate!
                                                  : snapshot
                                                      .data![index].endDate!,
                                              endTime: controller
                                                      .newPackagesList
                                                      .isNotEmpty
                                                  ? controller
                                                      .newPackagesList[index]
                                                      .endTime!
                                                  : snapshot
                                                      .data![index].endTime!,
                                              pkgLocation: controller
                                                      .newPackagesList
                                                      .isNotEmpty
                                                  ? controller
                                                      .newPackagesList[index]
                                                      .location!
                                                      .address!
                                                  : snapshot.data![index]
                                                      .location!.address!,
                                              pkgName: controller
                                                      .newPackagesList
                                                      .isNotEmpty
                                                  ? controller
                                                      .newPackagesList[index]
                                                      .packageName!
                                                  : snapshot.data![index]
                                                      .packageName!,
                                              startDate: controller
                                                      .newPackagesList
                                                      .isNotEmpty
                                                  ? controller
                                                      .newPackagesList[index]
                                                      .startDate!
                                                  : snapshot
                                                      .data![index].startDate!,
                                              startTime: controller
                                                      .newPackagesList
                                                      .isNotEmpty
                                                  ? controller
                                                      .newPackagesList[index]
                                                      .startTime!
                                                  : snapshot
                                                      .data![index].startTime!,
                                            ),
                                          );
                                        },
                                        eventName: controller
                                                .newPackagesList.isNotEmpty
                                            ? controller.newPackagesList[index]
                                                .packageName!
                                            : snapshot
                                                .data![index].packageName!,
                                        location: controller
                                                .newPackagesList.isNotEmpty
                                            ? controller.newPackagesList[index]
                                                .location!.address!
                                            : snapshot.data![index].location!
                                                .address!,
                                        picUrl: controller
                                                .newPackagesList.isNotEmpty
                                            ? controller.newPackagesList[index]
                                                .thumbnailUrl!
                                            : snapshot
                                                .data![index].thumbnailUrl!,
                                        isLive: controller
                                                .newPackagesList.isNotEmpty
                                            ? controller
                                                .newPackagesList[index].isLive!
                                            : snapshot.data![index].isLive!,
                                        startDate: CustomDateFormat.dateFormat(
                                            controller
                                                    .newPackagesList.isNotEmpty
                                                ? controller
                                                    .newPackagesList[index]
                                                    .startDate!
                                                : snapshot
                                                    .data![index].startDate!),
                                        endDate: CustomDateFormat.dateFormat(
                                          controller.newPackagesList.isNotEmpty
                                              ? controller
                                                  .newPackagesList[index]
                                                  .endDate!
                                              : snapshot.data![index].endDate!,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              );
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
