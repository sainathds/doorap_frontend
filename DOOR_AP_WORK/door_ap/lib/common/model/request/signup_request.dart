class SignupRequest {
  String? _name;
  String? _email;
  String? _password;
  String? _firebaseToken;
  String? _isCustomer;
  String? _isVendor;

  SignupRequest(
      {String? name,
        String? email,
        String? password,
        String? firebaseToken,
        String? isCustomer,
        String? isVendor}) {
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

  SignupRequest.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _email = json['email'];
    _password = json['password'];
    _firebaseToken = json['firebase_token'];
    _isCustomer = json['is_customer'];
    _isVendor = json['is_vendor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['email'] = this._email;
    data['password'] = this._password;
    data['firebase_token'] = this._firebaseToken;
    data['is_customer'] = this._isCustomer;
    data['is_vendor'] = this._isVendor;
    return data;
  }
}
