class VendorSelectedFacilityRequest {
  String? _vendorId;
  String? _serviceId;

  VendorSelectedFacilityRequest({String? vendorId, String? serviceId}) {
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
    if (serviceId != null) {
      this._serviceId = serviceId;
    }
  }

  String? get vendorId => _vendorId;
  set vendorId(String? vendorId) => _vendorId = vendorId;
  String? get serviceId => _serviceId;
  set serviceId(String? serviceId) => _serviceId = serviceId;

  VendorSelectedFacilityRequest.fromJson(Map<String, dynamic> json) {
    _vendorId = json['vendor_id'];
    _serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this._vendorId;
    data['service_id'] = this._serviceId;
    return data;
  }
}
