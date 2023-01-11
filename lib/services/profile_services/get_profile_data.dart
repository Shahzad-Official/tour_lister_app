import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tour_lister_app/models/lister_profile/profile_model.dart';

class GetProfileData {
  ProfileModel profileModel = ProfileModel();
  Future<ProfileModel> getProfileData() async {
    var res = await FirebaseFirestore.instance
        .collection("listers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    profileModel = ProfileModel.fromJson(res.data() as Map<String, dynamic>);

    return profileModel;
  }

  getStreamedData() {
    var res = FirebaseFirestore.instance
        .collection("listers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .asStream();
    return res;
  }
}
