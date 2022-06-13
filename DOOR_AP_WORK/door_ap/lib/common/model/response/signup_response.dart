class SignupResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  SignupResponse({int? status, String? msg, Payload? payload}) {
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

  SignupResponse.fromJson(Map<dynamic, dynamic> json) {
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
  String? _password;
  ApiToken? _apiToken;

  Payload(
      {int? id,
        String? email,
        String? firebaseToken,
        String? password,
        ApiToken? apiToken}) {
    if (id != null) {
      this._id = id;
    }
    if (email != null) {
      this._email = email;
    }
    if (firebaseToken != null) {
      this._firebaseToken = firebaseToken;
    }
    if (password != null) {
      this._password = password;
    }
    if (apiToken != null) {
      this._apiToken = apiToken;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get firebaseToken => _firebaseToken;
  set firebaseToken(String? firebaseToken) => _firebaseToken = firebaseToken;
  String? get password => _password;
  set password(String? password) => _password = password;
  ApiToken? get apiToken => _apiToken;
  set apiToken(ApiToken? apiToken) => _apiToken = apiToken;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _email = json['email'];
    _firebaseToken = json['firebase_token'];
    _password = json['password'];
    _apiToken = json['api_token'] != null
        ? new ApiToken.fromJson(json['api_token'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['email'] = this._email;
    data['firebase_token'] = this._firebaseToken;
    data['password'] = this._password;
    if (this._apiToken != null) {
      data['api_token'] = this._apiToken!.toJson();
    }
    return data;
  }
}

class ApiToken {
  String? _refresh;
  String? _access;

  ApiToken({String? refresh, String? access}) {
    if (refresh != null) {
      this._refresh = refresh;
    }
    if (access != null) {
      this._access = access;
    }
  }

  String? get refresh => _refresh;
  set refresh(String? refresh) => _refresh = refresh;
  String? get access => _access;
  set access(String? access) => _access = access;

  ApiToken.fromJson(Map<String, dynamic> json) {
    _refresh = json['refresh'];
    _access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this._refresh;
    data['access'] = this._access;
    return data;
  }
}
