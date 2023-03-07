import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/controllers/package_controllers/create_package_controller.dart';
import 'package:tour_lister_app/models/icons_model.dart';
import 'package:tour_lister_app/services/inclusions_services/get_icons.dart';

import 'package:tour_lister_app/widgets/app_button.dart';
import 'package:tour_lister_app/widgets/app_input_field.dart';
import 'package:tour_lister_app/widgets/app_text.dart';

class CreatePackage extends StatelessWidget {
  CreatePackage({super.key});
  final GetIcons _getIcons = GetIcons();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePackageController>(
      init: CreatePackageController(),
      builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: AppPadding.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppInputField(
                  controller: _.packageName,
                  hintText: "Package Name",
                ),
                AppPadding.heightSpace30,
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
                      color: Colors.grey,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppInputField(
                      controller: _.startPrice,
                      keyboardtype: TextInputType.number,
                      width: MediaQuery.of(context).size.width * 0.415,
                      hintText: "Start Price",
                    ),
                    AppInputField(
                      controller: _.endPrice,
                      keyboardtype: TextInputType.number,
                      width: MediaQuery.of(context).size.width * 0.415,
                      hintText: "End Price",
                    ),
                  ],
                ),
                AppPadding.heightSpace30,
                AppInputField(
                  controller: _.cuttoffTime,
                  enabled: false,
                  onTap: () {
                    _.selectTime(context);
                  },
                  hintText: _.cuttoffTime.text.isEmpty
                      ? "Cutoff Time"
                      : _.cuttoffTime.text,
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
                      color: Colors.grey,
                    ),
                  ),
                ),
                AppPadding.heightSpace30,
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
                      color: Colors.grey,
                    ),
                  ),
                ),
                AppPadding.heightSpace30,
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
                      color: Colors.grey,
                    ),
                  ),
                ),
                AppPadding.heightSpace30,
                _.selectedCat == "Family"
                    ? DropdownContainer(
                        currentValue: _.selectedPersons,
                        items: _.availableNoofSeats,
                        onValueChange: (value) {
                          _.changeNoOfSeats(value);
                        },
                      )
                    : AppInputField(
                        enabled: false,
                        controller: _.noOfBookigs,
                        hintText: "Total no of bookings allowed",
                        keyboardtype: TextInputType.number,
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
                            _.dangerRating == 1
                                ? SvgIcons.starFilled
                                : SvgIcons.star,
                            width: 25,
                          ),
                          AppText(
                            text: "Easy Going",
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            textcolor: AppColors.headTextColor,
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
                            _.dangerRating == 2
                                ? SvgIcons.starFilled
                                : SvgIcons.star,
                            width: 25,
                          ),
                          AppText(
                            text: "Excitement guaranteed",
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            textcolor: AppColors.headTextColor,
                          ),
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
                            _.dangerRating == 3
                                ? SvgIcons.starFilled
                                : SvgIcons.star,
                            width: 25,
                          ),
                          AppText(
                            text: "Excitement Blast",
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            textcolor: AppColors.headTextColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppPadding.heightSpace30,
                AppText(
                  text: "Age Sutability",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  textcolor: AppColors.headTextColor,
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
                      label: "hello",
                      thumbColor: Colors.white,
                      inactiveColor: Colors.black,
                      min: 16,
                      max: 60,
                      value: _.initialAge.toDouble(),
                      onChanged: (value) {
                        _.changeSliderValue(value);
                      },
                    ),
                  ],
                ),
                AppPadding.heightSpace30,
                DropdownContainer(
                  currentValue: _.selectedCat,
                  items: _.catagories,
                  onValueChange: (value) {
                    _.changeCatagory(value);
                  },
                ),
                AppPadding.heightSpace30,
                FutureBuilder<List<IconsModel>>(
                  future: _getIcons.getIcons(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snapshot.data == null) {
                        return const Text("Data not available");
                      } else {
                        return PopupMenuButton(
                          child: ListTile(
                            title: AppText(text: "Inclusions"),
                            trailing: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: AppColors.headTextColor.withOpacity(0.7),
                              ),
                            ),
                          ),
                          itemBuilder: (context) {
                            return List.generate(
                              snapshot.data!.length,
                              (index) {
                                return PopupMenuItem(
                                  onTap: () {
                                    _.addIcon(
                                      iconData: snapshot.data![index],
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      snapshot.data![index].iconImage
                                          .toString(),
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
                _.listIcons.isEmpty
                    ? const SizedBox()
                    : Column(
                        children: [
                          AppPadding.heightSpace30,
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: _.listIcons.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: AppText(
                                  text: _.listIcons[index].iconName.toString(),
                                ),
                                trailing: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    _.listIcons[index].iconImage.toString(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                AppPadding.heightSpace30,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppPadding.heightSpace30,
                    AppText(
                      text: "Food Served to Each Person",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textcolor: AppColors.headTextColor,
                    ),
                    AppPadding.heightSpace30,
                    GetBuilder<FoodServicesController>(
                        init: FoodServicesController(),
                        builder: (controller) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(controller.foodIcons.length,
                                (index) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.backgroundcolor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      offset: const Offset(2, 2),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SvgPicture.string(
                                      controller.foodIcons[index],
                                      width: 30,
                                      color: AppColors.headTextColor,
                                    ),
                                    NumberPicker(
                                      itemHeight: 40,
                                      itemWidth: 70,
                                      minValue: 1,
                                      maxValue: 5,
                                      value:
                                          controller.foodServedTimesList[index],
                                      onChanged: (value) {
                                        controller.changeFoodServesValues(
                                            value, index);
                                      },
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.primarycolor,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          );
                        })
                  ],
                ),
                AppPadding.heightSpace30,
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
                      color: _.termsAndConditions.text.isEmpty
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                ),
                AppPadding.heightSpace30,
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
