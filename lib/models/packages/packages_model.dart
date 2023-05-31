import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? name;
  String? startDate;
  String? endDate;
  String? location;
  String? startPrice;
  String? endPrice;
  String? cuttoffTime;
  String? allowedNoOfBookings;
  String? dangerRating;
  String? ageSuitability;
  String? catagory;
  String? termsAndConditions;
  String? coverImage;
  bool? isLive;
  List<Users>? users;

  EventModel(
      {this.name,
      this.startDate,
      this.endDate,
      this.location,
      this.startPrice,
      this.endPrice,
      this.cuttoffTime,
      this.allowedNoOfBookings,
      this.dangerRating,
      this.ageSuitability,
      this.catagory,
      this.termsAndConditions,
      this.coverImage,
      this.isLive,
      this.users});

  EventModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    location = json['location'];
    startPrice = json['startPrice'];
    endPrice = json['endPrice'];
    cuttoffTime = json['cuttoffTime'];
    allowedNoOfBookings = json['allowedNoOfBookings'];
    dangerRating = json['dangerRating'];
    ageSuitability = json['ageSuitability'];
    catagory = json['catagory'];
    termsAndConditions = json['termsAndConditions'];
    coverImage = json['coverImage'];
    isLive = json['isLive'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['location'] = location;
    data['startPrice'] = startPrice;
    data['endPrice'] = endPrice;
    data['cuttoffTime'] = cuttoffTime;
    data['allowedNoOfBookings'] = allowedNoOfBookings;
    data['dangerRating'] = dangerRating;
    data['ageSuitability'] = ageSuitability;
    data['catagory'] = catagory;
    data['termsAndConditions'] = termsAndConditions;
    data['coverImage'] = coverImage;
    data['isLive'] = isLive;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? name;
  String? pic;
  String? email;
  String? phoneNo;
  String? gender;
  String? dOB;

  Users({this.name, this.pic, this.email, this.phoneNo, this.gender, this.dOB});

  Users.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    pic = json['pic'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    gender = json['gender'];
    dOB = json['DOB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['pic'] = pic;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['gender'] = gender;
    data['DOB'] = dOB;
    return data;
  }
}

class PackagesModel {
  String? startPrice;
  List<String>? otherImage;
  String? endDate;
  String? typeOfTour;
  String? cuttOffTime;
  String? ageSuitability;
  String? packageId;
  String? description;
  String? endPrice;
  String? category;
  String? termsAndConditions;
  bool? isLive;
  String? noOfPersonsInPackage;
  Timestamp? createdOn;
  String? startTime;
  Location? location;
  String? listerId;
  String? dangerRating;
  String? packageName;
  String? endTime;
  String? startDate;
  List<Inclusions>? inclusions;
  String? status;
  String? extraInfo;
  String? thumbnailUrl;
  String? availablePackages;

  PackagesModel({
    this.startPrice,
    this.otherImage,
    this.endDate,
    this.typeOfTour,
    this.cuttOffTime,
    this.ageSuitability,
    this.packageId,
    this.description,
    this.endPrice,
    this.termsAndConditions,
    this.isLive,
    this.noOfPersonsInPackage,
    this.createdOn,
    this.startTime,
    this.location,
    this.listerId,
    this.dangerRating,
    this.packageName,
    this.endTime,
    this.startDate,
    this.inclusions,
    this.status,
    this.extraInfo,
    this.thumbnailUrl,
    this.availablePackages,
    this.category,
  });

  PackagesModel.fromJson(Map<String, dynamic> json) {
    startPrice = json['startPrice'];
    otherImage = json['otherImage'].cast<String>();
    endDate = json['endDate'];
    category = json['category'];
    typeOfTour = json['typeOfTour'];
    cuttOffTime = json['cuttOffTime'];
    ageSuitability = json['ageSuitability'];
    packageId = json['packageId'];
    description = json['description'];
    endPrice = json['endPrice'];
    termsAndConditions = json['termsAndConditions'];
    isLive = json['isLive'];
    noOfPersonsInPackage = json['noOfPersonsInPackage'];
    createdOn = json['created_on'];
    startTime = json['startTime'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    listerId = json['listerId'];
    dangerRating = json['dangerRating'];
    packageName = json['packageName'];
    endTime = json['endTime'];
    startDate = json['startDate'];
    if (json['inclusions'] != null) {
      inclusions = <Inclusions>[];
      json['inclusions'].forEach((v) {
        inclusions!.add(Inclusions.fromJson(v));
      });
    }
    status = json['status'];
    extraInfo = json['extraInfo'];
    thumbnailUrl = json['thumbnailUrl'];
    availablePackages = json['availablePackages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['startPrice'] = startPrice;
    data['otherImage'] = otherImage;
    data['endDate'] = endDate;
    data['category'] = category;
    data['typeOfTour'] = typeOfTour;
    data['cuttOffTime'] = cuttOffTime;
    data['ageSuitability'] = ageSuitability;
    data['packageId'] = packageId;
    data['description'] = description;
    data['endPrice'] = endPrice;
    data['termsAndConditions'] = termsAndConditions;
    data['isLive'] = isLive;
    data['noOfPersonsInPackage'] = noOfPersonsInPackage;
    data['created_on'] = createdOn;
    data['startTime'] = startTime;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['listerId'] = listerId;
    data['dangerRating'] = dangerRating;
    data['packageName'] = packageName;
    data['endTime'] = endTime;
    data['startDate'] = startDate;
    if (inclusions != null) {
      data['inclusions'] = inclusions!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['extraInfo'] = extraInfo;
    data['thumbnailUrl'] = thumbnailUrl;
    return data;
  }
}

class Location {
  String? address;
  double? latitude;
  double? longitude;

  Location({this.address, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Inclusions {
  String? iconImage;
  String? iconName;
  int? inclusionCount;

  Inclusions({this.iconImage, this.iconName, this.inclusionCount});

  Inclusions.fromJson(Map<String, dynamic> json) {
    iconImage = json['iconImage'];
    iconName = json['iconName'];
    inclusionCount = json['inclusionCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['iconImage'] = iconImage;
    data['iconName'] = iconName;
    data['inclusionCount'] = inclusionCount;
    return data;
  }
}
