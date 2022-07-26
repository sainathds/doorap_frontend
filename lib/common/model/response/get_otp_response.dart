class GetOtpResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  GetOtpResponse({int? status, String? msg, Payload? payload}) {
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

  GetOtpResponse.fromJson(Map<dynamic, dynamic> json) {
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


  Payload({int? otp, String? signupMsg, String? isVendor, String? isCustomer}) {
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
  }

  int? get otp => _otp;
  set otp(int? otp) => _otp = otp;

  String? get signupMsg => _signupMsg;
  set signupMsg(String? signupMsg) => _signupMsg = signupMsg;

  String? get isVendor => _isVendor;
  set isVendor(String? isVendor) => _isVendor = isVendor;

  String? get isCustomer => _isCustomer;
  set isCustomer(String? isCustomer) => _isCustomer = isCustomer;

  Payload.fromJson(Map<String, dynamic> json) {
    _otp = json['otp'];
    _signupMsg = json['signup_msg'];
    _isVendor = json['is_vendor'];
    _isCustomer = json['is_customer'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this._otp;
    data['signup_msg'] = this._signupMsg;
    data['is_vendor'] = this._isVendor;
    data['is_customer'] = this._isCustomer;

    return data;
  }
}
