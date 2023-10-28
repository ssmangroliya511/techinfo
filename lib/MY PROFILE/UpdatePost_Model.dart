class UpdatePost_Model {
  int? code;
  String? message;
  Data? data;

  UpdatePost_Model({this.code, this.message, this.data});

  UpdatePost_Model.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? postTitle;
  String? postDescription;
  String? mediaType;
  Null? source;

  Data({this.postTitle, this.postDescription, this.mediaType, this.source});

  Data.fromJson(Map<String, dynamic> json) {
    postTitle = json['Post title'];
    postDescription = json['Post Description'];
    mediaType = json['Media type'];
    source = json['Source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Post title'] = this.postTitle;
    data['Post Description'] = this.postDescription;
    data['Media type'] = this.mediaType;
    data['Source'] = this.source;
    return data;
  }
}
