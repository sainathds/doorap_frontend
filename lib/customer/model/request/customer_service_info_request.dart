class CustomerServiceInfoRequest {
  int? _vendorId;
  int? _categoryId;
  int? _serviceId;
  int? _venderServiceId;

  CustomerServiceInfoRequest(
      {int? vendorId, int? categoryId, int? serviceId, int? venderServiceId}) {
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (serviceId != null) {
      this._serviceId = serviceId;
    }
    if (venderServiceId != null) {
      this._venderServiceId = venderServiceId;
    }
  }

  int? get vendorId => _vendorId;
  set vendorId(int? vendorId) => _vendorId = vendorId;
  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;
  int? get serviceId => _serviceId;
  set serviceId(int? serviceId) => _serviceId = serviceId;
  int? get venderServiceId => _venderServiceId;
  set venderServiceId(int? venderServiceId) =>
      _venderServiceId = venderServiceId;

  CustomerServiceInfoRequest.fromJson(Map<String, dynamic> json) {
    _vendorId = json['vendor_id'];
    _categoryId = json['category_id'];
    _serviceId = json['service_id'];
    _venderServiceId = json['vender_service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this._vendorId;
    data['category_id'] = this._categoryId;
    data['service_id'] = this._serviceId;
    data['vender_service_id'] = this._venderServiceId;
    return data;
  }
}
