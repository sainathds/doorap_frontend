class CountryListResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  CountryListResponse({int? status, String? msg, List<Payload>? payload}) {
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

  CountryListResponse.fromJson(Map<dynamic, dynamic> json) {
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
  String? _countryName;
  String? _countryCode;
  bool? _status;

  Payload({int? id, String? countryName, String? countryCode, bool? status}) {
    if (id != null) {
      this._id = id;
    }
    if (countryName != null) {
      this._countryName = countryName;
    }
    if (countryCode != null) {
      this._countryCode = countryCode;
    }
    if (status != null) {
      this._status = status;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get countryName => _countryName;
  set countryName(String? countryName) => _countryName = countryName;
  String? get countryCode => _countryCode;
  set countryCode(String? countryCode) => _countryCode = countryCode;
  bool? get status => _status;
  set status(bool? status) => _status = status;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _countryName = json['country_name'];
    _countryCode = json['country_code'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['country_name'] = this._countryName;
    data['country_code'] = this._countryCode;
    data['status'] = this._status;
    return data;
  }


  ///this method will prevent the override of toString
  String countryAsString() {
    return '${this._countryName}';
  }
}
