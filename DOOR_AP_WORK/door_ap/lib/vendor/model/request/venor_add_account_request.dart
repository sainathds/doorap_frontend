class VendorAddAccountRequest {
  int? _id;
  int? _accountNo;
  String? _accountHolderName;
  String? _ifscCode;

  VendorAddAccountRequest(
      {int? id, int? accountNo, String? accountHolderName, String? ifscCode}) {
    if (id != null) {
      this._id = id;
    }
    if (accountNo != null) {
      this._accountNo = accountNo;
    }
    if (accountHolderName != null) {
      this._accountHolderName = accountHolderName;
    }
    if (ifscCode != null) {
      this._ifscCode = ifscCode;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get accountNo => _accountNo;
  set accountNo(int? accountNo) => _accountNo = accountNo;
  String? get accountHolderName => _accountHolderName;
  set accountHolderName(String? accountHolderName) =>
      _accountHolderName = accountHolderName;
  String? get ifscCode => _ifscCode;
  set ifscCode(String? ifscCode) => _ifscCode = ifscCode;

  VendorAddAccountRequest.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _accountNo = json['account_no'];
    _accountHolderName = json['account_holder_name'];
    _ifscCode = json['ifsc_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['account_no'] = this._accountNo;
    data['account_holder_name'] = this._accountHolderName;
    data['ifsc_code'] = this._ifscCode;
    return data;
  }
}
