class SocialSignupRequest {
  String? _name;
  String? _email;
  String? _password;
  String? _firebaseToken;
  String? _isCustomer;
  String? _isVendor;
  String? _loginId;
  String? _loginType;


  SocialSignupRequest(
      {String? name,
        String? email,
        String? password,
        String? firebaseToken,
        String? isCustomer,
        String? isVendor,
        String? loginId,
        String? loginType
      }) {
    if (name != null) {
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
    if (password != null) {
      this._password = password;
    }
    if (firebaseToken != null) {
      this._firebaseToken = firebaseToken;
    }
    if (isCustomer != null) {
      this._isCustomer = isCustomer;
    }
    if (isVendor != null) {
      this._isVendor = isVendor;
    }
     if (loginId != null) {
      this._loginId = loginId;
    }
    if (loginType != null) {
      this._loginType = loginType;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get password => _password;
  set password(String? password) => _password = password;
  String? get firebaseToken => _firebaseToken;
  set firebaseToken(String? firebaseToken) => _firebaseToken = firebaseToken;
  String? get isCustomer => _isCustomer;
  set isCustomer(String? isCustomer) => _isCustomer = isCustomer;
  String? get isVendor => _isVendor;
  set isVendor(String? isVendor) => _isVendor = isVendor;
  String? get loginId => _loginId;
  set loginId(String? loginId) => _loginId = loginId;
  String? get loginType => _loginType;
  set loginType(String? loginType) => _loginType = loginType;

  SocialSignupRequest.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _email = json['email'];
    _password = json['password'];
    _firebaseToken = json['firebase_token'];
    _isCustomer = json['is_customer'];
    _isVendor = json['is_vendor'];
    _loginId = json['login_id'];
    _loginType = json['login_type'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['email'] = this._email;
    data['password'] = this._password;
    data['firebase_token'] = this._firebaseToken;
    data['is_customer'] = this._isCustomer;
    data['is_vendor'] = this._isVendor;
    data['login_id'] = this._loginId;
    data['login_type'] = this._loginType;
    return data;
  }
}
