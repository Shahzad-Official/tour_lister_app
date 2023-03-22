import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditPackageController extends GetxController {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  int tourStayDays = 0;

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
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: endDate!,
      firstDate: endDate!,
      lastDate: DateTime(2025),
    );
    if (selectedDate != null) {
      endDate = selectedDate;
      var formatedDate = DateFormat("dd MMM").format(selectedDate);
      endDateController.text = formatedDate;
    }
    update();
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
          startTimeController.text.isNotEmpty) {}
      update();
    }
  }
}
