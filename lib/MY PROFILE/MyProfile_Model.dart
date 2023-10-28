// ignore_for_file: camel_case_types

class MyProfile_Model {
  int? code;
  Business? business;

  MyProfile_Model({this.code, this.business});

  MyProfile_Model.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    business = json['business'] != null
        ? Business.fromJson(json['business'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    if (this.business != null) {
      data['business'] = this.business!.toJson();
    }
    return data;
  }
}

class Business {
  List<MyProfile>? myProfile;

  Business({this.myProfile});

  Business.fromJson(Map<String, dynamic> json) {
    if (json['My Profile'] != null) {
      myProfile = <MyProfile>[];
      json['My Profile'].forEach((v) {
        myProfile!.add(new MyProfile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myProfile != null) {
      data['My Profile'] = this.myProfile!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyProfile {
  dynamic userId;
  dynamic otp;
  dynamic mobile;
  dynamic email;
  dynamic uname;
  dynamic createdAt;

  MyProfile(
      {this.userId,
        this.otp,
        this.mobile,
        this.email,
        this.uname,
        this.createdAt});

  MyProfile.fromJson(Map<String, dynamic> json) {
    userId = json['User_id'];
    otp = json['Otp'];
    mobile = json['Mobile'];
    email = json['Email'];
    uname = json['Uname'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User_id'] = this.userId;
    data['Otp'] = this.otp;
    data['Mobile'] = this.mobile;
    data['Email'] = this.email;
    data['Uname'] = this.uname;
    data['created_at'] = this.createdAt;
    return data;
  }
}
