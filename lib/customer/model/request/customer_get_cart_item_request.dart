class CustomerGetCartItemRequest {
  int? _customerId;
  int? _categoryId;
  String? _countryName;

  CustomerGetCartItemRequest(
      {int? customerId, int? categoryId, String? countryName}) {
    if (customerId != null) {
      this._customerId = customerId;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (countryName != null) {
      this._countryName = countryName;
    }
  }

  int? get customerId => _customerId;
  set customerId(int? customerId) => _customerId = customerId;
  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;
  String? get countryName => _countryName;
  set countryName(String? countryName) => _countryName = countryName;

  CustomerGetCartItemRequest.fromJson(Map<String, dynamic> json) {
    _customerId = json['customer_id'];
    _categoryId = json['category_id'];
    _countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this._customerId;
    data['category_id'] = this._categoryId;
    data['country_name'] = this._countryName;
    return data;
  }
}
