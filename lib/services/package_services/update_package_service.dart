import 'package:cloud_firestore/cloud_firestore.dart';

class UpdatePackageService {
  updatePackage(
    String packageId,
  ) async {
    await FirebaseFirestore.instance
        .collection("packages")
        .doc(packageId)
        .update({});
  }
}
