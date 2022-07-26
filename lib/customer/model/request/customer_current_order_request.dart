class CustomerCurrentOrderRequest {
  int? _customerId;

  CustomerCurrentOrderRequest({int? customerId}) {
    if (customerId != null) {
      this._customerId = customerId;
    }
  }

  int? get customerId => _customerId;
  set customerId(int? customerId) => _customerId = customerId;

  CustomerCurrentOrderRequest.fromJson(Map<String, dynamic> json) {
    _customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this._customerId;
    return data;
  }
}
