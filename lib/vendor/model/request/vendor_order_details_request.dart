class VendorOrderDetailsRequest {
  int? _id;
  String? _orderId;

  VendorOrderDetailsRequest({int? id, String? orderId}) {
    if (id != null) {
      this._id = id;
    }
    if (orderId != null) {
      this._orderId = orderId;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get orderId => _orderId;
  set orderId(String? orderId) => _orderId = orderId;

  VendorOrderDetailsRequest.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['order_id'] = this._orderId;
    return data;
  }
}
