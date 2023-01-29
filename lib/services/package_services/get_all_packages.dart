import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tour_lister_app/models/packages/packages_model.dart';

class GetAllPackages {
  Stream<List<PackagesModel>> getPackagesList() {
    return FirebaseFirestore.instance
        .collection('packages')
        .where("listerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        // .orderBy(
        //   "created_on",
        // )
        .snapshots()
        .map(
          (snapShot) => snapShot.docs
              .map(
                (document) => PackagesModel.fromJson(
                  document.data(),
                ),
              )
              .toList(),
        );
  }
}
