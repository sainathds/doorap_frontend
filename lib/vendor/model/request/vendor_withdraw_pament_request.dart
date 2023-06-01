class VendorWithdrawPaymentRequest {
  int? _vendorId;
  double? _withdrawAmount;

  VendorWithdrawPaymentRequest({int? vendorId, double? withdrawAmount}) {
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
    if (withdrawAmount != null) {
      this._withdrawAmount = withdrawAmount;
    }
  }

  int? get vendorId => _vendorId;
  set vendorId(int? vendorId) => _vendorId = vendorId;
  double? get withdrawAmount => _withdrawAmount;
  set withdrawAmount(double? withdrawAmount) =>
      _withdrawAmount = withdrawAmount;

  VendorWithdrawPaymentRequest.fromJson(Map<String, dynamic> json) {
    _vendorId = json['vendor_id'];
    _withdrawAmount = json['withdraw_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this._vendorId;
    data['withdraw_amount'] = this._withdrawAmount;
    return data;
  }
}
