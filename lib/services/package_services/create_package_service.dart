import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/utils/app_snackbar.dart';

import '../../views/main_screens/main_page.dart';

class CreatePackageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  createPackage({
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
    required File termsAndCondition,
    required double latitude,
    required double longitude,
    required String description,
    required List inclusions,
    String? extraInfo,
  }) async {
    try {
      await _firestore.collection("packages").add(
        {
          "packageId": "",
          "created_on": DateTime.now(),
          "listerId": _firebaseAuth.currentUser!.uid,
          "packageName": packageName,
          "location": {
            "address": address,
            "latitude": latitude,
            "longitude": longitude,
          },
          "inclusions": inclusions,
          "startTime": startTime,
          "isLive": false,
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
          "description": description,
          "extraInfo": extraInfo,
        },
      ).then(
        (value) async {
          await _firestore.collection("packages").doc(value.id).update(
            {
              "packageId": value.id,
            },
          );

          await _firebaseStorage
              .ref("packages_files")
              .child(value.id)
              .child("thumbnail")
              .putFile(coverImage)
              .then(
            (p0) async {
              var thumbnailUrl = await p0.ref.getDownloadURL();
              await _firestore.collection("packages").doc(value.id).set(
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
              .child(value.id)
              .child("otherImages")
              .putFile(otherImage)
              .then(
            (p0) async {
              var otherImage = await p0.ref.getDownloadURL();
              await _firestore.collection("packages").doc(value.id).set(
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
              .child(value.id)
              .child("termsAndConditions")
              .putFile(termsAndCondition)
              .then(
            (p0) async {
              var terms = await p0.ref.getDownloadURL();
              await _firestore.collection("packages").doc(value.id).set(
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
