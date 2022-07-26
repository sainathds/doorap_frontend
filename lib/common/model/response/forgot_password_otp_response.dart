class ForgotPasswordOtpResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  ForgotPasswordOtpResponse({int? status, String? msg, Payload? payload}) {
    if (status != null) {
      this._status = status;
    }
    if (msg != null) {
      this._msg = msg;
    }
    if (payload != null) {
      this._payload = payload;
    }
  }

  int? get status => _status;
  set status(int? status) => _status = status;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  Payload? get payload => _payload;
  set payload(Payload? payload) => _payload = payload;

  ForgotPasswordOtpResponse.fromJson(Map<dynamic, dynamic> json) {
    _status = json['status'];
    _msg = json['msg'];
    _payload =
    json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['msg'] = this._msg;
    if (this._payload != null) {
      data['payload'] = this._payload!.toJson();
    }
    return data;
  }
}

class Payload {
  int? _id;
  int? _otp;

  Payload({int? id, int? otp}) {
    if (id != null) {
      this._id = id;
    }
    if (otp != null) {
      this._otp = otp;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get otp => _otp;
  set otp(int? otp) => _otp = otp;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['otp'] = this._otp;
    return data;
  }
}
