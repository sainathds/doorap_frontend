class CustomerVendorsRequest {
  String? _categoryId;
  int? _customerId;
  String? _lat;
  String? _lng;

  CustomerVendorsRequest(
      {String? categoryId, int? customerId, String? lat, String? lng}) {
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (customerId != null) {
      this._customerId = customerId;
    }
    if (lat != null) {
      this._lat = lat;
    }
    if (lng != null) {
      this._lng = lng;
    }
  }

  String? get categoryId => _categoryId;
  set categoryId(String? categoryId) => _categoryId = categoryId;
  int? get customerId => _customerId;
  set customerId(int? customerId) => _customerId = customerId;
  String? get lat => _lat;
  set lat(String? lat) => _lat = lat;
  String? get lng => _lng;
  set lng(String? lng) => _lng = lng;

  CustomerVendorsRequest.fromJson(Map<String, dynamic> json) {
    _categoryId = json['category_id'];
    _customerId = json['customer_id'];
    _lat = json['lat'];
    _lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this._categoryId;
    data['customer_id'] = this._customerId;
    data['lat'] = this._lat;
    data['lng'] = this._lng;
    return data;
  }
}
