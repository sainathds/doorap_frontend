class CustomerPaymentIntentResponse {
  int? _status;
  String? _msg;
  Payload? _payload;

  CustomerPaymentIntentResponse({int? status, String? msg, Payload? payload}) {
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

  CustomerPaymentIntentResponse.fromJson(Map<dynamic, dynamic> json) {
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
  String? _customerId;
  String? _clientSecret;
  String? _ephemeralKey;
  String? _paymentIntentId;

  Payload(
      {String? customerId,
        String? clientSecret,
        String? ephemeralKey,
        String? paymentIntentId}) {
    if (customerId != null) {
      this._customerId = customerId;
    }
    if (clientSecret != null) {
      this._clientSecret = clientSecret;
    }
    if (ephemeralKey != null) {
      this._ephemeralKey = ephemeralKey;
    }
    if (paymentIntentId != null) {
      this._paymentIntentId = paymentIntentId;
    }
  }

  String? get customerId => _customerId;
  set customerId(String? customerId) => _customerId = customerId;
  String? get clientSecret => _clientSecret;
  set clientSecret(String? clientSecret) => _clientSecret = clientSecret;
  String? get ephemeralKey => _ephemeralKey;
  set ephemeralKey(String? ephemeralKey) => _ephemeralKey = ephemeralKey;
  String? get paymentIntentId => _paymentIntentId;
  set paymentIntentId(String? paymentIntentId) =>
      _paymentIntentId = paymentIntentId;

  Payload.fromJson(Map<dynamic, dynamic> json) {
    _customerId = json['customer_id'];
    _clientSecret = json['client_secret'];
    _ephemeralKey = json['ephemeral_key'];
    _paymentIntentId = json['payment_intent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this._customerId;
    data['client_secret'] = this._clientSecret;
    data['ephemeral_key'] = this._ephemeralKey;
    data['payment_intent_id'] = this._paymentIntentId;
    return data;
  }
}
