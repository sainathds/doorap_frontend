class VendorOrderListRequest {
  int? _vendorId;
  String? _orderStatus;

  VendorOrderListRequest({int? vendorId, String? orderStatus}) {
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
    if (orderStatus != null) {
      this._orderStatus = orderStatus;
    }
  }

  int? get vendorId => _vendorId;
  set vendorId(int? vendorId) => _vendorId = vendorId;
  String? get orderStatus => _orderStatus;
  set orderStatus(String? orderStatus) => _orderStatus = orderStatus;

  VendorOrderListRequest.fromJson(Map<String, dynamic> json) {
    _vendorId = json['vendor_id'];
    _orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this._vendorId;
    data['order_status'] = this._orderStatus;
    return data;
  }
}
