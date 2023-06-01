class VendorBalancePaymentResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  VendorBalancePaymentResponse({int? status, String? msg, Payload? payload}) {
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

  VendorBalancePaymentResponse.fromJson(Map<dynamic, dynamic> json) {
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
  double? _totalBalance;
  String? _withdrawMsg;
  bool? _withdrawRequestStatus;

  Payload(
      {double? totalBalance,
        String? withdrawMsg,
        bool? withdrawRequestStatus}) {
    if (totalBalance != null) {
      this._totalBalance = totalBalance;
    }
    if (withdrawMsg != null) {
      this._withdrawMsg = withdrawMsg;
    }
    if (withdrawRequestStatus != null) {
      this._withdrawRequestStatus = withdrawRequestStatus;
    }
  }

  double? get totalBalance => _totalBalance;
  set totalBalance(double? totalBalance) => _totalBalance = totalBalance;
  String? get withdrawMsg => _withdrawMsg;
  set withdrawMsg(String? withdrawMsg) => _withdrawMsg = withdrawMsg;
  bool? get withdrawRequestStatus => _withdrawRequestStatus;
  set withdrawRequestStatus(bool? withdrawRequestStatus) =>
      _withdrawRequestStatus = withdrawRequestStatus;

  Payload.fromJson(Map<String, dynamic> json) {
    _totalBalance = json['total_balance'];
    _withdrawMsg = json['withdraw_msg'];
    _withdrawRequestStatus = json['withdraw_request_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_balance'] = this._totalBalance;
    data['withdraw_msg'] = this._withdrawMsg;
    data['withdraw_request_status'] = this._withdrawRequestStatus;
    return data;
  }
}
