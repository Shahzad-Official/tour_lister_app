import 'package:cloud_firestore/cloud_firestore.dart';

class IconsModel {
  Timestamp? createdOn;
  String? iconImage;
  String? iconName;

  IconsModel({this.createdOn, this.iconImage, this.iconName});

  IconsModel.fromJson(Map<String, dynamic> json) {
    createdOn = json['created_on'];
    iconImage = json['IconImage'];
    iconName = json['IconName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_on'] = this.createdOn;
    data['IconImage'] = this.iconImage;
    data['IconName'] = this.iconName;
    return data;
  }
}
