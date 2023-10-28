class UpdateProfile_Model {
  int? code;
  String? business;
  Data? data;

  UpdateProfile_Model({this.code, this.business, this.data});

  UpdateProfile_Model.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    business = json['business'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['business'] = this.business;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? mobile;
  String? email;
  String? image;
  String? city;
  String? state;

  Data({this.name, this.mobile, this.email, this.image, this.city, this.state});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    mobile = json['Mobile'];
    email = json['Email'];
    image = json['image'];
    city = json['City'];
    state = json['State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Mobile'] = this.mobile;
    data['Email'] = this.email;
    data['image'] = this.image;
    data['City'] = this.city;
    data['State'] = this.state;
    return data;
  }
}
