// ignore_for_file: camel_case_types

class MyPosts_Model {
  int? code;
  Business? business;

  MyPosts_Model({this.code, this.business});

  MyPosts_Model.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    business = json['business'] != null
        ? new Business.fromJson(json['business'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.business != null) {
      data['business'] = this.business!.toJson();
    }
    return data;
  }
}

class Business {
  List<Post>? post;

  Business({this.post});

  Business.fromJson(Map<String, dynamic> json) {
    if (json['Post'] != null) {
      post = <Post>[];
      json['Post'].forEach((v) {
        post!.add(new Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.post != null) {
      data['Post'] = this.post!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Post {
  int? postId;
  String? pTitle;
  String? pDesc;
  String? status;
  String? createdAt;
  String? source;
  String? mediaType;

  Post(
      {this.postId,
        this.pTitle,
        this.pDesc,
        this.status,
        this.createdAt,
        this.source,
        this.mediaType});

  Post.fromJson(Map<String, dynamic> json) {
    postId = json['Post_Id'];
    pTitle = json['p_title'];
    pDesc = json['p_desc'];
    status = json['status'];
    createdAt = json['created_at'];
    source = json['source'];
    mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Post_Id'] = this.postId;
    data['p_title'] = this.pTitle;
    data['p_desc'] = this.pDesc;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['source'] = this.source;
    data['media_type'] = this.mediaType;
    return data;
  }
}
