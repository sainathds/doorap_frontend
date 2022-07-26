class CustomerPromocodeRequest {
  int? _customerId;
  String? _coupon;
  String? _countryName;
  int? _categoryId;
  String? _cancelStatus;
  String? _appliedId;

  CustomerPromocodeRequest(
      {int? customerId,
        String? coupon,
        String? countryName,
        int? categoryId,
        String? cancelStatus,
        String? appliedId}) {
    if (customerId != null) {
      this._customerId = customerId;
    }
    if (coupon != null) {
      this._coupon = coupon;
    }
    if (countryName != null) {
      this._countryName = countryName;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (cancelStatus != null) {
      this._cancelStatus = cancelStatus;
    }
    if (appliedId != null) {
      this._appliedId = appliedId;
    }
  }

  int? get customerId => _customerId;
  set customerId(int? customerId) => _customerId = customerId;
  String? get coupon => _coupon;
  set coupon(String? coupon) => _coupon = coupon;
  String? get countryName => _countryName;
  set countryName(String? countryName) => _countryName = countryName;
  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;
  String? get cancelStatus => _cancelStatus;
  set cancelStatus(String? cancelStatus) => _cancelStatus = cancelStatus;
  String? get appliedId => _appliedId;
  set appliedId(String? appliedId) => _appliedId = appliedId;

  CustomerPromocodeRequest.fromJson(Map<String, dynamic> json) {
    _customerId = json['customer_id'];
    _coupon = json['coupon'];
    _countryName = json['country_name'];
    _categoryId = json['category_id'];
    _cancelStatus = json['cancel_status'];
    _appliedId = json['applied_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this._customerId;
    data['coupon'] = this._coupon;
    data['country_name'] = this._countryName;
    data['category_id'] = this._categoryId;
    data['cancel_status'] = this._cancelStatus;
    data['applied_id'] = this._appliedId;
    return data;
  }
}
