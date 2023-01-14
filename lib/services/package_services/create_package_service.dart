import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/services/location_services/get_location_service.dart';
import 'package:tour_lister_app/utils/app_snackbar.dart';
import 'package:tour_lister_app/views/main_screens/main_page.dart';

class CreatePackageService {
  final GetLocationService _locationService = Get.put(GetLocationService());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  createPackage({
    required String packageName,
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
    required String lattitude,
    required String longitude,
    String? extraInfo,
  }) async {
    // try {
    await _firestore
        .collection("listers")
        .doc(_firebaseAuth.currentUser!.uid)
        .collection("packages")
        .doc(packageName)
        .set({
      "created_on": DateTime.now(),
      "listerId": _firebaseAuth.currentUser!.uid,
      "packageName": packageName,
      "location": {
        "lattitude": lattitude,
        "longitude": longitude,
      },
      "startTime": startTime,
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
    });
    var package = await _firestore
        .collection("listers")
        .doc(_firebaseAuth.currentUser!.uid)
        .collection("packages")
        .doc(packageName)
        .get();
    await _firebaseStorage
        .ref("listers")
        .child(_firebaseAuth.currentUser!.uid)
        .child("packages")
        .child(package.reference.id)
        .child("otherImage")
        .putFile(otherImage);
    var otherImageUrl = await _firebaseStorage
        .ref("listers")
        .child(_firebaseAuth.currentUser!.uid)
        .child("packages")
        .child(package.reference.id)
        .child("otherImage")
        .getDownloadURL();
    await _firebaseStorage
        .ref("listers")
        .child(_firebaseAuth.currentUser!.uid)
        .child("packages")
        .child(package.reference.id)
        .child("coverImage")
        .putFile(coverImage);
    var coverImageUrl = await _firebaseStorage
        .ref("listers")
        .child(_firebaseAuth.currentUser!.uid)
        .child("packages")
        .child(package.reference.id)
        .child("coverImage")
        .getDownloadURL();
    await _firebaseStorage
        .ref("listers")
        .child(_firebaseAuth.currentUser!.uid)
        .child("packages")
        .child(package.reference.id)
        .child("termsAndConditionsFile")
        .putFile(termsAndCondition);
    var termsAndConditionsUrl = await _firebaseStorage
        .ref("listers")
        .child(_firebaseAuth.currentUser!.uid)
        .child("packages")
        .child(package.reference.id)
        .child("termsAndConditionsFile")
        .getDownloadURL();
    await _firestore
        .collection("listers")
        .doc(_firebaseAuth.currentUser!.uid)
        .collection("packages")
        .doc(packageName)
        .set(
      {
        "id": package.id,
        "otherImage": otherImageUrl,
        "coverImage": coverImageUrl,
        "terms": termsAndConditionsUrl,
      },
      SetOptions(merge: true),
    );
    AppSnackbar.snackBar(
        title: "Message", message: "Package has been CreatedSuccessfully");
    Get.offAll(
      () => MainPage(
        currentIndex: 1,
      ),
    );
    await createPackageGlobally(
      lattitude: lattitude,
      longitude: longitude,
      packageName: packageName,
      startTime: startTime,
      endTime: endTime,
      startDate: startDate,
      endDate: endDate,
      startPrice: startPrice,
      endPrice: endPrice,
      cuttOffTime: cuttOffTime,
      otherImageUrl: otherImageUrl,
      coverImageUrl: coverImageUrl,
      noOfPersonsInPackage: noOfPersonsInPackage,
      dangerRating: dangerRating,
      ageSuitability: ageSuitability,
      typeOfTour: typeOfTour,
      foodServed: foodServed,
      termsAndConditionsUrl: termsAndConditionsUrl,
      packageId: package.id,
      extraInfo: extraInfo,
    );
    // } catch (e) {
    //   print(e);
    //   AppSnackbar.snackBar(title: "Error", message: e.toString());
    // }
  }

  createPackageGlobally({
    required String packageName,
    required String startTime,
    required String endTime,
    required String startDate,
    required String endDate,
    required String startPrice,
    required String endPrice,
    required String cuttOffTime,
    required String otherImageUrl,
    required String coverImageUrl,
    required String noOfPersonsInPackage,
    required String dangerRating,
    required String ageSuitability,
    required String typeOfTour,
    required String foodServed,
    required String termsAndConditionsUrl,
    required String packageId,
    required String lattitude,
    required String longitude,
    String? extraInfo,
  }) async {
    await _firestore.collection("packages").doc(packageName).set({
      "created_on": DateTime.now(),
      "listerId": _firebaseAuth.currentUser!.uid,
      "packageName": packageName,
      "location": {
        "lattitude": lattitude,
        "longitude": longitude,
      },
      "startTime": startTime,
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
      "id": packageId,
      "otherImage": otherImageUrl,
      "coverImage": coverImageUrl,
      "terms": termsAndConditionsUrl,
    });
  }
}
