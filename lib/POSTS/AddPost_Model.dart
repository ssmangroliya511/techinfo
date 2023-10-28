// ignore_for_file: camel_case_types

class AddPost_Model {
  int? code;
  String? message;
  Business? business;

  AddPost_Model({this.code, this.message, this.business});

  AddPost_Model.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? description;
  String? media;
  String? userID;
  String? mediaType;

  Business(
      {this.title, this.description, this.media, this.userID, this.mediaType});

  Business.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    description = json['Description'];
    media = json['Media'];
    userID = json['User ID'];
    mediaType = json['Media Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Media'] = this.media;
    data['User ID'] = this.userID;
    data['Media Type'] = this.mediaType;
    return data;
  }
}
