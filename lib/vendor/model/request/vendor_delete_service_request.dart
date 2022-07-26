class VendorDeleteServiceRequest {
  int? _id;
  int? _vendorId;

  VendorDeleteServiceRequest({int? id, int? vendorId}) {
    if (id != null) {
      this._id = id;
    }

    if (vendorId != null) {
      this._vendorId = vendorId;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;

  int? get vendorId => _vendorId;
  set vendorId(int? vendorId) => _vendorId = vendorId;

  VendorDeleteServiceRequest.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _vendorId = json['vendor_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['vendor_id'] = this._vendorId;
    return data;
  }
}
