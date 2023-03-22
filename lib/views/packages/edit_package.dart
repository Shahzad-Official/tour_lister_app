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
import '../../models/icons_model.dart';
import '../../services/inclusions_services/get_icons.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/app_text.dart';

class EditPackage extends StatelessWidget {
  final String picUrl,
      pkgName,
      pkgLocation,
      startDate,
      endDate,
      startTime,
      endTime;
  final PackagesModel packageData;
  EditPackage({
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
  final GetIcons _getIcons = GetIcons();

  @override
  Widget build(BuildContext context) {
    EditPackageController packageController = Get.put(EditPackageController());
    packageController.startDate = DateTime.parse(startDate);
    packageController.endDate = DateTime.parse(endDate);
    packageController.startDateController.text =
        CustomDateFormat.dateFormat(startDate);
    packageController.endDateController.text =
        CustomDateFormat.dateFormat(endDate);
    packageController.startTimeController.text = startTime;
    packageController.endTimeController.text = endTime;
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
          body: SingleChildScrollView(
            child: Padding(
              padding: AppPadding.defaultPadding,
              child: GetBuilder<EditPackageController>(
                init: EditPackageController(),
                builder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 210,
                        width: double.infinity,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            AppCachedImage(
                              picUrl: picUrl,
                            ),
                            InkWell(
                              onTap: () {
                                _.pickCoverImage();
                              },
                              child: const Icon(
                                Icons.camera_alt,
                                color: AppColors.headTextColor,
                                size: 33,
                              ),
                            )
                          ],
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
                            text: pkgName,
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
                            text: pkgLocation,
                            textcolor: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      AppPadding.heightSpace30,
                      //updated to github
                      //ma ny bh const remove krky push kya ha abhi commit
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
                            hintText: "Final Price",
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
                      AppText(
                        text: "Total No of Bookings",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textcolor: AppColors.headTextColor,
                      ),
                      AppPadding.heightSpace10,
                      _.selectedCat == "Family/Group"
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
                      DropdownContainer(
                        currentValue: _.selectedCat,
                        items: _.catagories,
                        onValueChange: (value) {
                          _.changeCatagory(value);
                        },
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
                        text: "Age Suitability",
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
                                      color: AppColors.headTextColor
                                          .withOpacity(0.7),
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
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: 110,
                                            width: 90,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Container(
                                                    height: 100,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .primarycolor
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: AppColors
                                                            .primarycolor,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        SizedBox(
                                                          height: 50,
                                                          width: 50,
                                                          child: AppCachedImage(
                                                            picUrl: _
                                                                .icons[index]
                                                                .iconImage
                                                                .toString(),
                                                          ),
                                                        ),
                                                        AppText(
                                                          text: _.icons[index]
                                                              .iconName
                                                              .toString(),
                                                        ),
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
                                                    backgroundColor:
                                                        AppColors.primarycolor,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                    _.inclusionSubtraction(
                                                        index);
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
                        controller: _.description,
                        height: 150,
                        hintText: "Package Description",
                        maxLength: 200,
                        maxLines: 10,
                        keyboardtype: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
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
      ),
    );
  }
}
