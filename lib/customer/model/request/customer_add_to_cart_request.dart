class CustomerAddToCartRequest {
  String? _vendorId;
  int? _customerId;
  int? _vendorServiceId;
  int? _categoryId;
  String? _country;
  int? _quantity;
  double? _price;
  int? _hour;

  CustomerAddToCartRequest(
      {String? vendorId,
        int? customerId,
        int? vendorServiceId,
        int? categoryId,
        String? country,
        int? quantity,
        double? price,
        int? hour}) {
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
    if (customerId != null) {
      this._customerId = customerId;
    }
    if (vendorServiceId != null) {
      this._vendorServiceId = vendorServiceId;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (country != null) {
      this._country = country;
    }
    if (quantity != null) {
      this._quantity = quantity;
    }
    if (price != null) {
      this._price = price;
    }
    if (hour != null) {
      this._hour = hour;
    }
  }

  String? get vendorId => _vendorId;
  set vendorId(String? vendorId) => _vendorId = vendorId;
  int? get customerId => _customerId;
  set customerId(int? customerId) => _customerId = customerId;
  int? get vendorServiceId => _vendorServiceId;
  set vendorServiceId(int? vendorServiceId) =>
      _vendorServiceId = vendorServiceId;
  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;
  String? get country => _country;
  set country(String? country) => _country = country;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;
  double? get price => _price;
  set price(double? price) => _price = price;
  int? get hour => _hour;
  set hour(int? hour) => _hour = hour;

  CustomerAddToCartRequest.fromJson(Map<String, dynamic> json) {
    _vendorId = json['vendor_id'];
    _customerId = json['customer_id'];
    _vendorServiceId = json['vendor_service_id'];
    _categoryId = json['category_id'];
    _country = json['country'];
    _quantity = json['quantity'];
    _price = json['price'];
    _hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this._vendorId;
    data['customer_id'] = this._customerId;
    data['vendor_service_id'] = this._vendorServiceId;
    data['category_id'] = this._categoryId;
    data['country'] = this._country;
    data['quantity'] = this._quantity;
    data['price'] = this._price;
    data['hour'] = this._hour;
    return data;
  }
}
