import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/booking_model.dart';
import '../../utils/app_snackbar.dart';

class GetAllBookings {
  int notificationCount = 0;
  List<BookingModel> allBookings = [];
  getAllBookings() async {
    try {
      await FirebaseFirestore.instance.collection("booking").get().then(
        (value) {
          for (var i in value.docs) {
            allBookings.add(
              BookingModel.fromJson(
                i.data(),
              ),
            );
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      AppSnackbar.snackBar(title: "Error", message: "Server Error");
    }
  }

  getNotificationCount() async {
    try {
      await FirebaseFirestore.instance
          .collection("notifications")
          .where("status", isNotEqualTo: "seen")
          .get()
          .then(
        (value) {
          notificationCount = value.docs.length;
        },
      );
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: "Server Error");
    }
  }
}
