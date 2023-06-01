class CustomerPaymentIntentRequest {
  int? _userId;
  int? _amount;
  String? _email;

  CustomerPaymentIntentRequest({int? userId, int? amount, String? email}) {
    if (userId != null) {
      this._userId = userId;
    }

    if (amount != null) {
      this._amount = amount;
    }

    if (email != null) {
      this._email = email;
    }
  }

  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  int? get amount => _amount;
  set amount(int? amount) => _amount = amount;
  String? get email => _email;
  set email(String? email) => _email = email;

  CustomerPaymentIntentRequest.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _amount = json['amount'];
    _email = json['email'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this._userId;
    data['amount'] = this._amount;
    data['email'] = this._email;
    return data;
  }
}
