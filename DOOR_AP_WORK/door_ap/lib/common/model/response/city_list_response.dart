class CityListResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  CityListResponse({int? status, String? msg, List<Payload>? payload}) {
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

  CityListResponse.fromJson(Map<dynamic, dynamic> json) {
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
  int? _fkCountryId;
  String? _cityName;
  bool? _status;

  Payload({int? id, int? fkCountryId, String? cityName, bool? status}) {
    if (id != null) {
      this._id = id;
    }
    if (fkCountryId != null) {
      this._fkCountryId = fkCountryId;
    }
    if (cityName != null) {
      this._cityName = cityName;
    }
    if (status != null) {
      this._status = status;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get fkCountryId => _fkCountryId;
  set fkCountryId(int? fkCountryId) => _fkCountryId = fkCountryId;
  String? get cityName => _cityName;
  set cityName(String? cityName) => _cityName = cityName;
  bool? get status => _status;
  set status(bool? status) => _status = status;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fkCountryId = json['fk_country_id'];
    _cityName = json['city_name'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fk_country_id'] = this._fkCountryId;
    data['city_name'] = this._cityName;
    data['status'] = this._status;
    return data;
  }

  String cityAsString() {
    return '${this._cityName}';
  }

}
