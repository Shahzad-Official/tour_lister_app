import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tour_lister_app/models/lister_profile/profile_model.dart';

class GetUserData {
  ProfileModel userProfile = ProfileModel();
  Future<ProfileModel> getUserData(String uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((value) {
      if (value.data() == null) {
        userProfile = ProfileModel();
      } else {
        userProfile = ProfileModel.fromJson(value.data()!);
      }
    });
    return userProfile;
  }
}
