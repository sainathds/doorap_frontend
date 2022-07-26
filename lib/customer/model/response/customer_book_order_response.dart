class CustomerBookOrderResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  CustomerBookOrderResponse({int? status, String? msg, Payload? payload}) {
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
  Payload? get payload => _payload;
  set payload(Payload? payload) => _payload = payload;

  CustomerBookOrderResponse.fromJson(Map<dynamic, dynamic> json) {
    _status = json['status'];
    _msg = json['msg'];
    _payload =
    json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['msg'] = this._msg;
    if (this._payload != null) {
      data['payload'] = this._payload!.toJson();
    }
    return data;
  }
}

class Payload {
  int? _id;
  String? _orderId;

  Payload({int? id, String? orderId}) {
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

  Payload.fromJson(Map<String, dynamic> json) {
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
