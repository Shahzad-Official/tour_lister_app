import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/dummy_data.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/controllers/package_controllers/manage_package_controller.dart';
import 'package:tour_lister_app/models/packages/packages_model.dart';
import 'package:tour_lister_app/services/package_services/get_all_packages.dart';
import 'package:tour_lister_app/services/registration/login_service.dart';
import 'package:tour_lister_app/utils/app_navigation.dart';
import 'package:tour_lister_app/utils/date_format.dart';
import 'package:tour_lister_app/views/packages/edit_package.dart';
import 'package:tour_lister_app/views/packages/single_package_page.dart';
import 'package:tour_lister_app/widgets/app_button.dart';
import 'package:tour_lister_app/widgets/app_input_field.dart';
import 'package:tour_lister_app/widgets/app_text.dart';
import 'package:tour_lister_app/widgets/containers/single_package_container.dart';

class ManagePackages extends StatefulWidget {
  const ManagePackages({Key? key}) : super(key: key);

  @override
  State<ManagePackages> createState() => _ManagePackagesState();
}

class _ManagePackagesState extends State<ManagePackages> with TickerProviderStateMixin {
  late final TabController _tabController;
  final GetAllPackages _getAllPackages = GetAllPackages();

  final LoginService loginService = LoginService();
  final ManagePackagesController _controller = Get.put(ManagePackagesController());
  bool isLoading = false;
  getAllPackages() async {
    setState(() {
      isLoading = true;
    });
    await _getAllPackages.getAllPackages();

    _controller.searchPackages(
      data: _getAllPackages.allPackages,
      islive: true,
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getAllPackages();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.defaultPadding,
      child: GetBuilder<ManagePackagesController>(
        init: ManagePackagesController(),
        builder: (controller) {
          return Column(
            children: [
              AppPadding.heightSpace30,
              AppInputField(
                onChanged: (query) async {
                  await controller.searchPackages(
                    query: query,
                    data: _getAllPackages.allPackages,
                  );
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
                    if (controller.selectedTabIndex == 0) {
                      controller.searchPackages(
                        data: _getAllPackages.allPackages,
                      );
                    } else {
                      controller.searchPackages(
                        data: _getAllPackages.allPackages,
                        islive: false,
                      );
                    }
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
              Builder(
                builder: (context) {
                  if (!isLoading) {
                    if (controller.newPackagesList.isEmpty) {
                      return Center(
                        child: AppText(text: "No Package Available"),
                      );
                    } else {
                      return Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: List.generate(
                            2,
                            (inde) {
                              return PackageTab(
                                isLive: controller.isLive,
                                newPackagesList: controller.newPackagesList,
                              );
                            },
                          ),
                        ),
                      );
                      // return Column(
                      //   children: List.generate(controller.newPackagesList.length, (index) {
                      //     return Column(
                      //       children: [
                      //         AppPadding.heightSpace30,
                      //         InkWell(
                      //           onTap: () {
                      //             Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) => PackageSinglePage(
                      //                   packageData: controller.newPackagesList[index],
                      //                 ),
                      //               ),
                      //             );
                      //           },
                      //           child: SinglePackageContainer(
                      //             onCancel: () {},
                      //             onDelete: () {
                      //               showDialog(
                      //                 context: context,
                      //                 builder: (context) {
                      //                   return AlertDialog(
                      //                     actionsAlignment: MainAxisAlignment.spaceBetween,
                      //                     title: AppText(text: "Are You Sure?"),
                      //                     actions: [
                      //                       RoundButton(
                      //                         width: 150,
                      //                         text: "Cancel",
                      //                         onTap: () async {
                      //                           Get.back();
                      //                         },
                      //                       ),
                      //                       AppPadding.heightSpace20,
                      //                       GetBuilder<ManagePackagesController>(
                      //                         init: ManagePackagesController(),
                      //                         builder: (_) {
                      //                           return RoundButton(
                      //                             isLoading: _.isLoading,
                      //                             width: 150,
                      //                             text: "Delete",
                      //                             onTap: _.isLoading
                      //                                 ? null
                      //                                 : () async {
                      //                                     await _.deletePackage(
                      //                                       controller.newPackagesList[index].packageId!,
                      //                                     );

                      //                                     Get.back();
                      //                                   },
                      //                           );
                      //                         },
                      //                       ),
                      //                     ],
                      //                   );
                      //                 },
                      //               );
                      //             },
                      //             onEdit: () {
                      //               Navigate.to(
                      //                 context,
                      //                 EditPackage(
                      //                   isLive: controller.selectedTabIndex == 0 ? true : false,
                      //                   packageData: controller.newPackagesList[index],
                      //                   picUrl: controller.newPackagesList[index].thumbnailUrl!,
                      //                   endDate: controller.newPackagesList[index].endDate!,
                      //                   endTime: controller.newPackagesList[index].endTime!,
                      //                   pkgLocation: controller.newPackagesList[index].location!.address!,
                      //                   pkgName: controller.newPackagesList[index].packageName!,
                      //                   startDate: controller.newPackagesList[index].startDate!,
                      //                   startTime: controller.newPackagesList[index].startTime!,
                      //                 ),
                      //               );
                      //             },
                      //             eventName: controller.newPackagesList[index].packageName!,
                      //             location: controller.newPackagesList[index].location!.address!,
                      //             picUrl: controller.newPackagesList[index].thumbnailUrl ?? DummyData.profilePic,
                      //             isLive: controller.newPackagesList[index].isLive!,
                      //             startDate: CustomDateFormat.dateFormat(controller.newPackagesList[index].startDate!),
                      //             endDate: CustomDateFormat.dateFormat(
                      //               controller.newPackagesList[index].endDate!,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     );
                      //   }),
                      // );
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
    );
  }
}

class PackageTab extends StatelessWidget {
  final List<PackagesModel> newPackagesList;
  final bool isLive;
  const PackageTab({
    super.key,
    required this.newPackagesList,
    this.isLive = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: newPackagesList.length,
      itemBuilder: (context, ind) {
        return Column(
          children: [
            AppPadding.heightSpace30,
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PackageSinglePage(
                      packageData: newPackagesList[ind],
                    ),
                  ),
                );
              },
              child: SinglePackageContainer(
                onCancel: () {},
                onDelete: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actionsAlignment: MainAxisAlignment.spaceBetween,
                        title: AppText(text: "Are You Sure?"),
                        actions: [
                          RoundButton(
                            width: 150,
                            text: "Cancel",
                            onTap: () async {
                              Get.back();
                            },
                          ),
                          AppPadding.heightSpace20,
                          GetBuilder<ManagePackagesController>(
                            init: ManagePackagesController(),
                            builder: (_) {
                              return RoundButton(
                                isLoading: _.isLoading,
                                width: 150,
                                text: "Delete",
                                onTap: _.isLoading
                                    ? null
                                    : () async {
                                        await _.deletePackage(
                                          newPackagesList[ind].packageId!,
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
                      isLive: isLive,
                      packageData: newPackagesList[ind],
                      picUrl: newPackagesList[ind].thumbnailUrl!,
                      endDate: newPackagesList[ind].endDate!,
                      endTime: newPackagesList[ind].endTime!,
                      pkgLocation: newPackagesList[ind].location!.address!,
                      pkgName: newPackagesList[ind].packageName!,
                      startDate: newPackagesList[ind].startDate!,
                      startTime: newPackagesList[ind].startTime!,
                    ),
                  );
                },
                eventName: newPackagesList[ind].packageName!,
                location: newPackagesList[ind].location!.address!,
                picUrl: newPackagesList[ind].thumbnailUrl ?? DummyData.profilePic,
                isLive: newPackagesList[ind].isLive!,
                startDate: CustomDateFormat.dateFormat(newPackagesList[ind].startDate!),
                endDate: CustomDateFormat.dateFormat(
                  newPackagesList[ind].endDate!,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
