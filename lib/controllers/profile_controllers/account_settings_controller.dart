import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tour_lister_app/services/profile_services/account_settings_services.dart';

class AccountSettingsController extends GetxController {
  String? fileName;
  bool isLoading = false;
  getProfile() async {
    var res = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    String profile = res.data()!['profile'];
    return profile;
  }

  uploadCertificate() async {
    isLoading = true;
    update();
    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'doc'],
    );
    if (result != null) {
      fileName = result.files.first.name;

      await AccountSettingsServices().uploadCertificateService(
        certificate: File(result.files.first.path!),
      );
      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();

    getProfile();
  }
}
