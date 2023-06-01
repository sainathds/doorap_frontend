class CustomerUpdateCartItemRequest {
  int? _cartId;
  String? _vendorId;
  int? _customerId;
  String? _country;
  int? _quantity;
  double? _price;
  int? _categoryId;

  CustomerUpdateCartItemRequest(
      {int? cartId,
        String? vendorId,
        int? customerId,
        String? country,
        int? quantity,
        double? price,
        int? categoryId}) {
    if (cartId != null) {
      this._cartId = cartId;
    }
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
    if (customerId != null) {
      this._customerId = customerId;
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
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
  }

  int? get cartId => _cartId;
  set cartId(int? cartId) => _cartId = cartId;
  String? get vendorId => _vendorId;
  set vendorId(String? vendorId) => _vendorId = vendorId;
  int? get customerId => _customerId;
  set customerId(int? customerId) => _customerId = customerId;
  String? get country => _country;
  set country(String? country) => _country = country;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;
  double? get price => _price;
  set price(double? price) => _price = price;
  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;

  CustomerUpdateCartItemRequest.fromJson(Map<String, dynamic> json) {
    _cartId = json['cart_id'];
    _vendorId = json['vendor_id'];
    _customerId = json['customer_id'];
    _country = json['country'];
    _quantity = json['quantity'];
    _price = json['price'];
    _categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this._cartId;
    data['vendor_id'] = this._vendorId;
    data['customer_id'] = this._customerId;
    data['country'] = this._country;
    data['quantity'] = this._quantity;
    data['price'] = this._price;
    data['category_id'] = this._categoryId;
    return data;
  }
}
