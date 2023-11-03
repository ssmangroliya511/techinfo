class Notification_Model {
  int? code;
  Business? business;

  Notification_Model({this.code, this.business});

  Notification_Model.fromJson(Map<String, dynamic> json) {
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
  List<Notifications>? notifications;

  Business({this.notifications});

  Business.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? title;
  String? description;
  String? image;
  String? createdAt;
  String? userImage;

  Notifications(
      {this.title,
        this.description,
        this.image,
        this.createdAt,
        this.userImage});

  Notifications.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    userImage = json['UserImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['UserImage'] = this.userImage;
    return data;
  }
}
