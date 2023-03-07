import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tour_lister_app/models/icons_model.dart';
import 'package:tour_lister_app/utils/app_snackbar.dart';

class GetIcons {
  List<IconsModel> iconsData = [];
  Future<List<IconsModel>> getIcons() async {
    iconsData.clear();
    try {
      await FirebaseFirestore.instance.collection("icons").get().then(
        (value) {
          for (var i in value.docs) {
            iconsData.add(
              IconsModel.fromJson(
                i.data(),
              ),
            );
          }
        },
      );
    } catch (e) {
      AppSnackbar.snackBar(title: "Error", message: "Server Error");
    }
    return iconsData;
  }
}
