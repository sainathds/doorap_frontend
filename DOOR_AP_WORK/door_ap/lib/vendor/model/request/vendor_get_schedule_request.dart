class VendorGetScheduleRequest {
  String? _vendorId;

  VendorGetScheduleRequest({String? vendorId}) {
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
  }

  String? get vendorId => _vendorId;
  set vendorId(String? vendorId) => _vendorId = vendorId;

  VendorGetScheduleRequest.fromJson(Map<String, dynamic> json) {
    _vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this._vendorId;
    return data;
  }
}
