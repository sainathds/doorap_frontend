class VendorCustomServiceRequest {
  int? _vendorId;
  String? _customServiceImage;
  String? _customServiceName;
  int? _categoryId;
  double? _customServicePrice;
  String? _customServiceTime;
  List<String>? _customFacilityName;

  VendorCustomServiceRequest(
      {int? vendorId,
        String? customServiceImage,
        String? customServiceName,
        int? categoryId,
        double? customServicePrice,
        String? customServiceTime,
        List<String>? customFacilityName}) {
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
    if (customServiceImage != null) {
      this._customServiceImage = customServiceImage;
    }
    if (customServiceName != null) {
      this._customServiceName = customServiceName;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (customServicePrice != null) {
      this._customServicePrice = customServicePrice;
    }
    if (customServiceTime != null) {
      this._customServiceTime = customServiceTime;
    }
    if (customFacilityName != null) {
      this._customFacilityName = customFacilityName;
    }
  }

  int? get vendorId => _vendorId;
  set vendorId(int? vendorId) => _vendorId = vendorId;
  String? get customServiceImage => _customServiceImage;
  set customServiceImage(String? customServiceImage) =>
      _customServiceImage = customServiceImage;
  String? get customServiceName => _customServiceName;
  set customServiceName(String? customServiceName) =>
      _customServiceName = customServiceName;
  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;
  double? get customServicePrice => _customServicePrice;
  set customServicePrice(double? customServicePrice) =>
      _customServicePrice = customServicePrice;
  String? get customServiceTime => _customServiceTime;
  set customServiceTime(String? customServiceTime) =>
      _customServiceTime = customServiceTime;
  List<String>? get customFacilityName => _customFacilityName;
  set customFacilityName(List<String>? customFacilityName) =>
      _customFacilityName = customFacilityName;

  VendorCustomServiceRequest.fromJson(Map<String, dynamic> json) {
    _vendorId = json['vendor_id'];
    _customServiceImage = json['custom_service_image'];
    _customServiceName = json['custom_service_name'];
    _categoryId = json['category_id'];
    _customServicePrice = json['custom_service_price'];
    _customServiceTime = json['custom_service_time'];
    _customFacilityName = json['custom_facility_name'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this._vendorId;
    data['custom_service_image'] = this._customServiceImage;
    data['custom_service_name'] = this._customServiceName;
    data['category_id'] = this._categoryId;
    data['custom_service_price'] = this._customServicePrice;
    data['custom_service_time'] = this._customServiceTime;
    data['custom_facility_name'] = this._customFacilityName;
    return data;
  }
}
