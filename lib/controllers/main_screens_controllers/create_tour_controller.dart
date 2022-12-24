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

  String? startDate;
  String? endDate;

  currentDate() {
    var date = DateTime.now();
    var formatedDate = DateFormat("dd-MM-yyyy").format(date);
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
      startDate = DateFormat("dd-MM-yyyy").format(selectedDate);
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
      endDate = DateFormat("dd-MM-yyyy").format(selectedDate);
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
}
