class ProfileModel {
  String? profile;
  String? dateOfBirth;
  String? userName;
  String? email;
  String? phoneNo;
  String? token;

  ProfileModel({
    this.profile,
    this.dateOfBirth,
    this.userName,
    this.email,
    this.phoneNo,
    this.token,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    profile = json['profile'];
    dateOfBirth = json['dateOfBirth'];
    userName = json['userName'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['profile'] = profile;
    data['dateOfBirth'] = dateOfBirth;
    data['userName'] = userName;
    data['email'] = email;
    data['phoneNo'] = phoneNo;
    data['token'] = token;
    return data;
  }
}
