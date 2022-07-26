class CustomerRemoveCartItemRequest {
  int? _cartId;
  int? _customerId;
  String? _offerId;
  String? _appliedId;
  String? _appliedStatus;

  CustomerRemoveCartItemRequest(
      {int? cartId,
        int? customerId,
        String? offerId,
        String? appliedId,
        String? appliedStatus}) {
    if (cartId != null) {
      this._cartId = cartId;
    }
    if (customerId != null) {
      this._customerId = customerId;
    }
    if (offerId != null) {
      this._offerId = offerId;
    }
    if (appliedId != null) {
      this._appliedId = appliedId;
    }
    if (appliedStatus != null) {
      this._appliedStatus = appliedStatus;
    }
  }

  int? get cartId => _cartId;
  set cartId(int? cartId) => _cartId = cartId;
  int? get customerId => _customerId;
  set customerId(int? customerId) => _customerId = customerId;
  String? get offerId => _offerId;
  set offerId(String? offerId) => _offerId = offerId;
  String? get appliedId => _appliedId;
  set appliedId(String? appliedId) => _appliedId = appliedId;
  String? get appliedStatus => _appliedStatus;
  set appliedStatus(String? appliedStatus) => _appliedStatus = appliedStatus;

  CustomerRemoveCartItemRequest.fromJson(Map<String, dynamic> json) {
    _cartId = json['cart_id'];
    _customerId = json['customer_id'];
    _offerId = json['offer_id'];
    _appliedId = json['applied_id'];
    _appliedStatus = json['applied_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this._cartId;
    data['customer_id'] = this._customerId;
    data['offer_id'] = this._offerId;
    data['applied_id'] = this._appliedId;
    data['applied_status'] = this._appliedStatus;
    return data;
  }
}
