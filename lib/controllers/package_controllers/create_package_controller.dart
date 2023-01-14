import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tour_lister_app/constants/svg_icons.dart';
import 'package:tour_lister_app/services/location_services/get_location_service.dart';
import 'package:tour_lister_app/services/package_services/create_package_service.dart';
import 'package:tour_lister_app/utils/formated_datetime.dart';
import 'package:tour_lister_app/views/main_screens/main_page.dart';
import 'package:tour_lister_app/views/main_screens/screens/create_package.dart';

import '../../constants/app_colors.dart';

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
  File? termsAndConditionFile;
  int toursStayDays = 0;
  int dangerRating = 1;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  int initialAge = 16;
  String selectedCat = "Family";
  String selectedPersons = "2";
  List<String> availableNoofSeats = [
    "2",
    "3",
    "4",
    "5",
  ];
  List<String> catagories = [
    "Individual",
    "Couples",
    "Family",
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
  determineLocation() async {
    isLoading = true;
    location.text = "loading...";
    update();
    await _locationService.determinePosition();
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
    } else if (extraInfoController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please Give Extra Info for package",
        colorText: Colors.white,
        backgroundColor: AppColors.primarycolor,
      );
    } else {
      isLoading = true;
      update();
      await _createPackageService.createPackage(
        lattitude: _locationService.position!.latitude.toString(),
        longitude: _locationService.position!.longitude.toString(),
        packageName: packageName.text,
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        startDate: startDateController.text,
        endDate: endDateController.text,
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
      firstDate: DateTime(1990),
      lastDate: DateTime(2025),
    );
    if (selectedDate != null) {
      startDate = selectedDate;
      var formatedDate = DateFormat("dd MMM").format(selectedDate);
      startDateController.text = formatedDate;
      selectStartTime(context);
    }
    update();
  }

  selectEndDate(context) async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: startDate!,
      firstDate: DateTime(1990),
      lastDate: DateTime(2025),
    );
    if (selectedDate != null) {
      endDate = selectedDate;
      var formatedDate = DateFormat("dd MMM").format(selectedDate);
      endDateController.text = formatedDate;
      selectEndTime(context);
    }
    update();
  }

  calculateDateInDays() {
    var newStartDate = DateTime(
      startDate!.year,
      startDate!.month,
      startDate!.day,
      startTime!.hour,
      startTime!.minute,
    );
    var newEndDate = DateTime(
      endDate!.year,
      endDate!.month,
      endDate!.day,
      endTime!.hour,
      endDate!.minute,
    );

    toursStayDays = -(newStartDate.difference(newEndDate).inDays);
    if (toursStayDays < 2) {
      var inHours = -(newStartDate.difference(newEndDate).inHours);
      print("hours $inHours");
    } else {
      print("Days$toursStayDays");
    }

    update();
  }

  selectTime(context) async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      var formatedTime = time.format(context);
      cuttoffTime.text = formatedTime;
      update();
    }
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
      if (startDateController.text.isNotEmpty &&
          endDateController.text.isNotEmpty &&
          startTimeController.text.isNotEmpty) {
        calculateDateInDays();
      }
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
