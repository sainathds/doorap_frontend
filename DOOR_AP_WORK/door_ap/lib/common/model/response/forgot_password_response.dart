class ForgotPasswordResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  ForgotPasswordResponse({int? status, String? msg, Payload? payload}) {
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

  ForgotPasswordResponse.fromJson(Map<dynamic, dynamic> json) {
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
  String? _email;
  String? _firebaseToken;

  Payload({int? id, String? email, String? firebaseToken}) {
    if (id != null) {
      this._id = id;
    }
    if (email != null) {
      this._email = email;
    }
    if (firebaseToken != null) {
      this._firebaseToken = firebaseToken;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get firebaseToken => _firebaseToken;
  set firebaseToken(String? firebaseToken) => _firebaseToken = firebaseToken;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _email = json['email'];
    _firebaseToken = json['firebase_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['email'] = this._email;
    data['firebase_token'] = this._firebaseToken;
    return data;
  }
}
