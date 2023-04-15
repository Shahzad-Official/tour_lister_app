import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_lister_app/models/notification_model.dart';

import '../../models/booking_model.dart';
import '../../utils/app_snackbar.dart';

class GetAllBookings {
  int notificationCount = 0;
  List<BookingModel> allBookings = [];
  getAllBookings() async {
    try {
      await FirebaseFirestore.instance
          .collection("booking")
          .where("lister_id", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then(
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

  List<NotificationModel> allNotifications = [];
  getNotifications() async {
    allNotifications.clear();
    try {
      await FirebaseFirestore.instance.collection("notifications").get().then(
        (value) {
          for (var i in value.docs) {
            allNotifications.add(
              NotificationModel.fromJson(
                i.data(),
              ),
            );
          }
        },
      );
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: "Server Error");
    }
  }

  seenNotification(String noteId) async {
    try {
      await FirebaseFirestore.instance
          .collection("notifications")
          .doc(noteId)
          .update(
        {
          "status": "seen",
        },
      );
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }
}
