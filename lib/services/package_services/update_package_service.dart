import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../utils/app_snackbar.dart';
import '../../views/main_screens/main_page.dart';

class UpdatePackageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  updatePackage(
    String packageId, {
    required String packageName,
    required String address,
    required String startTime,
    required String endTime,
    required String startDate,
    required String endDate,
    required String startPrice,
    required String endPrice,
    required String cuttOffTime,
    required File otherImage,
    required File coverImage,
    required String noOfPersonsInPackage,
    required String dangerRating,
    required String ageSuitability,
    required String typeOfTour,
    required String foodServed,
    required File termsAndCondition,
    required double latitude,
    required double longitude,
    String? extraInfo,
  }) async {
    try {
      await _firestore.collection("packages").doc(packageId).update({
        "packageId": "",
        "created_on": DateTime.now(),
        "listerId": _firebaseAuth.currentUser!.uid,
        "packageName": packageName,
        "location": {
          "address": address,
          "latitude": latitude,
          "longitude": longitude,
        },
        "startTime": startTime,
        "isLive": false,
        "status": "draft",
        "endTime": endTime,
        "startDate": startDate,
        "endDate": endDate,
        "startPrice": startPrice,
        "endPrice": endPrice,
        "cuttOffTime": cuttOffTime,
        "noOfPersonsInPackage": noOfPersonsInPackage,
        "dangerRating": dangerRating,
        "ageSuitability": ageSuitability,
        "typeOfTour": typeOfTour,
        "foodServed": foodServed,
        "extraInfo": extraInfo,
      }).then(
        (value) async {
          await _firebaseStorage
              .ref("packages_files")
              .child(packageId)
              .child("thumbnail")
              .putFile(coverImage)
              .then(
            (p0) async {
              var thumbnailUrl = await p0.ref.getDownloadURL();
              await _firestore.collection("packages").doc(packageId).set(
                {
                  "thumbnailUrl": thumbnailUrl,
                },
                SetOptions(
                  merge: true,
                ),
              );
            },
          );

          await _firebaseStorage
              .ref("packages_files")
              .child(packageId)
              .child("otherImages")
              .putFile(otherImage)
              .then(
            (p0) async {
              var otherImage = await p0.ref.getDownloadURL();
              await _firestore.collection("packages").doc(packageId).set(
                {
                  "otherImage": [
                    otherImage,
                  ],
                },
                SetOptions(
                  merge: true,
                ),
              );
            },
          );
          await _firebaseStorage
              .ref("packages_files")
              .child(packageId)
              .child("termsAndConditions")
              .putFile(termsAndCondition)
              .then(
            (p0) async {
              var terms = await p0.ref.getDownloadURL();
              await _firestore.collection("packages").doc(packageId).set(
                {
                  "termsAndConditions": terms,
                },
                SetOptions(
                  merge: true,
                ),
              );
            },
          );
        },
      );
      AppSnackbar.snackBar(
          title: "Message", message: "Package created Successfully");
      Get.offAll(() => MainPage());
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }
}
