import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/utils/app_snackbar.dart';
import 'package:tour_lister_app/views/main_screens/main_page.dart';

class DeletePackageService {
  deletePackage(String packageId) async {
    String filesPath = "$packageId/";
    try {
      await FirebaseStorage.instance
          .ref("packages_files")
          .child(filesPath)
          .child("thumbnail")
          .delete()
          .then(
        (value) async {
          await FirebaseStorage.instance
              .ref("packages_files")
              .child(filesPath)
              .child("otherImages")
              .delete()
              .then(
            (value) async {
              await FirebaseStorage.instance
                  .ref("packages_files")
                  .child(filesPath)
                  .child("termsAndConditions")
                  .delete()
                  .then(
                (value) async {
                  await FirebaseFirestore.instance
                      .collection("packages")
                      .doc(packageId)
                      .delete();
                },
              );
            },
          );
        },
      );
      AppSnackbar.snackBar(
          title: "Error", message: "Package Deleted Successfully!");
      Get.deleteAll();

      Get.offAll(
        () => MainPage(
          currentIndex: 1,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
