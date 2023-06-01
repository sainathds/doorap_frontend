class CustomerCompleteOrderRequest {
  int? _id;
  String? _orderId;
  int? _vendorId;

  CustomerCompleteOrderRequest({int? id, String? orderId, int? vendorId}) {
    if (id != null) {
      this._id = id;
    }
    if (orderId != null) {
      this._orderId = orderId;
    }
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get orderId => _orderId;
  set orderId(String? orderId) => _orderId = orderId;
  int? get vendorId => _vendorId;
  set vendorId(int? vendorId) => _vendorId = vendorId;

  CustomerCompleteOrderRequest.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['order_id'] = this._orderId;
    data['vendor_id'] = this._vendorId;
    return data;
  }
}
