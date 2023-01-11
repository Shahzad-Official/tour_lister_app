import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../main_page_controller/main_page_controller.dart';

class AccountSettingsController extends GetxController {
  String? fileName;
  getProfile() async {
    var res = await FirebaseFirestore.instance
        .collection("listers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    String profile = res.data()!['profile'];
    return profile;
  }

  uploadCertificate() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'doc'],
    );
    if (result != null) {
      fileName = result.files.first.name;

      update();
    }
  }

  @override
  void onInit() {
    super.onInit();

    getProfile();
  }
}
