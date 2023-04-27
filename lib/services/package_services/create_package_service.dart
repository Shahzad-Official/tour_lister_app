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
    required List<File> otherImage,
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
    required String availablePackages,
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
          "availablePackages": availablePackages,
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
          List<String> otherImagesUrl = [];
          for (int i = 0; i < otherImage.length; i++) {
            await _firebaseStorage
                .ref("packages_files")
                .child(value.id)
                .child("otherImages$i")
                .putFile(otherImage[i])
                .then(
              (p0) async {
                var url = await p0.ref.getDownloadURL();
                otherImagesUrl.add(url);
              },
            );
          }
          await _firestore.collection("packages").doc(value.id).set(
            {
              "otherImage": otherImagesUrl,
            },
            SetOptions(
              merge: true,
            ),
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
      Get.deleteAll();
      Get.offAll(() => MainPage());
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }

  updatePackage(
    String packageId, {
    String? packageName,
    String? address,
    String? startTime,
    String? endTime,
    String? startDate,
    String? endDate,
    String? startPrice,
    String? endPrice,
    String? cuttOffTime,
    List<File>? otherImage,
    List<String>? otherImageUrl,
    File? coverImage,
    String? noOfPersonsInPackage,
    String? dangerRating,
    String? ageSuitability,
    String? typeOfTour,
    File? termsAndCondition,
    double? latitude,
    double? longitude,
    String? description,
    List? inclusions,
    String? extraInfo,
    required String availablePackages,
  }) async {
    try {
      await _firestore.collection("packages").doc(packageId).update(
        {
          "packageName": packageName,
          "location": {
            "address": address,
            "latitude": latitude,
            "longitude": longitude,
          },
          "inclusions": inclusions,
          "listerId": _firebaseAuth.currentUser!.uid,
          "startTime": startTime,
          "isLive": true,
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
          "otherImage": otherImageUrl,
          "availablePackages": availablePackages,
        },
      ).then(
        (value) async {
          if (coverImage != null) {
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
          } else if (otherImage != null) {
            List<String> allOtherImages = [];
            List.generate(
              otherImage.length,
              (index) async {
                await _firebaseStorage
                    .ref("packages_files")
                    .child(packageId)
                    .child("otherImages$index")
                    .putFile(otherImage[index])
                    .then(
                  (p0) async {
                    var url = await p0.ref.getDownloadURL();
                    allOtherImages.add(url);
                  },
                );
              },
            );
            await _firestore.collection("packages").doc(packageId).set(
              {
                "otherImage": allOtherImages,
              },
              SetOptions(
                merge: true,
              ),
            );
          } else if (termsAndCondition != null) {
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
          }
        },
      );
      AppSnackbar.snackBar(
          title: "Message", message: "Package created Successfully");
      Get.deleteAll();
      Get.offAll(() => MainPage());
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }

  duplicatePackage({
    String? packageName,
    String? address,
    String? startTime,
    String? endTime,
    String? startDate,
    String? endDate,
    String? startPrice,
    String? endPrice,
    String? cuttOffTime,
    List<File>? otherImage,
    List<String>? otherImageUrl,
    File? coverImage,
    String? coverImageUrl,
    String? noOfPersonsInPackage,
    String? dangerRating,
    String? ageSuitability,
    String? typeOfTour,
    File? termsAndCondition,
    String? termsFileUrl,
    double? latitude,
    double? longitude,
    String? description,
    List? inclusions,
    String? extraInfo,
    required String availablePackages,
  }) async {
    try {
      await _firestore.collection("packages").add(
        {
          "packageName": packageName,
          "created_on": DateTime.now(),
          "location": {
            "address": address,
            "latitude": latitude,
            "longitude": longitude,
          },
          "inclusions": inclusions,
          "listerId": _firebaseAuth.currentUser!.uid,
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
          "packageId": "",
          "otherImage": otherImageUrl,
          "thumbnailUrl": coverImageUrl,
          "termsAndConditions": termsFileUrl,
          "availablePackages": availablePackages,
        },
      ).then(
        (value) async {
          await _firestore.collection("packages").doc(value.id).update(
            {
              "packageId": value.id,
            },
          );
          if (coverImage != null) {
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
          } else if (otherImage != null) {
            List<String> allOtherImages = [];
            List.generate(
              otherImage.length,
              (index) async {
                await _firebaseStorage
                    .ref("packages_files")
                    .child(value.id)
                    .child("otherImages$index")
                    .putFile(otherImage[index])
                    .then(
                  (p0) async {
                    var url = await p0.ref.getDownloadURL();
                    allOtherImages.add(url);
                  },
                );
              },
            );
            await _firestore.collection("packages").doc(value.id).set(
              {
                "otherImage": allOtherImages,
              },
              SetOptions(
                merge: true,
              ),
            );
          } else if (termsAndCondition != null) {
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
          }
        },
      );
      AppSnackbar.snackBar(
          title: "Message", message: "Package duplicated Successfully");
      Get.deleteAll();
      Get.offAll(() => MainPage());
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: e.toString());
    }
  }
}
