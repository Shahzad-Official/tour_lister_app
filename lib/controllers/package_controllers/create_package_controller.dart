import 'dart:collection';
import 'dart:io';

import 'package:duration_picker/duration_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/models/icons_model.dart';
import 'package:tour_lister_app/services/location_services/get_location_service.dart';
import 'package:tour_lister_app/services/package_services/create_package_service.dart';

import '../../constants/app_colors.dart';
import '../../utils/app_snackbar.dart';

class CreatePackageController extends GetxController {
  final CreatePackageService _createPackageService = CreatePackageService();
  final GetLocationService _locationService = GetLocationService();
  TextEditingController packageName = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController cuttoffTime = TextEditingController();
  TextEditingController startPrice = TextEditingController();
  TextEditingController endPrice = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController otherImageController = TextEditingController();
  TextEditingController coverImageController = TextEditingController();
  TextEditingController noOfBookigs = TextEditingController();
  TextEditingController termsAndConditions = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController extraInfoController = TextEditingController();
  TextEditingController description = TextEditingController();
  File? termsAndConditionFile;
  int toursStayDays = 0;
  int dangerRating = 1;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  int initialAge = 1;
  String selectedCat = "Family/Group";
  String selectedPersons = "3";
  List<String> get availableNoofSeats => List.generate(
        17,
        (index) => (3 + index).toString(),
      );
  List<String> catagories = [
    "Individual",
    "Couples",
    "Family/Group",
  ];

  File? _otherImage;
  pickOtherImage() async {
    var result =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    if (result == null) return;

    _otherImage = File(result.path);

    otherImageController.text = "Uploaded Successfully";
    update();
  }

  File? _coverImage;
  pickCoverImage() async {
    var result =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    if (result == null) return;

    _coverImage = File(result.path);

    coverImageController.text = "Uploaded Successfully";
    update();
  }

  bool isLoading = false;
  determineLocation(context) async {
    isLoading = true;
    location.text = "loading...";
    update();
    await _locationService.determinePosition(context);
    isLoading = false;
    location.text = _locationService.address!;
    update();
  }

