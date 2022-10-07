class VendorBalancePaymentRequest {
  int? _vendorId;

  VendorBalancePaymentRequest({int? vendorId}) {
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
  }

  int? get vendorId => _vendorId;
  set vendorId(int? vendorId) => _vendorId = vendorId;

  VendorBalancePaymentRequest.fromJson(Map<String, dynamic> json) {
    _vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this._vendorId;
    return data;
  }
}
