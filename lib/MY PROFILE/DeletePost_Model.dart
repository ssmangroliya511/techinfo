class DeletePost_Model {
  int? code;
  String? business;

  DeletePost_Model({this.code, this.business});

  DeletePost_Model.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    business = json['business'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['business'] = this.business;
    return data;
  }
}
