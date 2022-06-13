class VendorSetServicesRequest {
  int? _vendorId;
  int? _categoryId;
  int? _serviceId;
  String? _facilityIdList;
  double? _price;
  String? _hour;

  VendorSetServicesRequest(
      {
        int? vendorId,
        int? categoryId,
        int? serviceId,
        String? facilityIdList,
        double? price,
        String? hour}) {

    if (vendorId != null) {
      this._vendorId = vendorId;
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

  int? get vendorId => _vendorId;
  set vendorId(int? vendorId) => _vendorId = vendorId;
  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;
  int? get serviceId => _serviceId;
  set serviceId(int? serviceId) => _serviceId = serviceId;
  String? get facilityIdList => _facilityIdList;
  set facilityIdList(String? facilityIdList) =>
      _facilityIdList = facilityIdList;
  double? get price => _price;
  set price(double? price) => _price = price;
  String? get hour => _hour;
  set hour(String? hour) => _hour = hour;

  VendorSetServicesRequest.fromJson(Map<String, dynamic> json) {
    _vendorId = json['vender_id'];
    _categoryId = json['category_id'];
    _serviceId = json['service_id'];
    _facilityIdList = json['facility_id_list'].cast<int>();
    _price = json['price'];
    _hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vender_id'] = this._vendorId;
    data['category_id'] = this._categoryId;
    data['service_id'] = this._serviceId;
    data['facility_id_list'] = this._facilityIdList;
    data['price'] = this._price;
    data['hour'] = this._hour;
    return data;
  }
}

