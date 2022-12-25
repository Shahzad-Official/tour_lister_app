import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateTourController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController cuttoffTime = TextEditingController();
  TextEditingController otherImageController = TextEditingController();
  TextEditingController coverImageController = TextEditingController();
  String? otherImageUploadStatus;
  String? coverImageUploadStatus;
  int dangerRating = 0;
  String? startDate;
  String? endDate;
  int initialAge = 3;
  String selectedCat = "Catagory 1";
  List<String> catagories = [
    "Catagory 1",
    "Catagory 2",
    "Catagory 3",
  ];

  currentDate() {
    var date = DateTime.now();
    var formatedDate = DateFormat("dd MMM").format(date);
    return formatedDate;
  }

  currentTime(context) {
    var time = TimeOfDay.now();
    var formatedTime = time.format(context);
    return formatedTime;
  }

  selectStartDate(context) async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2023),
    );
    if (selectedDate != null) {
      startDate = DateFormat("dd MMM").format(selectedDate);
    }
    update();
  }

  selectEndDate(context) async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2023),
    );
    if (selectedDate != null) {
      endDate = DateFormat("dd MMM").format(selectedDate);
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

  File? _otherImage;
  pickOtherImage() async {
    var result =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    if (result == null) return;

    _otherImage = File(result.path);
    otherImageController.text = _otherImage.toString();
    otherImageUploadStatus = "Uploaded Successfully";
    update();
  }

  File? _coverImage;
  pickCoverImage() async {
    var result =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    if (result == null) return;

    _coverImage = File(result.path);
    coverImageController.text = _coverImage.toString();
    coverImageUploadStatus = "Uploaded Successfully";
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
    update();
  }
}
