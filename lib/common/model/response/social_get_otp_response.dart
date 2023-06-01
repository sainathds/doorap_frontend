class SocialGetOtpResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  SocialGetOtpResponse({int? status, String? msg, Payload? payload}) {
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

  SocialGetOtpResponse.fromJson(Map<dynamic, dynamic> json) {
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
  int? _otp;
  String? _signupMsg;
  String? _isCustomer;
  String? _isVendor;
  String? _loginId;
  String? _loginType;



  Payload({int? otp, String? signupMsg, String? isVendor, String? isCustomer, String? loginId, String? loginType}) {
    if (otp != null) {
      this._otp = otp;
    }
    if(signupMsg != null){
      this._signupMsg == signupMsg;
    }
    if(isVendor != null){
      this._isVendor == isVendor;
    }
    if(isCustomer != null){
      this._isCustomer == isCustomer;
    }

    if (loginId != null) {
      this._loginId = loginId;
    }
    if (loginType != null) {
      this._loginType = loginType;
    }
  }

  int? get otp => _otp;
  set otp(int? otp) => _otp = otp;

  String? get signupMsg => _signupMsg;
  set signupMsg(String? signupMsg) => _signupMsg = signupMsg;

  String? get isVendor => _isVendor;
  set isVendor(String? isVendor) => _isVendor = isVendor;

  String? get isCustomer => _isCustomer;
  set isCustomer(String? isCustomer) => _isCustomer = isCustomer;

  String? get loginId => _loginId;
  set loginId(String? loginId) => _loginId = loginId;

  String? get loginType => _loginType;
  set loginType(String? loginType) => _loginType = loginType;

  Payload.fromJson(Map<String, dynamic> json) {
    _otp = json['otp'];
    _signupMsg = json['signup_msg'];
    _isVendor = json['is_vendor'];
    _isCustomer = json['is_customer'];
    _loginId = json['login_id'];
    _loginType = json['login_type'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this._otp;
    data['signup_msg'] = this._signupMsg;
    data['is_vendor'] = this._isVendor;
    data['is_customer'] = this._isCustomer;
    data['login_id'] = this._loginId;
    data['login_type'] = this._loginType;

    return data;
  }
}
