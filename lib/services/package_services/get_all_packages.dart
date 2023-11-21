import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tour_lister_app/models/packages/packages_model.dart';

class GetAllPackages {
  List<PackagesModel> allPackages = [];
  Future<List<PackagesModel>> getAllPackages() async {
    allPackages.clear();
    await FirebaseFirestore.instance.collection("packages").where("listerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid).orderBy("created_on").get().then(
      (value) {
        for (var i in value.docs) {
          allPackages.add(
            PackagesModel.fromJson(
              i.data(),
            ),
          );
        }
      },
    );
    return allPackages;
  }

  PackagesModel packageData = PackagesModel();
  Future<PackagesModel> getPackageData(tourId) async {
    await FirebaseFirestore.instance.collection("packages").doc(tourId).get().then(
          (value) => packageData = PackagesModel.fromJson(
            value.data()!,
          ),
        );

    return packageData;
  }

  tourRating(tourId) async {
    double rating = 0.0;
    await FirebaseFirestore.instance
        .collection("reviews")
        .where(
          "tourId",
          isEqualTo: tourId,
        )
        .get()
        .then((value) {
      List ratings = [];
      for (var i in value.docs) {
        ratings.add(i.data()['rating']);
      }
      rating = ratings.fold(0.0, (p, e) => p + e);
    });
    return rating;
  }
}
