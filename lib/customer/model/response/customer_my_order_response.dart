class CustomerMyOrderResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  CustomerMyOrderResponse({int? status, String? msg, List<Payload>? payload}) {
    if (status != null) {
      this._status = status;
    }
    if (msg != null) {
      this._msg = msg;
    }
    if (payload != null) {
      this._payload = payload;
    }
  }

  int? get status => _status;
  set status(int? status) => _status = status;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  List<Payload>? get payload => _payload;
  set payload(List<Payload>? payload) => _payload = payload;

  CustomerMyOrderResponse.fromJson(Map<dynamic, dynamic> json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['payload'] != null) {
      _payload = <Payload>[];
      json['payload'].forEach((v) {
        _payload!.add(new Payload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['msg'] = this._msg;
    if (this._payload != null) {
      data['payload'] = this._payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payload {
  int? _id;
  int? _fkCustomer;
  String? _fkCustomerName;
  String? _orderId;
  int? _fkVendor;
  int? _fkVendorFkUserId;
  String? _fkVendorFullName;
  String? _bookingDate;
  double? _totalAmount;
  String? _orderStatus;
  String? _bookingStartTime;
  int? _quantity;

  Payload(
      {int? id,
        int? fkCustomer,
        String? fkCustomerName,
        String? orderId,
        int? fkVendor,
        int? fkVendorFkUserId,
        String? fkVendorFullName,
        String? bookingDate,
        double? totalAmount,
        String? orderStatus,
        String? bookingStartTime,
        int? quantity}) {
    if (id != null) {
      this._id = id;
    }
    if (fkCustomer != null) {
      this._fkCustomer = fkCustomer;
    }
    if (fkCustomerName != null) {
      this._fkCustomerName = fkCustomerName;
    }
    if (orderId != null) {
      this._orderId = orderId;
    }
    if (fkVendor != null) {
      this._fkVendor = fkVendor;
    }
    if (fkVendorFkUserId != null) {
      this._fkVendorFkUserId = fkVendorFkUserId;
    }
    if (fkVendorFullName != null) {
      this._fkVendorFullName = fkVendorFullName;
    }
    if (bookingDate != null) {
      this._bookingDate = bookingDate;
    }
    if (totalAmount != null) {
      this._totalAmount = totalAmount;
    }
    if (orderStatus != null) {
      this._orderStatus = orderStatus;
    }
    if (bookingStartTime != null) {
      this._bookingStartTime = bookingStartTime;
    }
    if (quantity != null) {
      this._quantity = quantity;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get fkCustomer => _fkCustomer;
  set fkCustomer(int? fkCustomer) => _fkCustomer = fkCustomer;
  String? get fkCustomerName => _fkCustomerName;
  set fkCustomerName(String? fkCustomerName) =>
      _fkCustomerName = fkCustomerName;
  String? get orderId => _orderId;
  set orderId(String? orderId) => _orderId = orderId;
  int? get fkVendor => _fkVendor;
  set fkVendor(int? fkVendor) => _fkVendor = fkVendor;
  int? get fkVendorFkUserId => _fkVendorFkUserId;
  set fkVendorFkUserId(int? fkVendorFkUserId) =>
      _fkVendorFkUserId = fkVendorFkUserId;
  String? get fkVendorFullName => _fkVendorFullName;
  set fkVendorFullName(String? fkVendorFullName) =>
      _fkVendorFullName = fkVendorFullName;
  String? get bookingDate => _bookingDate;
  set bookingDate(String? bookingDate) => _bookingDate = bookingDate;
  double? get totalAmount => _totalAmount;
  set totalAmount(double? totalAmount) => _totalAmount = totalAmount;
  String? get orderStatus => _orderStatus;
  set orderStatus(String? orderStatus) => _orderStatus = orderStatus;
  String? get bookingStartTime => _bookingStartTime;
  set bookingStartTime(String? bookingStartTime) => _bookingStartTime = bookingStartTime;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fkCustomer = json['fk_customer'];
    _fkCustomerName = json['fk_customer__name'];
    _orderId = json['order_id'];
    _fkVendor = json['fk_vendor'];
    _fkVendorFkUserId = json['fk_vendor__fk_user__id'];
    _fkVendorFullName = json['fk_vendor__full_name'];
    _bookingDate = json['booking_date'];
    _totalAmount = json['total_amount'];
    _orderStatus = json['order_status'];
    _bookingStartTime = json['booking_start_time'];
    _quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fk_customer'] = this._fkCustomer;
    data['fk_customer__name'] = this._fkCustomerName;
    data['order_id'] = this._orderId;
    data['fk_vendor'] = this._fkVendor;
    data['fk_vendor__full_name'] = this._fkVendorFullName;
    data['booking_date'] = this._bookingDate;
    data['total_amount'] = this._totalAmount;
    data['order_status'] = this._orderStatus;
    data['booking_start_time'] = this._bookingStartTime;
    data['quantity'] = this._quantity;
    data['fk_vendor__fk_user__id'] = this._fkVendorFkUserId;
    return data;
  }
}
