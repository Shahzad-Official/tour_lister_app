import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AccountSettingsServices {
  uploadCertificateService({
    required File certificate,
  }) async {
    await FirebaseStorage.instance
        .ref("listers")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("certificate")
        .putFile(certificate);
    var certificateUrl = await FirebaseStorage.instance
        .ref("listers")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("certificate")
        .getDownloadURL();
    await FirebaseFirestore.instance
        .collection("listers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(
      {
        "certificate": certificateUrl,
      },
      SetOptions(
        merge: true,
      ),
    );
  }
}
