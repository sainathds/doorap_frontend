class VendorAddAccountRequest {
  int? _id;
  int? _accountNo;
  String? _iBANNo;
  String? _bICCode;
  String? _bankName;

  VendorAddAccountRequest(
      {int? id,
        int? accountNo,
        String? iBANNo,
        String? bICCode,
        String? bankName}) {
    if (id != null) {
      this._id = id;
    }
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

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get accountNo => _accountNo;
  set accountNo(int? accountNo) => _accountNo = accountNo;
  String? get iBANNo => _iBANNo;
  set iBANNo(String? iBANNo) => _iBANNo = iBANNo;
  String? get bICCode => _bICCode;
  set bICCode(String? bICCode) => _bICCode = bICCode;
  String? get bankName => _bankName;
  set bankName(String? bankName) => _bankName = bankName;

  VendorAddAccountRequest.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _accountNo = json['Account_no'];
    _iBANNo = json['IBAN_no'];
    _bICCode = json['BIC_code'];
    _bankName = json['Bank_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['Account_no'] = this._accountNo;
    data['IBAN_no'] = this._iBANNo;
    data['BIC_code'] = this._bICCode;
    data['Bank_name'] = this._bankName;
    return data;
  }
}
