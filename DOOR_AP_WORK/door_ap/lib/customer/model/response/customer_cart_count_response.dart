class CustomerCartCountResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  CustomerCartCountResponse({int? status, String? msg, Payload? payload}) {
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

  CustomerCartCountResponse.fromJson(Map<dynamic, dynamic> json) {
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
  int? _itemCount;
  int? _categoryId;
  int? _vendorId;

  Payload({int? itemCount, int? categoryId, int? vendorId}) {
    if (itemCount != null) {
      this._itemCount = itemCount;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (vendorId != null) {
      this._vendorId = vendorId;
    }
  }

  int? get itemCount => _itemCount;
  set itemCount(int? itemCount) => _itemCount = itemCount;
  int? get categoryId => _categoryId;
  set categoryId(int? categoryId) => _categoryId = categoryId;
  int? get vendorId => _vendorId;
  set vendorId(int? vendorId) => _vendorId = vendorId;

  Payload.fromJson(Map<String, dynamic> json) {
    _itemCount = json['item_count'];
    _categoryId = json['category_id'];
    _vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_count'] = this._itemCount;
    data['category_id'] = this._categoryId;
    data['vendor_id'] = this._vendorId;

    return data;
  }
}
