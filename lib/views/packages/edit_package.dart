import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:map_address_picker/map_address_picker.dart';
import 'package:map_address_picker/models/location_result.dart';
import 'package:tour_lister_app/constants/app_colors.dart';
import 'package:tour_lister_app/constants/app_paddings.dart';
import 'package:tour_lister_app/controllers/package_controllers/edit_package_controller.dart';
import 'package:tour_lister_app/models/packages/packages_model.dart';
import 'package:tour_lister_app/services/booking_services/get_all_bookings.dart';
import 'package:tour_lister_app/utils/date_format.dart';
import 'package:tour_lister_app/widgets/app_button.dart';
import 'package:tour_lister_app/widgets/app_cached_image.dart';
import '../../constants/svg_icons.dart';
import '../../models/icons_model.dart';
import '../../services/inclusions_services/get_icons.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/app_text.dart';

// ignore: must_be_immutable
class EditPackage extends StatefulWidget {
  bool isLive;
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
    this.isLive = false,
  }) : super(key: key);

  @override
  State<EditPackage> createState() => _EditPackageState();
}

class _EditPackageState extends State<EditPackage> {
  final GetIcons _getIcons = GetIcons();
  EditPackageController packageController = Get.put(EditPackageController());
  final GetAllBookings _getAllBookings = GetAllBookings();
  bool isLoading = false;
  initializeData() async {
    setState(() {
      isLoading = true;
    });
    await _getIcons.getIcons();
    await _getAllBookings.getAllBookings();
    if (_getAllBookings.allBookings
        .any((element) => element.tourId == widget.packageData.packageId)) {
      setState(() {
        widget.isLive = true;
      });
    } else {
      setState(() {
        widget.isLive = false;
      });
    }
    setState(() {
      isLoading = false;
    });
    if (widget.packageData.packageId != null) {
      packageController.startDate = DateTime.parse(widget.startDate);
      packageController.termsFileUrl = widget.packageData.termsAndConditions;
      packageController.endDate = DateTime.parse(widget.endDate);
      packageController.startDateController.text =
          CustomDateFormat.dateFormat(widget.startDate);
      packageController.endDateController.text =
          CustomDateFormat.dateFormat(widget.endDate);
      packageController.startTimeController.text = widget.startTime;
      packageController.endTimeController.text = widget.endTime;
      packageController.packageName.text =
          widget.packageData.packageName.toString();
      packageController.location.text =
          widget.packageData.location!.address.toString();
      packageController.startPrice.text =
          widget.packageData.startPrice.toString();
      packageController.endPrice.text = widget.packageData.endPrice.toString();
      packageController.cuttoffTime.text =
          widget.packageData.cuttOffTime.toString();
      packageController.noOfBookigs.text =
          widget.packageData.noOfPersonsInPackage.toString();
      packageController.selectedCat = widget.packageData.typeOfTour.toString();
      packageController.dangerRating =
          int.parse(widget.packageData.dangerRating.toString());
      packageController.initialAge =
          int.parse(widget.packageData.ageSuitability.toString());
      packageController.termsAndConditions.text =
          widget.packageData.termsAndConditions.toString();
      packageController.description.text =
          widget.packageData.description.toString();
      packageController.extraInfoController.text =
          widget.packageData.extraInfo ?? "";
      packageController.newPosition = LocationResult(
        latLng: LatLng(
          widget.packageData.location!.latitude!,
          widget.packageData.location!.longitude!,
        ),
      );
      packageController.coverImageUrl = widget.packageData.thumbnailUrl;
      packageController.otherImageUrl = widget.packageData.otherImage;
      packageController.noOfPackages.text =
          widget.packageData.availablePackages.toString();
      if (widget.packageData.inclusions != null) {
        packageController.icons = List.generate(
          widget.packageData.inclusions!.length,
          (index) => IconsModel.fromJson(
            {
              "IconImage": widget.packageData.inclusions![index].iconImage,
              "IconName": widget.packageData.inclusions![index].iconName,
            },
          ),
        );
        packageController.count = List.generate(
          widget.packageData.inclusions!.length,
          (index) => packageController.count[index] =
              widget.packageData.inclusions![index].inclusionCount!,
        );
      }
    }
  }

