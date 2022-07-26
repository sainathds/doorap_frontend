class VendorAcceptDeclineOrderRequest {
  int? _id;
  String? _orderId;
  String? _orderStatus;
  int? _customerId;

  VendorAcceptDeclineOrderRequest(
      {int? id, String? orderId, String? orderStatus, int? customerId}) {
    if (id != null) {
      this._id = id;
    }
    if (orderId != null) {
      this._orderId = orderId;
    }
    if (orderStatus != null) {
      this._orderStatus = orderStatus;
    }
    if (customerId != null) {
      this._customerId = customerId;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get orderId => _orderId;
  set orderId(String? orderId) => _orderId = orderId;
  String? get orderStatus => _orderStatus;
  set orderStatus(String? orderStatus) => _orderStatus = orderStatus;
  int? get customerId => _customerId;
  set customerId(int? customerId) => _customerId = customerId;

  VendorAcceptDeclineOrderRequest.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _orderStatus = json['order_status'];
    _customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['order_id'] = this._orderId;
    data['order_status'] = this._orderStatus;
    data['customer_id'] = this._customerId;
    return data;
  }
}
