import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/controllers/package_controllers/edit_package_controller.dart';
import 'package:tour_lister_app/models/packages/packages_model.dart';
import 'package:tour_lister_app/utils/date_format.dart';
import 'package:tour_lister_app/views/main_screens/main_page.dart';
import 'package:tour_lister_app/widgets/app_button.dart';
import 'package:tour_lister_app/widgets/app_cached_image.dart';

import '../../constants/svg_icons.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/app_text.dart';

class EditPackage extends StatefulWidget {
  final String picUrl,
      pkgName,
      pkgLocation,
      startDate,
      endDate,
      startTime,
      endTime;
  final PackagesModel packageData;
  const EditPackage({
    Key? key,
    required this.picUrl,
    required this.endDate,
    required this.endTime,
    required this.pkgLocation,
    required this.pkgName,
    required this.startDate,
    required this.startTime,
    required this.packageData,
  }) : super(key: key);

  @override
  State<EditPackage> createState() => _EditPackageState();
}

class _EditPackageState extends State<EditPackage> {
  EditPackageController packageController = Get.put(EditPackageController());
  initializeData() {
    if (widget.packageData.packageId != null) {
      packageController.startDate = DateTime.parse(widget.startDate);
      packageController.endDate = DateTime.parse(widget.endDate);
      packageController.startDateController.text =
          CustomDateFormat.dateFormat(widget.startDate);
      packageController.endDateController.text =
          CustomDateFormat.dateFormat(widget.endDate);
      packageController.startTimeController.text = widget.startTime;
      packageController.endTimeController.text = widget.endTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.backgroundcolor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: AppColors.backgroundcolor,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: SvgPicture.string(
                  SvgIcons.backArrow,
                ),
              ),
            ),
            title: AppText(
              text: "Edit Package",
              fontWeight: FontWeight.w600,
              fontSize: 23,
              textcolor: Colors.black,
            ),
          ),
          body: Padding(
            padding: AppPadding.defaultPadding,
            child: GetBuilder<EditPackageController>(
              init: EditPackageController(),
              builder: (_) {
                return Column(
                  children: [
                    SizedBox(
                      height: 210,
                      width: double.infinity,
                      child: AppCachedImage(
                        picUrl: widget.picUrl,
                      ),
                    ),
                    AppPadding.heightSpace15,
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: AppText(
                        text: "Package Name",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        textcolor: AppColors.headTextColor,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: AppText(
                          text: widget.pkgName,
                          textcolor: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: AppText(
                        text: "Package Location",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        textcolor: AppColors.headTextColor,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: AppText(
                          text: widget.pkgLocation,
                          textcolor: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    AppPadding.heightSpace30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppInputField(
                          controller: _.startDateController,
                          onTap: () {
                            _.selectStartDate(context);
                          },
                          width: MediaQuery.of(context).size.width * 0.415,
                          enabled: false,
                          hintText: "Start Date",
                          contentPadding: const EdgeInsets.only(
                            top: 20,
                            left: 15,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 20,
                            ),
                            child: SvgPicture.string(
                              SvgIcons.calendarFilled,
                              width: 30,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        AppInputField(
                          controller: _.endDateController,
                          onTap: () {
                            _.selectEndDate(context);
                          },
                          width: MediaQuery.of(context).size.width * 0.415,
                          enabled: false,
                          hintText: "End Date",
                          contentPadding: const EdgeInsets.only(
                            top: 20,
                            left: 15,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 20,
                            ),
                            child: SvgPicture.string(
                              SvgIcons.calendarFilled,
                              width: 30,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppPadding.heightSpace30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppInputField(
                          controller: _.startTimeController,
                          onTap: () {
                            _.selectStartTime(context);
                          },
                          width: MediaQuery.of(context).size.width * 0.415,
                          enabled: false,
                          hintText: "Start Time",
                          contentPadding: const EdgeInsets.only(
                            top: 20,
                            left: 15,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 20,
                            ),
                            child: SvgPicture.string(
                              SvgIcons.clock,
                              width: 30,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        AppInputField(
                          controller: _.endTimeController,
                          onTap: () {
                            _.selectEndTime(context);
                          },
                          width: MediaQuery.of(context).size.width * 0.415,
                          enabled: false,
                          hintText: "End Time",
                          contentPadding: const EdgeInsets.only(
                            top: 20,
                            left: 15,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 20,
                            ),
                            child: SvgPicture.string(
                              SvgIcons.clock,
                              width: 30,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppPadding.heightSpace30,
                    SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              btnText: "Save",
                              ontap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: AppButton(
                              btnText: "Live",
                              ontap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
