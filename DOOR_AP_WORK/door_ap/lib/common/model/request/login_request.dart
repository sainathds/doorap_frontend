class LoginRequest {
  String? _email;
  String? _password;
    String? _firebaseToken;

  LoginRequest(
      {String? email,
        String? password,
        String? firebaseToken,}) {
    if (email != null) {
      this._email = email;
    }
    if (password != null) {
      this._password = password;
    }
    if (firebaseToken != null) {
      this._firebaseToken = firebaseToken;
    }
  }

  String? get email => _email;
  set email(String? email) => _email = email;
  String? get password => _password;
  set password(String? password) => _password = password;
  String? get firebaseToken => _firebaseToken;
  set firebaseToken(String? firebaseToken) => _firebaseToken = firebaseToken;

  LoginRequest.fromJson(Map<String, dynamic> json) {
    _email = json['email'];
    _password = json['password'];
    _firebaseToken = json['firebase_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this._email;
    data['password'] = this._password;
    data['firebase_token'] = this._firebaseToken;
    return data;
  }
}
