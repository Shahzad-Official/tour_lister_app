import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/utils/app_snackbar.dart';
import 'package:tour_lister_app/views/main_screens/main_page.dart';

class EditProfileService {
  static updateProfile({
    required String newEmail,
    required String newPhoneNo,
    required String newUserName,
    required String dob,
    File? file,
  }) async {
    try {
      var user = FirebaseAuth.instance.currentUser!;
      String? url;
      if (file != null) {
        await FirebaseStorage.instance
            .ref("users")
            .child(user.uid)
            .child("profile")
            .putFile(file);
        url = await FirebaseStorage.instance
            .ref("users")
            .child(user.uid)
            .child("profile")
            .getDownloadURL();

        await FirebaseFirestore.instance.collection("users").doc(user.uid).set(
          {
            "email": newEmail,
            "phoneNo": newPhoneNo,
            "userName": newUserName,
            "dob": dob,
            "profile": url,
          },
          SetOptions(merge: true),
        );
      } else {
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set(
          {
            "email": newEmail,
            "phoneNo": newPhoneNo,
            "userName": newUserName,
            "dob": dob,
          },
          SetOptions(merge: true),
        );
      }

      await FirebaseAuth.instance.currentUser!.updateEmail(newEmail);
      AppSnackbar.snackBar(
          title: "Message", message: "Profile Updated SuccessFully");
      Get.offAll(() => MainPage());
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }
}