  isValidInfo(context) async {
    noOfBookigs.text = selectedPersons;
    if (packageName.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Enter Your PackageName",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (location.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Provide Your Package's location",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (startDateController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Select Your Package's start date",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (endDateController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Select Your Package's end date",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (startTimeController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Select Your Package's start Time",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (endTimeController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Select Your Package's end Time",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (startPrice.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Enter Your Package's startPrice",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (endPrice.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Enter Your Package's endPrice",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (int.parse(startPrice.text) < int.parse(endPrice.text)) {
      Get.snackbar(
        "Error",
        "StartPrice must be higher than Final Price.",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (cuttoffTime.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Select Your Package's cuttOfTime",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (otherImageController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Upload your Package other image",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (coverImageController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Upload your Package cover image",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (noOfBookigs.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Enter Your Package's Allowed NoOfBookings",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (termsAndConditions.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please Select Terms And Conditions File",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else if (description.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please provide Description for package",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else {
      isLoading = true;
      update();
      await _createPackageService.createPackage(
        address: location.text,
        latitude: _locationService.position!.latLng!.latitude,
        longitude: _locationService.position!.latLng!.longitude,
        packageName: packageName.text,
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        startDate: startDate.toString(),
        endDate: endDate.toString(),
        startPrice: startPrice.text,
        endPrice: endPrice.text,
        cuttOffTime: cuttoffTime.text,
        otherImage: _otherImage!,
        coverImage: _coverImage!,
        noOfPersonsInPackage: noOfBookigs.text,
        dangerRating: dangerRating.toString(),
        ageSuitability: initialAge.toString(),
        typeOfTour: selectedCat,
        extraInfo: extraInfoController.text,
        foodServed:
            "${Get.find<FoodServicesController>().breakFastServedTimes} BreakFast  ${Get.find<FoodServicesController>().lunchServedTimes} Lunch  ${Get.find<FoodServicesController>().dinnerServedTimes} Dinner  ",
        termsAndCondition: termsAndConditionFile!,
      );
      isLoading = false;
      update();
    }
  }

  selectStartDate(context) async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (selectedDate != null) {
      startDate = selectedDate;
      var formatedDate = DateFormat("dd MMM").format(selectedDate);
      startDateController.text = formatedDate;
    }
    update();
  }

  selectEndDate(context) async {
    if (startDate == null) {
      AppSnackbar.snackBar(title: "Error", message: "Select StartDate first");
    } else {
      var selectedDate = await showDatePicker(
        context: context,
        initialDate: startDate!.add(const Duration(days: 1)),
        firstDate: startDate!.add(const Duration(days: 1)),
        lastDate: DateTime(2025),
      );
      if (selectedDate != null) {
        endDate = selectedDate;
        var formatedDate = DateFormat("dd MMM").format(selectedDate);
        endDateController.text = formatedDate;
      }
      update();
    }
  }

  selectTime(context) {
    showDurationPicker(
      context: context,
      initialTime: const Duration(minutes: 10),
    ).then(
      (value) {
        Duration duration = value!;
        String sDuration =
            "${duration.inHours} H:${duration.inMinutes.remainder(60)} M";
        cuttoffTime.text = sDuration;
      },
    );
  }

  selectStartTime(context) async {
    var time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(
        hour: 12,
        minute: 00,
      ),
    );
    if (time != null) {
      startTime = time;
      var formatedTime = time.format(context);
      startTimeController.text = formatedTime;
      update();
    }
  }

  selectEndTime(context) async {
    var time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(
        hour: 12,
        minute: 00,
      ),
    );
    if (time != null) {
      endTime = time;
      var formatedTime = time.format(context);
      endTimeController.text = formatedTime;

      update();
    }
  }

  pickPDFFile() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );
    if (result != null) {
      termsAndConditions.text = result.files.first.name;
      termsAndConditionFile = File(result.files.first.path!);
    } else {
      debugPrint("Error: File not Picked....");
    }
    update();
  }

  assignDangerRating(int rating) {
    dangerRating = rating;
    update();
  }

  changeSliderValue(double value) {
    var intValue = value.toInt();
    initialAge = intValue;
    update();
  }

  changeCatagory(value) {
    selectedCat = value;
    if (selectedCat == "Individual") {
      noOfBookigs.text = "1";
    } else if (selectedCat == "Couples") {
      noOfBookigs.text = "2";
    } else {
      noOfBookigs.text = selectedPersons;
    }
    update();
  }

  changeNoOfSeats(value) {
    selectedPersons = value;
    noOfBookigs.text = selectedPersons;

    update();
  }

  List<IconsModel> get listIcons {
    return icons.toSet().toList();
  }

  addIcon({
    required IconsModel iconData,
  }) {
    icons.add(iconData);
    update();
  }

  removeIcon({
    required IconsModel iconData,
  }) {
    icons.remove(iconData);
    update();
  }

  List<IconsModel> icons = [];

  List<int> count = List.generate(20, (index) => 0);

  inclusionAddition(
    int index,
  ) {
    count[index]++;

    update();
  }

  inclusionSubtraction(
    int index,
  ) {
    if (count[index] == 0) {
    } else {
      count[index]--;

      update();
    }
  }
}

class FoodServicesController extends GetxController {
  int dinnerServedTimes = 1;
  int breakFastServedTimes = 1;
  int lunchServedTimes = 1;

  List<String> foodIcons = [
    SvgIcons.breakFast,
    SvgIcons.lunch,
    SvgIcons.dinner,
  ];
  List<int> foodServedTimesList = [
    1,
    1,
    1,
  ];

  changeFoodServesValues(int value, int index) {
    if (index == 0) {
      breakFastServedTimes = value;
      foodServedTimesList[0] = breakFastServedTimes;
    } else if (index == 1) {
      lunchServedTimes = value;
      foodServedTimesList[1] = lunchServedTimes;
    } else if (index == 2) {
      dinnerServedTimes = value;
      foodServedTimesList[2] = dinnerServedTimes;
    }

    update();
  }
}
