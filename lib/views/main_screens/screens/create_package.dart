import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/controllers/package_controllers/create_package_controller.dart';
import 'package:tour_lister_app/services/inclusions_services/get_icons.dart';
import 'package:tour_lister_app/services/package_services/create_package_service.dart';

import 'package:tour_lister_app/widgets/app_button.dart';
import 'package:tour_lister_app/widgets/app_cached_image.dart';
import 'package:tour_lister_app/widgets/app_input_field.dart';
import 'package:tour_lister_app/widgets/app_text.dart';
import 'package:tour_lister_app/widgets/app_tool_tip.dart';

import '../../../utils/tool_tip_shap.dart';

class CreatePackage extends StatefulWidget {
  const CreatePackage({super.key});

  @override
  State<CreatePackage> createState() => _CreatePackageState();
}

class _CreatePackageState extends State<CreatePackage> {
  bool isloading = false;
  final GetIcons _getIcons = GetIcons();
  final CreatePackageService _service = CreatePackageService();
  getData() async {
    setState(() {
      isloading = true;
    });
    await _getIcons.getIcons();
    await _service.getAllCats();
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isloading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return GetBuilder<CreatePackageController>(
      init: CreatePackageController(),
      builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: AppPadding.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Package Name",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  textcolor: AppColors.headTextColor,
                ),
                AppPadding.heightSpace10,
                AppInputField(
                  controller: _.packageName,
                  hintText: "Package Name",
                ),
                AppPadding.heightSpace30,
                AppText(
                  text: "Package Category",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  textcolor: AppColors.headTextColor,
                ),
                AppPadding.heightSpace10,
                DropdownContainer(
                  hintText: "Select Category",
                  items: _service.allCats,
                  onValueChange: (value) {
                    _.packageCat.text = value.toString();
                  },
                ),
                AppPadding.heightSpace30,
                AppText(
                  text: "Location",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  textcolor: AppColors.headTextColor,
                ),
                AppPadding.heightSpace10,
                AppInputField(
                  enabled: false,
                  onTap: () async {
                    await _.determineLocation(context);
                  },
                  controller: _.location,
                  hintText: "Location",
                  contentPadding: const EdgeInsets.only(
                    top: 20,
                    left: 15,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 17,
                    ),
                    child: SvgPicture.string(
                      SvgIcons.mapMarkerFilled,
                      width: 30,
                      // ignore: deprecated_member_use
                      color: Colors.grey,
                    ),
                  ),
                ),
                AppPadding.heightSpace30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "Start Date",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            textcolor: AppColors.headTextColor,
                          ),
                          AppPadding.heightSpace10,
                          AppInputField(
                            controller: _.startDateController,
                            onTap: () {
                              _.selectStartDate(context);
                            },
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
                                // ignore: deprecated_member_use
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "End Date",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            textcolor: AppColors.headTextColor,
                          ),
                          AppPadding.heightSpace10,
                          AppInputField(
                            controller: _.endDateController,
                            onTap: () {
                              _.selectEndDate(context);
                            },
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
                                // ignore: deprecated_member_use
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppPadding.heightSpace30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "Start Time",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            textcolor: AppColors.headTextColor,
                          ),
                          AppPadding.heightSpace10,
                          AppInputField(
                            controller: _.startTimeController,
                            onTap: () {
                              _.selectStartTime(context);
                            },
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
                                // ignore: deprecated_member_use
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "End Time",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            textcolor: AppColors.headTextColor,
                          ),
                          AppPadding.heightSpace10,
                          AppInputField(
                            controller: _.endTimeController,
                            onTap: () {
                              _.selectEndTime(context);
                            },
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
                                // ignore: deprecated_member_use
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppPadding.heightSpace30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: "Start Price",
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                textcolor: AppColors.headTextColor,
                              ),
                              AppToolTip(
                                text: "text",
                              ),
                            ],
                          ),
                          AppPadding.heightSpace10,
                          AppInputField(
                            controller: _.startPrice,
                            keyboardtype: TextInputType.number,
                            hintText: "Start Price",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: "Final Price",
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                textcolor: AppColors.headTextColor,
                              ),
                              AppToolTip(
                                text: "text",
                              ),
                            ],
                          ),
                          AppPadding.heightSpace10,
                          AppInputField(
                            controller: _.endPrice,
                            keyboardtype: TextInputType.number,
                            hintText: "Final Price",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppPadding.heightSpace30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Cutoff Time",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textcolor: AppColors.headTextColor,
                    ),
                    AppToolTip(
                      text: "text",
                    ),
                  ],
                ),
                AppPadding.heightSpace10,
                AppInputField(
                  controller: _.cuttoffTime,
                  enabled: false,
                  onTap: () {
                    _.selectTime(context);
                  },
                  hintText: _.cuttoffTime.text.isEmpty ? "Cutoff Time" : _.cuttoffTime.text,
                  contentPadding: const EdgeInsets.only(
                    top: 20,
                    left: 15,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 17,
                    ),
                    child: SvgPicture.string(
                      SvgIcons.clock,
                      width: 30,
                      // ignore: deprecated_member_use
                      color: Colors.grey,
                    ),
                  ),
                ),
                AppPadding.heightSpace30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Package Description",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textcolor: AppColors.headTextColor,
                    ),
                    AppToolTip(
                      text: "text",
                    ),
                  ],
                ),
                AppPadding.heightSpace10,
                AppInputField(
                  controller: _.description,
                  height: 150,
                  hintText: "Package Description",
                  maxLength: 200,
                  maxLines: 10,
                  keyboardtype: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                ),
                AppPadding.heightSpace30,
                AppText(
                  text: "Upload Cover Image",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  textcolor: AppColors.headTextColor,
                ),
                AppPadding.heightSpace10,
                AppInputField(
                  controller: _.coverImageController,
                  enabled: false,
                  onTap: () {
                    _.pickCoverImage();
                  },
                  hintText: "Upload Cover Image",
                  contentPadding: const EdgeInsets.only(
                    top: 20,
                    left: 15,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 17,
                    ),
                    child: SvgPicture.string(
                      SvgIcons.cameraFilled,
                      width: 30,
                      // ignore: deprecated_member_use
                      color: Colors.grey,
                    ),
                  ),
                ),
                AppPadding.heightSpace30,
                AppText(
                  text: "Upload Other Image",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  textcolor: AppColors.headTextColor,
                ),
                AppPadding.heightSpace10,
                AppInputField(
                  controller: _.otherImageController,
                  enabled: false,
                  onTap: () {
                    _.pickOtherImage();
                  },
                  hintText: "Upload Other Images",
                  contentPadding: const EdgeInsets.only(
                    top: 20,
                    left: 15,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 17,
                    ),
                    child: SvgPicture.string(
                      SvgIcons.cameraFilled,
                      width: 30,
                      // ignore: deprecated_member_use
                      color: Colors.grey,
                    ),
                  ),
                ),
                AppPadding.heightSpace30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "No of Packages Available",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textcolor: AppColors.headTextColor,
                    ),
                    AppToolTip(
                      text: "text",
                    ),
                  ],
                ),
                AppPadding.heightSpace10,
                AppInputField(
                  controller: _.noOfPackages,
                  keyboardtype: TextInputType.number,
                  hintText: "No of Packages Available",
                ),
                AppPadding.heightSpace30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Package Type",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textcolor: AppColors.headTextColor,
                    ),
                    AppToolTip(
                      text: "text",
                    ),
                  ],
                ),
                AppPadding.heightSpace10,
                DropdownContainer(
                  currentValue: _.selectedCat,
                  items: _.catagories,
                  onValueChange: (value) {
                    _.changeCatagory(value);
                  },
                ),
                AppPadding.heightSpace30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Person per Package",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textcolor: AppColors.headTextColor,
                    ),
                    AppToolTip(
                      text: "text",
                    ),
                  ],
                ),
                AppPadding.heightSpace10,
                Row(
                  children: [
                    _.selectedCat == "Family/Group"
                        ? const Expanded(
                            child: AppInputField(
                              textAlign: TextAlign.center,
                              enabled: false,
                              hintText: "3 -",
                            ),
                          )
                        : const SizedBox(),
                    Expanded(
                      flex: 4,
                      child: AppInputField(
                        enabled: _.selectedCat == "Family/Group" ? true : false,
                        controller: _.noOfBookigs,
                        hintText: "Total no of bookings allowed",
                        keyboardtype: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                AppPadding.heightSpace30,
                AppText(
                  text: "Danger Rating",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  textcolor: AppColors.headTextColor,
                ),
                AppPadding.heightSpace30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        _.assignDangerRating(1);
                      },
                      child: Column(
                        children: [
                          SvgPicture.string(
                            _.dangerRating == 1 ? SvgIcons.starFilled : SvgIcons.star,
                            width: 25,
                          ),
                          AppText(
                            text: "Easy Going",
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            textcolor: AppColors.headTextColor,
                          ),
                          AppPadding.heightSpace10,
                          AppToolTip(
                            text: "Testing",
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _.assignDangerRating(2);
                      },
                      child: Column(
                        children: [
                          SvgPicture.string(
                            _.dangerRating == 2 ? SvgIcons.starFilled : SvgIcons.star,
                            width: 25,
                          ),
                          AppText(
                            text: "Excitement guaranteed",
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            textcolor: AppColors.headTextColor,
                          ),
                          AppPadding.heightSpace10,
                          AppToolTip(text: "text"),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _.assignDangerRating(3);
                      },
                      child: Column(
                        children: [
                          SvgPicture.string(
                            _.dangerRating == 3 ? SvgIcons.starFilled : SvgIcons.star,
                            width: 25,
                          ),
                          AppText(
                            text: "Excitement Blast",
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            textcolor: AppColors.headTextColor,
                          ),
                          AppPadding.heightSpace10,
                          AppToolTip(
                            text: "Tesst",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppPadding.heightSpace30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Age Suitability",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textcolor: AppColors.headTextColor,
                    ),
                    AppToolTip(
                      text: "text",
                    ),
                  ],
                ),
                AppPadding.heightSpace30,
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: AppText(
                          text: "${_.initialAge}+",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          textcolor: AppColors.headTextColor,
                        ),
                      ),
                    ),
                    Slider(
                      thumbColor: Colors.white,
                      inactiveColor: Colors.black,
                      min: 1,
                      max: 16,
                      value: _.initialAge.toDouble(),
                      onChanged: (value) {
                        _.changeSliderValue(value);
                      },
                    ),
                  ],
                ),
                AppPadding.heightSpace30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Add Inclusions",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textcolor: AppColors.headTextColor,
                    ),
                    AppToolTip(
                      text: "text",
                    ),
                  ],
                ),
                AppPadding.heightSpace10,
                Builder(
                  builder: (context) {
                    if (isloading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (_getIcons.iconsData.isEmpty) {
                        return const Text("Data not available");
                      } else {
                        return AppInputField(
                          hintText: "Add Inclusion",
                          enabled: false,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  icon: Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () => Get.back(),
                                      icon: const Icon(Icons.close),
                                    ),
                                  ),
                                  content: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    height: Get.height * 0.7,
                                    width: Get.width * 0.8,
                                    child: Center(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            AppText(
                                              text: "Inclusions",
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            AppPadding.heightSpace20,
                                            GridView.builder(
                                              itemCount: _getIcons.iconsData.length,
                                              shrinkWrap: true,
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                mainAxisSpacing: 20,
                                                crossAxisSpacing: 20,
                                                childAspectRatio: 0.8,
                                              ),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    _.addIcon(
                                                      iconData: _getIcons.iconsData[index],
                                                    );
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: AppColors.primarycolor.withOpacity(0.4),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        AppCachedImage(
                                                          height: 50,
                                                          width: 50,
                                                          picUrl: _getIcons.iconsData[index].iconImage!,
                                                        ),
                                                        // AppPadding
                                                        //     .heightSpace10,
                                                        // AppText(
                                                        //   text: _getIcons
                                                        //       .iconsData[index]
                                                        //       .iconName
                                                        //       .toString(),
                                                        //   fontSize: 15,
                                                        //   fontWeight:
                                                        //       FontWeight.w500,
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    }
                  },
                ),
                _.icons.isEmpty
                    ? const SizedBox()
                    : Column(
                        children: [
                          AppPadding.heightSpace30,
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _.icons.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 110,
                                      width: 90,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              height: 100,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                color: AppColors.primarycolor.withOpacity(0.3),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: AppColors.primarycolor,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child: AppCachedImage(
                                                      picUrl: _.icons[index].iconImage.toString(),
                                                    ),
                                                  ),
                                                  // AppText(
                                                  //   text: _
                                                  //       .icons[index].iconName
                                                  //       .toString(),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _.removeIcon(
                                                iconData: _.icons[index],
                                              );
                                            },
                                            child: const CircleAvatar(
                                              radius: 15,
                                              backgroundColor: AppColors.primarycolor,
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 80,
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              _.inclusionAddition(index);
                                            },
                                            child: const CircleAvatar(
                                              radius: 15,
                                              child: Icon(
                                                Icons.add,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _.inclusionSubtraction(index);
                                            },
                                            child: const CircleAvatar(
                                              radius: 15,
                                              child: Icon(
                                                Icons.remove,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AppText(
                                      text: _.count[index].toString(),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      textcolor: Colors.black,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                AppPadding.heightSpace30,
                AppText(
                  text: "Upload file of Terms and Conditions",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  textcolor: AppColors.headTextColor,
                ),
                AppPadding.heightSpace10,
                AppInputField(
                  controller: _.termsAndConditions,
                  enabled: false,
                  onTap: () {
                    _.pickPDFFile();
                  },
                  hintText: "Upload file of Terms and Conditions",
                  contentPadding: const EdgeInsets.only(
                    top: 20,
                    left: 15,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 17,
                    ),
                    child: SvgPicture.string(
                      SvgIcons.docIcon,
                      width: 30,
                      // ignore: deprecated_member_use
                      color: _.termsAndConditions.text.isEmpty ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
                AppPadding.heightSpace30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Package Extra Info",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textcolor: AppColors.headTextColor,
                    ),
                    AppToolTip(
                      text: "text",
                    ),
                  ],
                ),
                AppPadding.heightSpace10,
                AppInputField(
                  controller: _.extraInfoController,
                  height: 150,
                  hintText: "Package Extra Info",
                  maxLength: 200,
                  maxLines: 10,
                  keyboardtype: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                ),
                AppPadding.heightSpace30,
                AppButton(
                  isLoading: _.isLoading,
                  btnText: "Create",
                  ontap: () async {
                    await _.isValidInfo(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
