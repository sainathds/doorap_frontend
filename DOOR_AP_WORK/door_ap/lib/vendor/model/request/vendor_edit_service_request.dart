class VendorEditServiceRequest {
  String? _dataId;
  String? _venderId;
  String? _categoryId;
  String? _serviceId;
  String? _facilityIdList;
  String? _price;
  String? _hour;

  VendorEditServiceRequest(
      {String? dataId,
        String? venderId,
        String? categoryId,
        String? serviceId,
        String? facilityIdList,
        String? price,
        String? hour}) {
    if (dataId != null) {
      this._dataId = dataId;
    }
    if (venderId != null) {
      this._venderId = venderId;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (serviceId != null) {
      this._serviceId = serviceId;
    }
    if (facilityIdList != null) {
      this._facilityIdList = facilityIdList;
    }
    if (price != null) {
      this._price = price;
    }
    if (hour != null) {
      this._hour = hour;
    }
  }

  String? get dataId => _dataId;
  set dataId(String? dataId) => _dataId = dataId;
  String? get venderId => _venderId;
  set venderId(String? venderId) => _venderId = venderId;
  String? get categoryId => _categoryId;
  set categoryId(String? categoryId) => _categoryId = categoryId;
  String? get serviceId => _serviceId;
  set serviceId(String? serviceId) => _serviceId = serviceId;
  String? get facilityIdList => _facilityIdList;
  set facilityIdList(String? facilityIdList) =>
      _facilityIdList = facilityIdList;
  String? get price => _price;
  set price(String? price) => _price = price;
  String? get hour => _hour;
  set hour(String? hour) => _hour = hour;

  VendorEditServiceRequest.fromJson(Map<String, dynamic> json) {
    _dataId = json['data_id'];
    _venderId = json['vender_id'];
    _categoryId = json['category_id'];
    _serviceId = json['service_id'];
    _facilityIdList = json['facility_id_list'];
    _price = json['price'];
    _hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data_id'] = this._dataId;
    data['vender_id'] = this._venderId;
    data['category_id'] = this._categoryId;
    data['service_id'] = this._serviceId;
    data['facility_id_list'] = this._facilityIdList;
    data['price'] = this._price;
    data['hour'] = this._hour;
    return data;
  }
}
