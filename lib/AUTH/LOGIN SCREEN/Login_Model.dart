// ignore_for_file: camel_case_types

class SendOtp_Model {
  int? code;
  String? message;
  int? oTP;

  SendOtp_Model({this.code, this.message, this.oTP});

  SendOtp_Model.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    oTP = json['OTP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['OTP'] = this.oTP;
    return data;
  }
}


