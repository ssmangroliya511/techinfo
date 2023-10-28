class VerifyOtp_Model {
  int? code;
  String? message;
  Business? business;

  VerifyOtp_Model({this.code, this.message, this.business});

  VerifyOtp_Model.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    business = json['business'] != null
        ? new Business.fromJson(json['business'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.business != null) {
      data['business'] = this.business!.toJson();
    }
    return data;
  }
}

class Business {
  int? userId;
  String? uname;
  String? mob;
  String? email;
  String? image;
  String? city;
  String? state;

  Business(
      {this.userId,
        this.uname,
        this.mob,
        this.email,
        this.image,
        this.city,
        this.state});

  Business.fromJson(Map<String, dynamic> json) {
    userId = json['User_id'];
    uname = json['Uname'];
    mob = json['Mob'];
    email = json['Email'];
    image = json['Image'];
    city = json['City'];
    state = json['State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User_id'] = this.userId;
    data['Uname'] = this.uname;
    data['Mob'] = this.mob;
    data['Email'] = this.email;
    data['Image'] = this.image;
    data['City'] = this.city;
    data['State'] = this.state;
    return data;
  }
}
