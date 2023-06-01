class VendorGetBankResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  VendorGetBankResponse({int? status, String? msg, List<Payload>? payload}) {
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
  List<Payload>? get payload => _payload;
  set payload(List<Payload>? payload) => _payload = payload;

  VendorGetBankResponse.fromJson(Map<dynamic, dynamic> json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['payload'] != null) {
      _payload = <Payload>[];
      json['payload'].forEach((v) {
        _payload!.add(new Payload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['msg'] = this._msg;
    if (this._payload != null) {
      data['payload'] = this._payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payload {
  String? _accountNo;
  String? _iBANNo;
  String? _bICCode;
  String? _bankName;

  Payload(
      {String? accountNo, String? iBANNo, String? bICCode, String? bankName}) {
    if (accountNo != null) {
      this._accountNo = accountNo;
    }
    if (iBANNo != null) {
      this._iBANNo = iBANNo;
    }
    if (bICCode != null) {
      this._bICCode = bICCode;
    }
    if (bankName != null) {
      this._bankName = bankName;
    }
  }

  String? get accountNo => _accountNo;
  set accountNo(String? accountNo) => _accountNo = accountNo;
  String? get iBANNo => _iBANNo;
  set iBANNo(String? iBANNo) => _iBANNo = iBANNo;
  String? get bICCode => _bICCode;
  set bICCode(String? bICCode) => _bICCode = bICCode;
  String? get bankName => _bankName;
  set bankName(String? bankName) => _bankName = bankName;

  Payload.fromJson(Map<String, dynamic> json) {
    _accountNo = json['Account_no'];
    _iBANNo = json['IBAN_no'];
    _bICCode = json['BIC_code'];
    _bankName = json['Bank_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Account_no'] = this._accountNo;
    data['IBAN_no'] = this._iBANNo;
    data['BIC_code'] = this._bICCode;
    data['Bank_name'] = this._bankName;
    return data;
  }
}
