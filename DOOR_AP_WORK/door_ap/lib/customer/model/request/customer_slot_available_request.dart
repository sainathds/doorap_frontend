class CustomerSlotAvailableRequest {
  int? _vendorId;
  int? _categoryId;

  CustomerSlotAvailableRequest({int? vendorId, int? categoryId}) {
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
  }

  int? get vendorId => _vendorId;
  set vendorId(int? vendorId) => _vendorId = vendorId;
  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;

  CustomerSlotAvailableRequest.fromJson(Map<String, dynamic> json) {
    _vendorId = json['vendor_id'];
    _categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this._vendorId;
    data['category_id'] = this._categoryId;
    return data;
  }
}
