class VendorGetScheduleResponse {
  int? _status;
  String? _msg;
  List<Payload>? _payload;

  VendorGetScheduleResponse(
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

  VendorGetScheduleResponse.fromJson(Map<dynamic, dynamic> json) {
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
  bool? _isMonday;
  bool? _isTuesday;
  bool? _isWednesday;
  bool? _isThursday;
  bool? _isFriday;
  bool? _isSaturday;
  bool? _isSunday;
  String? _fromTime;
  String? _toTime;
  bool? _isSetStatus;

  Payload(
      {bool? isMonday,
        bool? isTuesday,
        bool? isWednesday,
        bool? isThursday,
        bool? isFriday,
        bool? isSaturday,
        bool? isSunday,
        String? fromTime,
        String? toTime,
        bool? isSetStatus}) {
    if (isMonday != null) {
      this._isMonday = isMonday;
    }
    if (isTuesday != null) {
      this._isTuesday = isTuesday;
    }
    if (isWednesday != null) {
      this._isWednesday = isWednesday;
    }
    if (isThursday != null) {
      this._isThursday = isThursday;
    }
    if (isFriday != null) {
      this._isFriday = isFriday;
    }
    if (isSaturday != null) {
      this._isSaturday = isSaturday;
    }
    if (isSunday != null) {
      this._isSunday = isSunday;
    }
    if (fromTime != null) {
      this._fromTime = fromTime;
    }
    if (toTime != null) {
      this._toTime = toTime;
    }
    if (isSetStatus != null) {
      this._isSetStatus = isSetStatus;
    }
  }

  bool? get isMonday => _isMonday;
  set isMonday(bool? isMonday) => _isMonday = isMonday;
  bool? get isTuesday => _isTuesday;
  set isTuesday(bool? isTuesday) => _isTuesday = isTuesday;
  bool? get isWednesday => _isWednesday;
  set isWednesday(bool? isWednesday) => _isWednesday = isWednesday;
  bool? get isThursday => _isThursday;
  set isThursday(bool? isThursday) => _isThursday = isThursday;
  bool? get isFriday => _isFriday;
  set isFriday(bool? isFriday) => _isFriday = isFriday;
  bool? get isSaturday => _isSaturday;
  set isSaturday(bool? isSaturday) => _isSaturday = isSaturday;
  bool? get isSunday => _isSunday;
  set isSunday(bool? isSunday) => _isSunday = isSunday;
  String? get fromTime => _fromTime;
  set fromDate(String? fromTime) => _fromTime = fromTime;
  String? get toTime => _toTime;
  set toDate(String? toTime) => _toTime = toTime;
  bool? get isSetStatus => _isSetStatus;
  set isSetStatus(bool? isSetStatus) => _isSetStatus = isSetStatus;

  Payload.fromJson(Map<String, dynamic> json) {
    _isMonday = json['is_monday'];
    _isTuesday = json['is_tuesday'];
    _isWednesday = json['is_wednesday'];
    _isThursday = json['is_thursday'];
    _isFriday = json['is_friday'];
    _isSaturday = json['is_saturday'];
    _isSunday = json['is_sunday'];
    _fromTime = json['from_time'];
    _toTime = json['to_time'];
    _isSetStatus = json['is_set_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_monday'] = this._isMonday;
    data['is_tuesday'] = this._isTuesday;
    data['is_wednesday'] = this._isWednesday;
    data['is_thursday'] = this._isThursday;
    data['is_friday'] = this._isFriday;
    data['is_saturday'] = this._isSaturday;
    data['is_sunday'] = this._isSunday;
    data['from_time'] = this._fromTime;
    data['to_time'] = this._toTime;
    data['is_set_status'] = this._isSetStatus;
    return data;
  }
}
