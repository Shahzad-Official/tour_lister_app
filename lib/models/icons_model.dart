import 'package:cloud_firestore/cloud_firestore.dart';

class IconsModel {
  String? iconImage;
  String? iconName;

  IconsModel({this.iconImage, this.iconName});

  IconsModel.fromJson(Map<String, dynamic> json) {
    iconImage = json['IconImage'];
    iconName = json['IconName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['IconImage'] = iconImage;
    data['IconName'] = iconName;
    return data;
  }
}
