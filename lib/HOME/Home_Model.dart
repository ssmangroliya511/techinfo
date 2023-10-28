class HomeAllPost_Model {
  int? code;
  Business? business;

  HomeAllPost_Model({this.code, this.business});

  HomeAllPost_Model.fromJson(Map<String, dynamic> json) {
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
  String? uImage;
  String? uName;

  Post(
      {this.postId,
        this.pTitle,
        this.pDesc,
        this.status,
        this.createdAt,
        this.source,
        this.mediaType,
        this.uImage,
        this.uName});

  Post.fromJson(Map<String, dynamic> json) {
    postId = json['Post_Id'];
    pTitle = json['p_title'];
    pDesc = json['p_desc'];
    status = json['status'];
    createdAt = json['created_at'];
    source = json['source'];
    mediaType = json['media_type'];
    uImage = json['u_image'];
    uName = json['u_name'];
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
    data['u_image'] = this.uImage;
    data['u_name'] = this.uName;
    return data;
  }
}