  @override
  void initState() {
    initializeData();
    super.initState();
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
                            packageController.coverImage != null
                                ? Image.file(packageController.coverImage!)
                                : AppCachedImage(
                                    picUrl: widget.picUrl,
                                  ),
                            widget.isLive
                                ? const SizedBox()
                                : DecoratedBox(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primarycolor,
                                    ),
                                    child: IconButton(
                                      highlightColor: AppColors.primarycolor,
                                      hoverColor: AppColors.primarycolor,
                                      splashColor: AppColors.primarycolor,
                                      onPressed: () {
                                        _.pickCoverImage();
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      AppPadding.heightSpace15,
                      widget.isLive
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  text: "Pick Package Other Images",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  textcolor: AppColors.headTextColor,
                                ),
                                DecoratedBox(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primarycolor,
                                  ),
                                  child: IconButton(
                                    highlightColor: AppColors.primarycolor,
                                    hoverColor: AppColors.primarycolor,
                                    splashColor: AppColors.primarycolor,
                                    onPressed: () {
                                      _.pickOtherImage();
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      AppPadding.heightSpace10,
                      _.allOtherImages.isEmpty &&
                              widget.packageData.otherImage!.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              height: 100,
                              width: double.infinity,
                              child: SingleChildScrollView(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 20,
                                  children: List.generate(
                                    _.allOtherImages.isEmpty
                                        ? widget.packageData.otherImage!.length
                                        : _.allOtherImages.length,
                                    (index) {
                                      if (_.allOtherImages.isEmpty) {
                                        return AppCachedImage(
                                          height: 100,
                                          width: 100,
                                          picUrl: widget
                                              .packageData.otherImage![index],
                                        );
                                      } else {
                                        return Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: FileImage(
                                                _.allOtherImages[index],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                      AppPadding.heightSpace20,
                      AppInputField(
                        enabled: !widget.isLive,
                        controller: _.packageName,
                        hintText: "Package Name",
                      ),
                      AppPadding.heightSpace30,
                      AppInputField(
                        enabled: false,
                        onTap: widget.isLive
                            ? null
                            : () async {
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
                            onTap: widget.isLive
                                ? null
                                : () {
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
                            onTap: widget.isLive
                                ? null
                                : () {
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
                            onTap: widget.isLive
                                ? null
                                : () {
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
                            onTap: widget.isLive
                                ? null
                                : () {
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
                            enabled: !widget.isLive,
                            controller: _.startPrice,
                            keyboardtype: TextInputType.number,
                            width: MediaQuery.of(context).size.width * 0.415,
                            hintText: "Start Price",
                          ),
                          AppInputField(
                            enabled: !widget.isLive,
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
                        onTap: widget.isLive
                            ? null
                            : () {
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
                        enabled: !widget.isLive,
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
                        text: "No of Packages Available",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textcolor: AppColors.headTextColor,
                      ),
                      AppPadding.heightSpace10,
                      AppInputField(
                        enabled: !widget.isLive,
                        controller: _.noOfPackages,
                        keyboardtype: TextInputType.number,
                        hintText: "No of Packages Available",
                      ),
                      AppText(
                        text: "Total No of Bookings",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textcolor: AppColors.headTextColor,
                      ),
                      AppPadding.heightSpace10,
                      _.selectedCat == "Family/Group" && !widget.isLive
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
                        onValueChange: widget.isLive
                            ? null
                            : (value) {
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
                            onTap: widget.isLive
                                ? null
                                : () {
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
                            onTap: widget.isLive
                                ? null
                                : () {
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
                            onTap: widget.isLive
                                ? null
                                : () {
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
                            onChanged: widget.isLive
                                ? null
                                : (value) {
                                    _.changeSliderValue(value);
                                  },
                          ),
                        ],
                      ),
                      AppPadding.heightSpace30,
                      Builder(
                        builder: (context) {
                          if (isLoading) {
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
                                onTap: widget.isLive
                                    ? null
                                    : () {
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
                                                  borderRadius:
                                                      BorderRadius.circular(15),
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
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        AppPadding
                                                            .heightSpace20,
                                                        GridView.builder(
                                                          itemCount: _getIcons
                                                              .iconsData.length,
                                                          shrinkWrap: true,
                                                          gridDelegate:
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            mainAxisSpacing: 20,
                                                            crossAxisSpacing:
                                                                20,
                                                            childAspectRatio:
                                                                0.7,
                                                          ),
                                                          itemBuilder:
                                                              (context, index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                _.addIcon(
                                                                  iconData: _getIcons
                                                                          .iconsData[
                                                                      index],
                                                                );
                                                                Get.back();
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: AppColors
                                                                      .primarycolor
                                                                      .withOpacity(
                                                                          0.4),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    AppPadding
                                                                        .heightSpace10,
                                                                    AppCachedImage(
                                                                      height:
                                                                          50,
                                                                      width: 50,
                                                                      picUrl: _getIcons
                                                                          .iconsData[
                                                                              index]
                                                                          .iconImage!,
                                                                    ),
                                                                    AppPadding
                                                                        .heightSpace10,
                                                                    AppText(
                                                                      text: _getIcons
                                                                          .iconsData[
                                                                              index]
                                                                          .iconName
                                                                          .toString(),
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
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
                                                  onTap: widget.isLive
                                                      ? null
                                                      : () {
                                                          _.removeIcon(
                                                            iconData:
                                                                _.icons[index],
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
                                                  onTap: widget.isLive
                                                      ? null
                                                      : () {
                                                          _.inclusionAddition(
                                                              index);
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
                                                  onTap: widget.isLive
                                                      ? null
                                                      : () {
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
                        onTap: widget.isLive
                            ? null
                            : () {
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
                        enabled: !widget.isLive,
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
                                isLoading: _.isLoading,
                                btnText: "Save",
                                ontap: () async {
                                  await _.isValidInfo(
                                    context,
                                    widget.packageData.packageId,
                                  );
                                },
                              ),
                            ),
                            widget.isLive
                                ? const SizedBox()
                                : const SizedBox(
                                    width: 20,
                                  ),
                            widget.isLive
                                ? const SizedBox()
                                : Expanded(
                                    child: AppButton(
                                      isLoading: _.isLoading,
                                      btnText: "Duplicate",
                                      ontap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: SizedBox(
                                                  height: Get.height * 0.3,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      AppText(
                                                        text: "Package Name",
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        textcolor: AppColors
                                                            .headTextColor,
                                                      ),
                                                      AppPadding.heightSpace15,
                                                      AppInputField(
                                                        controller:
                                                            _.packageName,
                                                        hintText:
                                                            "Package Name",
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                      ),
                                                      AppPadding.heightSpace30,
                                                      GetBuilder<
                                                          EditPackageController>(
                                                        init:
                                                            EditPackageController(),
                                                        builder: (_) {
                                                          return AppButton(
                                                            isLoading:
                                                                _.isLoading,
                                                            btnText: "Done",
                                                            ontap: () async {
                                                              await _
                                                                  .isValidInfo(
                                                                context,
                                                                widget
                                                                    .packageData
                                                                    .packageId,
                                                                isDuplicating:
                                                                    true,
                                                              );
                                                            },
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      // widget.isLive
                      //     ? const SizedBox()
                      //     : AppButton(
                      //         isLoading: _.isLoading,
                      //         btnText: "Duplicate",
                      //         ontap: () async {
                      //           await _.isValidInfo(
                      //             context,
                      //             widget.packageData.packageId,
                      //             isLive: widget.isLive,
                      //           );
                      //         },
                      //       ),
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
