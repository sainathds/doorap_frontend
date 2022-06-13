class FacilityListResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  FacilityListResponse({int? status, String? msg, List<Payload>? payload}) {
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

  FacilityListResponse.fromJson(Map<dynamic, dynamic> json) {
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
  int? _fkService;
  String? _facilityName;
  bool? _isSelected = false;


  Payload({int? id, int? fkService, String? facilityName, bool? isSelected}) {
    if (id != null) {
      this._id = id;
    }
    if (fkService != null) {
      this._fkService = fkService;
    }
    if (facilityName != null) {
      this._facilityName = facilityName;
    }
    if (isSelected != null) {
      this._isSelected = isSelected;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get fkService => _fkService;
  set fkService(int? fkService) => _fkService = fkService;
  String? get facilityName => _facilityName;
  set facilityName(String? facilityName) => _facilityName = facilityName;
  bool? get isSelected => _isSelected;
  set isSelected(bool? isSelected) => _isSelected = isSelected;

  Payload.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fkService = json['fk_service'];
    _facilityName = json['facility_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fk_service'] = this._fkService;
    data['facility_name'] = this._facilityName;
    return data;
  }
}
