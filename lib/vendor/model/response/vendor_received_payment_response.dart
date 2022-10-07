class VendorReceivedPaymentResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  VendorReceivedPaymentResponse(
      {int? status, String? msg, List<Payload>? payload}) {
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

  VendorReceivedPaymentResponse.fromJson(Map<dynamic, dynamic> json) {
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
  String? _fkVendorFullName;
  String? _paymentReceiveDate;
  double? _paymentAmount;

  Payload(
      {String? fkVendorFullName,
        String? paymentReceiveDate,
        double? paymentAmount}) {
    if (fkVendorFullName != null) {
      this._fkVendorFullName = fkVendorFullName;
    }
    if (paymentReceiveDate != null) {
      this._paymentReceiveDate = paymentReceiveDate;
    }
    if (paymentAmount != null) {
      this._paymentAmount = paymentAmount;
    }
  }

  String? get fkVendorFullName => _fkVendorFullName;
  set fkVendorFullName(String? fkVendorFullName) =>
      _fkVendorFullName = fkVendorFullName;
  String? get paymentReceiveDate => _paymentReceiveDate;
  set paymentReceiveDate(String? paymentReceiveDate) =>
      _paymentReceiveDate = paymentReceiveDate;
  double? get paymentAmount => _paymentAmount;
  set paymentAmount(double? paymentAmount) => _paymentAmount = paymentAmount;

  Payload.fromJson(Map<String, dynamic> json) {
    _fkVendorFullName = json['fk_vendor__full_name'];
    _paymentReceiveDate = json['payment_receive_date'];
    _paymentAmount = json['payment_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_vendor__full_name'] = this._fkVendorFullName;
    data['payment_receive_date'] = this._paymentReceiveDate;
    data['payment_amount'] = this._paymentAmount;
    return data;
  }
}
