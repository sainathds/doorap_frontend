class SocialLoginRequest {
  String? _email;
  String? _password;
  String? _firebaseToken;
  String? _loginId;
  String? _loginType;


  SocialLoginRequest(
      {String? email,
        String? password,
        String? firebaseToken,
        String? loginId,
        String? loginType}) {
    if (email != null) {
      this._email = email;
    }
    if (password != null) {
      this._password = password;
    }
    if (firebaseToken != null) {
      this._firebaseToken = firebaseToken;
    }
    if (loginId != null) {
      this._loginId = loginId;
    }
    if (loginType != null) {
      this._loginType = loginType;
    }

  }

  String? get email => _email;
  set email(String? email) => _email = email;
  String? get password => _password;
  set password(String? password) => _password = password;
  String? get firebaseToken => _firebaseToken;
  set firebaseToken(String? firebaseToken) => _firebaseToken = firebaseToken;
  String? get loginId => _loginId;
  set loginId(String? loginId) => _loginId = loginId;
  String? get loginType => _loginType;
  set loginType(String? loginType) => _loginType = loginType;


  SocialLoginRequest.fromJson(Map<String, dynamic> json) {
    _email = json['email'];
    _password = json['password'];
    _firebaseToken = json['firebase_token'];
    _loginId = json['login_id'];
    _loginType = json['login_type'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this._email;
    data['password'] = this._password;
    data['firebase_token'] = this._firebaseToken;
    data['login_id'] = this._loginId;
    data['login_type'] = this._loginType;
    return data;
  }
}
